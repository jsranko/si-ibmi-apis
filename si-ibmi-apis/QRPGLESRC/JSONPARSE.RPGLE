       // (C)Copyright IBM Corp.  2018
       //
       // Permission is hereby granted, free of charge, to any person obtaining
       // a copy of this software and associated documentation files (the
       // "Software"), to deal in the Software without restriction, including
       // without limitation the rights to use, copy, modify, merge, publish,
       // distribute, sublicense, and/or sell copies of the Software, and to
       // permit persons to whom the Software is furnished to do so, subject
       // to the following conditions:
       //
       // The above copyright notice and this permission notice shall be
       // included in all copies or substantial portions of the Software.
       //
       // THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
       // EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
       // MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
       // NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
       // BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
       // ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
       // CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
       // SOFTWARE.
       //-----------------------------------------------------------------------
       // JSONPARSE - a JSON parser for RPG's DATA-INTO operation code
       //
       // Author: Eric Newman, 2017
       //
       // Application Details:
       // --------------------
       // JSONPARSE accepts valid JSON input according to the ECMA 404 JSON Data
       // Interchange standard found at www.JSON.org
       //
       // The parser expects the data in UCS-2 or UTF-16. The "ccsid=job"
       // option must not be specified for the DATA-INTO operation when this
       // parser is used.
       //
       // Options:
       // --------
       //
       // - For this parser, you must specify the options in the second operand
       //   of %PARSER as a character expression that is not simply a character
       //   variable
       //
       //    diagMessages=yes
       //      - if specified, a diagnostic message will be placed in the
       //        joblog when the parser is reporting that it found an error
       //    boolean=ind
       //      - if specified, the boolean JSON values (unquoted true and false)
       //        will be reported as indicator values '1' and '0'. Otherwise,
       //        they will be reported as 'true' and 'false' strings
       //
       // - For example,
       //      %PARSER(parserPgm : 'boolean=ind')
       //      %PARSER(parserPgm : 'diagMessages=yes')
       //      %PARSER(parserPgm : 'diagMessages=yes boolean=ind')
       //
       //   If the options are in a variable called "parserOpts", you must
       //   code %PARSER like this, to ensure that the options are seen as a
       //   and not as a character variable.
       //      %PARSER(parserPgm : parserOpts + '')
       //
       // Implementation Specific Notes:
       // ------------------------------
       // - JSONPARSE does not check to ensure that all Names are unique, and
       //   does not ensure, even after successful parsing, that all parsed
       //   data is syntactically correct. While some inconsistencies in JSON
       //   formatting might be associated with a given error code described
       //   below and handled during parsing, not all syntax issues will be
       //   accounted for during parsing.
       //
       // - JSON name and value elements have a maximum size of 8366550
       //   characters per element
       //
       // - There is a maximum nesting depth of 100 elements. For example,
       //   an entry {"NAME":"VAL"} has a depth of 1 whereas an entry such as
       //   {"NAME":{"INNERNAME":"VAL"}, "ARRAY":[1]} has a depth of 2, as the
       //   first object contains one inner object as well as one inner array,
       //   yet neither of the inner elements has any children meaning the
       //   lowest level for the entry would be 2.
       //
       // - The value null is always reported as an empty string value.
       //
       // Error codes:
       // ------------
       //   See the "Error Codes" section in the code below.
       //------------------------------------------------------------------

       // If adding additional copyrights to this source, add to the
       // COPYRIGHT keyword rather than replacing it
       ctl-opt copyright('(C)Copyright IBM Corp.  2018');
       ctl-opt option(*srcstmt);
       ctl-opt main(jsonParse);
       /if defined(*crtbndrpg)
          ctl-opt actgrp(*new);
       /endif

       /copy QOAR/QRPGLESRC,QrnDtaInto

       // True Token Types
       dcl-c STRING 'STRING';
       dcl-c NUM 'NUM';
       dcl-c END 'endfile';
       dcl-c MAYBE_BOOL_TRUE 'true';
       dcl-c MAYBE_BOOL_FALSE 'false';
       dcl-c MAYBE_NULL 'null';
       dcl-c SPACE 'SPACE';

       // Constants
       dcl-c NUMS %ucs2('0123456789-+Ee.');
       dcl-c A_TO_Z %ucs2('ABCDEFGHIJKLMNOPQRSTUVWXYZ+
                           abcdefghijklmnopqrstuvwxyz');
       dcl-c NUMENTRY %ucs2('0123456789-');
       dcl-c NONZERODIGIT %ucs2('123456789');
       dcl-c DIGIT %ucs2('0123456789');
       dcl-c DECIMAL %ucs2('.');
       dcl-c EXPONENT %ucs2('eE');
       dcl-c POSNEG %ucs2('-+');

       dcl-c INVALIDSTARTCHARS %ucs2(';+=_|/\!@#$%^&*()qweryuiopasdgh+
                                jklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM');
       dcl-c AFTERNUM %ucs2(' }]:,');
       dcl-c STARTCURLY %ucs2('{');
       dcl-c ENDCURLY %ucs2('}');
       dcl-c BRACKET %ucs2('[');
       dcl-c ENDBRACKET %ucs2(']');
       dcl-c QUOTE %ucs2('"');
       dcl-c BACKSLASH %ucs2('\');
       dcl-c FORWARDSLASH %ucs2('/');
       dcl-c BACKSPACE %ucs2(X'08');
       dcl-c FORMFEED %ucs2(X'0C');
       dcl-c TAB %ucs2(X'0B');
       dcl-c NEWLINE %ucs2(X'15');
       dcl-c CARRIAGE_RETURN %ucs2(X'0D');
       dcl-c CRLF %ucs2(x'0d25');

       // Escape Character Values
       dcl-c BACKSPACE_B %ucs2('b');
       dcl-c FORMFEED_F %ucs2('f');
       dcl-c NEWLINE_N %ucs2('n');
       dcl-c CARRIAGE_RETURN_R %ucs2('r');
       dcl-c TAB_T %ucs2('t');

       // Control Stack Identification Constants
       dcl-c JSON_NAME 'N';
       dcl-c JSON_VAL 'V';
       dcl-c JSON_OBJ 'O';
       dcl-c JSON_ARR 'A';
       dcl-c UNASSIGNED 'Z';
       dcl-c MAX_CSTACK 100;
       dcl-s stack_t char(1) template;

       // Error Codes
       // - When adding an error code, also add a subfield in the
       //   errorCodeMessages data structure, and increase the
       //   dimension of the "array" subfield
       dcl-c ERR_INPUT_TOO_SHORT        1;
       dcl-c ERR_UNFINISHED             2;
       dcl-c ERR_INVALID_STACK          3;
       dcl-c ERR_STACK_ERROR            4;
       dcl-c ERR_STACK_NOT_EMPTY        5;
       dcl-c ERR_INVALID_NAME_TYPE      6;
       dcl-c ERR_STACK_OVERFLOW         7;
       dcl-c ERR_STACK_ENTRY            8;
       dcl-c ERR_REMOVING_OBJECT        9;
       dcl-c ERR_INVALID_INPUT         10;
       dcl-c ERR_STRING_DATA           11;
       dcl-c ERR_INVALID_SPECIAL       12;
       dcl-c ERR_EXTRA_NUMERIC_SIGN    13;
       dcl-c ERR_INVALID_NUMBER        14;
       dcl-c ERR_TOO_MANY_EXPONENTS    15;
       dcl-c ERR_UNEXPECTED_DECPOINT   16;
       dcl-ds errorCodeMessages qualified;
          *n varchar(50) inz('01 Input data too short');
          *n varchar(50) inz('02 Document incomplete');
          *n varchar(50) inz('03 Control stack out of order');
          *n varchar(50) inz('04 Unexpected stack value');
          *n varchar(50) inz('05 Stack values remain unhandled');
          *n varchar(50) inz('06 Non-string where name should be');
          *n varchar(50) inz('07 Too many nested JSON elements');
          *n varchar(50) inz('08 Elements cannot be added to stack');
          *n varchar(50) inz('09 Elements cannot be removed');
          *n varchar(50) inz('10 Incorrect data in this context');
          *n varchar(50) inz('11 Invalid character in a string');
          *n varchar(50) inz('12 Special value not true/false/null');
          *n varchar(50) inz('13 + or - sign found within number');
          *n varchar(50) inz('14 Invalid character in a number');
          *n varchar(50) inz('15 Too many Exponents in a number');
          *n varchar(50) inz('16 Extra decimal point');
          *n varchar(50) inz('17 Invalid "null"');
          array varchar(50) dim(16) pos(1);
       end-ds;
       dcl-c ESCAPE_MESSAGE     '*ESCAPE';
       dcl-c DIAGNOSTIC_MESSAGE '*DIAG';

       // Other constants
       dcl-c CHAR_LEN 2; // This parser works in UCS-2
       dcl-c UCS2_CCSID 13488;
       dcl-c UTF16_CCSID 1200;

       // Token Data Structure
       dcl-ds token_t qualified template;
         type char(15);
         startPointer pointer;
         lengthInt uns(10) inz(0);
       end-ds;

       // Data Structure Representing a Control Panel for the Parser
       dcl-ds parseCtrl_t qualified template inz;
         maxLen uns(10);
         parserPointer pointer; //pointer to the token we are inspecting
         numberParsed uns(10) inz(CHAR_LEN); // to keep track of our position
         dcl-ds ctrlStk;
            objectReporting ind inz(*off);
            stack like(stack_t) inz(UNASSIGNED) dim(MAX_CSTACK);
            top int(5) inz(1);
            noStructure ind inz(*off);
         end-ds;
         curToken likeds(token_t);
         handle pointer;
         booleanIsIndicator ind;
         issueDiagMessages ind;
       end-ds;

       // Main procedure
       dcl-proc jsonParse;
          dcl-pi *n extpgm;
            inputParams likeds(QrnDiParm_T) const;
          end-pi;
          dcl-ds parseCtrl likeds(parseCtrl_t) inz(*likeds);

          // Set the parsing environment
          startParser(inputParams: parseCtrl : %proc());

          // Parse the document
          parseJSON(parseCtrl);

          // Finish parsing
          endParser(parseCtrl);

          return;
       end-proc;


       // START PARSER
       // startParser begins the parsing process
       // It takes the user data and places it in a local data structure
       // The local data structure holds important information in easily
       // accessible fields for use later
       // * If it finds an input with an invalid data length it ends the
       // program immediately.
       dcl-proc startParser;
         dcl-pi *n extproc(*dclcase);
           startingInputs likeds(QrnDiParm_T) const;
           parseCtrl likeds(parseCtrl_t);
           mainProcName varchar(100) const;
         end-pi;
         dcl-s options varchar(100);

         pQrnDiEnv = startingInputs.env;
         parseCtrl.handle = startingInputs.handle;
         if  startingInputs.dataCcsid <> UCS2_CCSID
         and startingInputs.dataCcsid <> UTF16_CCSID;
           // We can only parse if option "ccsid=ucs2" was specified!
           // Send an escape message in this case, since it's a user error
           issueMessage ('The ccsid option for %DATA must be ccsid=ucs2 '
                         + 'for this parser.'
                       : ESCAPE_MESSAGE
                       : mainProcName
                       : 2);
           return;
         endif;

         // The "start" function must be called before we can use
         // the "reportError" function
         QrnDiStart(parseCtrl.handle);

         if startingInputs.dataLen = 0;
           // didn't get any input, stop right there!
           reportError (parseCtrl : ERR_INPUT_TOO_SHORT);
           return;
         endif;

         // See if they specified any options
         if  startingInputs.userParm <> *null
         and startingInputs.userParmIsNullTermString;
           options = %str(startingInputs.userParm);

           if %scan('boolean=ind' : options) > 0;
             parseCtrl.booleanIsIndicator = *on;
           endif;

           if %scan('diagMessages=yes' : options) > 0;
             parseCtrl.issueDiagMessages = *on;
           endif;
         endif;

         parseCtrl.maxLen = startingInputs.dataLen;
         parseCtrl.parserPointer = startingInputs.data;
       end-proc;

       // END PARSER
       dcl-proc endParser;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         QrnDiFinish(parseCtrl.handle); // call for the parser to end
                                                 // and release its resources
       end-proc;

       // MAIN PARSE PROCEDURE
       // Utilizes the setToken procedure to tokenize JSON input
       // After setting the token, it then makes a decision on what to do based
       // on that token
       // It continues doing this until the setToken procedure sets the token
       // type to END or an error occurs
       dcl-proc parseJSON;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dou parseCtrl.curToken.type = END;
           setToken(parseCtrl);
           if parseCtrl.curToken.type = END;
             return;
           elseif parseCtrl.curToken.type = STRING;
             reportString(parseCtrl);
           elseif parseCtrl.curToken.type = NUM;
             reportNum(parseCtrl);
           elseif parseCtrl.curToken.type = MAYBE_BOOL_TRUE;
             reportSpecialValue(parseCtrl); //throw error if not found
           elseif parseCtrl.curToken.type = MAYBE_BOOL_FALSE;
             reportSpecialValue(parseCtrl); //throw error if not found
           elseif parseCtrl.curToken.type = MAYBE_NULL;
             reportSpecialValue(parseCtrl); //throw error if not found
           elseif parseCtrl.curToken.type = STARTCURLY;
             if parseCtrl.ctrlStk.top > 1;
               // If top = 1, this is the initial curly brace to begin
               // the JSON document. It does not match an RPG data structure.
               // So we only report the start of a structure if top > 1
               QrnDiStartStruct(parseCtrl.handle);
             endif;
             addObjToStack(parseCtrl);
           elseif parseCtrl.curtoken.type = ENDCURLY;
             removeObjFromStack(parseCtrl);
             if parseCtrl.ctrlStk.top > 1;
               // If top = 1, it matches the initial curly brace to begin
               // the JSON document. It did not match an RPG data structure.
               // So we only report the end of a structure if top > 1
               QrnDiEndStruct(parseCtrl.handle);
             endif;
           elseif parseCtrl.curtoken.type = BRACKET;
             QrnDiStartArray(parseCtrl.handle);
             addArrayToStack(parseCtrl);
           elseif parseCtrl.curtoken.type = ENDBRACKET;
             removeArrayFromStack(parseCtrl);
             QrnDiEndArray(parseCtrl.handle);
           endif;
         enddo;
       on-exit;
         // check to make sure all data structures have been closed
         if parseCtrl.ctrlStk.top > 1;
           if parseCtrl.curToken.type = END;
             reportError (parseCtrl : ERR_STACK_NOT_EMPTY);
           else;
             return;
           endif;
         endif;
         parseCtrl.parserPointer = parseCtrl.parserPointer -
                                      parseCtrl.maxLen;
       end-proc;

       // SET TOKEN PROCEDURE
       // Performs lexical analysis of input (analyzes doc character by
       // character)
       // During the lexical analysis, the parser checks one character at
       // a time, avoiding the need to save the data in separate storage
       // By incrementing the steps after assessing a given lexicon,
       // checking the number of steps each time the parser can ensure
       // it remains below the input data size throughout its lifespan.
       dcl-proc setToken;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dcl-s onOff ind inz(*on);
         dcl-s tokenPointer pointer;
         dcl-s dataChar ucs2(1) based(tokenPointer);
         dcl-s stackChar ucs2(1);
         tokenPointer = parseCtrl.parserPointer;
         if parseCtrl.numberParsed > parseCtrl.maxLen;
           // emergency stop if supposedly beyond allocated data area
           parseCtrl.curToken.type = END;
           return;
         elseif parseCtrl.numberParsed = parseCtrl.maxLen;
           // check for the last character in the input data
           if dataChar = ENDCURLY;
             // end curly brace is acceptable JSON for the last character
             parseCtrl.curToken.type = ENDCURLY;
             parseCtrl.numberParsed += CHAR_LEN;
             return;
           elseif dataChar = ENDBRACKET;
             // end bracket is acceptable JSON for the last character
             parseCtrl.curToken.type = ENDBRACKET;
             parseCtrl.numberParsed += CHAR_LEN;
             return;
           elseif parseCtrl.ctrlStk.top = 1
              and %scan(dataChar:NUMENTRY) > 0;
             // if the ctrlStk.top is still at one (its initial value), we
             // can accept a number
             parseCtrl.curToken.type = NUM;
             reportNum(parseCtrl);
             parseCtrl.curToken.type = END;
             return;
           else;
             // any other input is not acceptable as if a string has been
             // encountered, we would not reach this position invalidating
             // an end quote as acceptable JSON.
             parseCtrl.curToken.type = END;
             return;
           endif;
         elseif dataChar = 't';
           // check to see if the input is the boolean value 'true'
           parseCtrl.curToken.type = MAYBE_BOOL_TRUE;
           return;
         elseif dataChar = 'f';
           // check to see if the input is the boolean value 'false'
           parseCtrl.curToken.type = MAYBE_BOOL_FALSE;
           return;
         elseif dataChar = 'n';
           // check to see if the input is the value 'null'
           parseCtrl.curToken.type = MAYBE_NULL;
           return;
         elseif dataChar = STARTCURLY;
           // check to see if the start curly brace is the data character
           // If this is the initial curly brace to enclose the JSON document,
           // don't report it as a structure. Save it as STARTDOCUMENT,
           // so we'll know how to handle the end-curly brace later
           parseCtrl.curToken.type = STARTCURLY;
           parseCtrl.numberParsed += CHAR_LEN;
           parseCtrl.parserPointer += CHAR_LEN;
           return;
         elseif dataChar = ENDCURLY;
           // check to see if the end curly brace is the data character
           parseCtrl.curToken.type = ENDCURLY;
           parseCtrl.numberParsed += CHAR_LEN;
           parseCtrl.parserPointer += CHAR_LEN;
           return;
         elseif dataChar = QUOTE;
           // check to see if the data character is a quote mark
           parseCtrl.curToken.type = STRING;
           return;
         elseif %scan(dataChar:NUMENTRY) > 0;
           // check to see if the data character is a valid numeric value
           parseCtrl.curToken.type = NUM;
           return;
         elseif dataChar = BRACKET;
           // check to see if the data character is the open bracket symbol
           parseCtrl.curToken.type = BRACKET;
           parseCtrl.numberParsed += CHAR_LEN;
           parseCtrl.parserPointer += CHAR_LEN;
           return;
         elseif dataChar = ENDBRACKET;
           // check to see if the data character is the end bracket symbol
           parseCtrl.curToken.type = ENDBRACKET;
           parseCtrl.numberParsed += CHAR_LEN;
           parseCtrl.parserPointer += CHAR_LEN;
           return;
         elseif %scan(dataChar:INVALIDSTARTCHARS) > 0;
           // check to see if the data character is NOT acceptable JSON in its
           // current position
           if %scan(dataChar: A_TO_Z) > 0;
              // It starts with an alphabetic character
              // That's only valid for the special values true, false, null
              reportError (parseCtrl : ERR_INVALID_SPECIAL);
           else;
              reportError (parseCtrl : ERR_STRING_DATA);
           endif;
           return;
         else;
           // else the character is likely a 'filler'.
           // 'Fillers' include commas, whitespaces, line feeds, new lines, etc.
           // that have no syntax value
           parseCtrl.curToken.type = SPACE;
           parseCtrl.numberParsed += CHAR_LEN;
           parseCtrl.parserPointer += CHAR_LEN;
           return;
         endif;
       end-proc;

       // REPORT SPECIAL VALUE
       // Called when the lexical analyzer reports that a bool (true or false)
       // or null may have been encountered
       // If it encounters an unexpected character during parsing it throws an
       // error
       dcl-proc reportSpecialValue;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dcl-s tokenPointer pointer;
         dcl-s checkLen uns(5);
         dcl-s dataChar ucs2(1) based(tokenPointer);
         dcl-s maybeTrue ucs2(4) based(tokenPointer);
         dcl-s maybeFalse ucs2(5) based(tokenPointer);
         dcl-s maybeNull ucs2(4) based(tokenPointer);

         tokenPointer = parseCtrl.parserPointer;
         if parseCtrl.curToken.type = MAYBE_BOOL_TRUE;
           // check to see if the current input is the 'true' boolean value
           checkLen = parseCtrl.maxLen - (parseCtrl.numberParsed - 1);
           if checkLen >= 4 * CHAR_LEN;
             checkLen = 4 * CHAR_LEN;
             if maybeTrue <> 'true';
               // If there's an unquoted "t", it can only be "true"
               reportError (parseCtrl: ERR_INVALID_SPECIAL);
               return;
             endif;
           else;
             // The remaining text is too short to fit "true"
             reportError (parseCtrl: ERR_INVALID_SPECIAL);
           endif;
         elseif parseCtrl.curToken.type = MAYBE_BOOL_FALSE;
           // check to see if the current input is the 'false' boolean value
           checkLen = parseCtrl.maxLen -
                      (parseCtrl.numberParsed - CHAR_LEN);
           if checkLen >= 5 * CHAR_LEN;
             checkLen = 5 * CHAR_LEN;
             if maybeFalse <> 'false';
               // If there's an unquoted 'f', it can only be "false"
               reportError (parseCtrl: ERR_INVALID_SPECIAL);
             endif;
           else;
             // The remaining text is too short to fit "false"
             reportError (parseCtrl: ERR_INVALID_SPECIAL);
           endif;
         elseif parseCtrl.curToken.type = MAYBE_NULL;
           // check to see if the current input is the 'null' value
           checkLen = parseCtrl.maxLen -
                      (parseCtrl.numberParsed - CHAR_LEN);
           if checkLen >= 4 * CHAR_LEN;
             checkLen = 4 * CHAR_LEN;
             if maybeNull <> 'null';
               // If there's an unquoted 'n', it can only be "null"
               reportError (parseCtrl: ERR_INVALID_SPECIAL);
             endif;
           else;
             // The remaining text is too short to fit "null"
             reportError (parseCtrl: ERR_INVALID_SPECIAL);
           endif;
         endif;

         // We have 'true' or 'false'
         parseCtrl.curToken.startPointer = parseCtrl.parserPointer;
         parseCtrl.curToken.lengthInt = checkLen;
         tokenPointer += checkLen;
         reportNameVal(parseCtrl);
         if parseCtrl.numberParsed + checkLen < parseCtrl.maxLen;
           parseCtrl.numberParsed += checkLen;
           parseCtrl.parserPointer = tokenPointer;
         endif;
         return;
       end-proc;


       // ADD OBJECT TO STACK
       // This is responsible for adding objects to the control stack when
       // they are encountered
       // First checks to see if the stack is capable of handling another entry
       // Then removes previous expected value entries and changes them to
       // expect name entries
       // Finally adds the object to the stack and increments if necessary
       // If it is successful in adding the object, it also adds an expected
       // name entry after it
       dcl-proc addObjToStack;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         if parseCtrl.ctrlStk.top < MAX_CSTACK;
           // Before moving in to make changes, if we notice that the object is
           // supposed to be a name
           // element, we can simply stop and throw an error as this is not
           // acceptable by the JSON standard
           if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_NAME;
             reportError (parseCtrl: ERR_STACK_ENTRY);
           endif;
           // First ensure that we are within the acceptable size limits of the
           // stack
           if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_VAL;
             // If expecting Json 'Value' element as seen by top of the stack,
             // change it to show the obj
             // we are adding is the value, and that the parser should expect a
             // 'Name' following the obj
             parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_NAME;
           endif;
           if parseCtrl.ctrlStk.top = 1;
             if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
               // If we get here, we've found an array in the first position of
               // our JSON input
               // We need to move past this entry in the stack and place the
               // object after it
               parseCtrl.ctrlStk.top += 1;
               parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_OBJ;
             elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) =
                                                                    UNASSIGNED;
               // We have found nothing in the stack we need to worry about
               // replacing, just add obj
               parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_OBJ;
             else;
               // If we find something other than an array, or obj in the first
               // position we cannot add
               // entries after it so this would be an error situation
               reportError (parseCtrl: ERR_STACK_ENTRY);
             endif;
           else;
             parseCtrl.ctrlStk.top += 1;
             parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_OBJ;
           endif;
         else;
           reportError (parseCtrl: ERR_STACK_OVERFLOW);
         endif;

         if parseCtrl.ctrlStk.top < MAX_CSTACK;
           parseCtrl.ctrlStk.top += 1;
           parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_NAME;
         else;
           reportError (parseCtrl: ERR_STACK_OVERFLOW);
         endif;
       end-proc;

       // REMOVE OBJECT FROM CONTROL STACK
       // Responsible for removing objects from the stack, removes entire
       // object entry and its children
       dcl-proc removeObjFromStack;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dcl-s endFound ind inz(*off);
         if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_OBJ;
           // When we enter this block, the object in question is empty
           parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = UNASSIGNED;
           if parseCtrl.ctrlStk.top > 1;
             parseCtrl.ctrlStk.top -= 1;
           endif;
         elseif parseCtrl.ctrlStk.top = 1;
           // If we do not find an object in the first position, we have an
           // error situation due to JSON syntax requirements.
           reportError (parseCtrl: ERR_REMOVING_OBJECT);
         else;
           dou parseCtrl.ctrlStk.top = 1 or endFound;
             if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_OBJ;
               // Similar to the first if statement in the procedure, this
               // control statement checks to see
               // whether we have found the object we seek to remove at the
               // stack location identified by
               // the control panel's stack top variable in the current
               // iteration of the do until loop.
               parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = UNASSIGNED;
               parseCtrl.ctrlStk.top -= 1;
               endFound = *on;
             elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_NAME;
               // This catches situations where the parser is encountering the
               // end of an object after a
               // value has been reported, which is acceptable and can be
               // handled by moving the stack
               // back one value after setting the position to the default
               // 'unassigned' value.
               parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = UNASSIGNED;
               parseCtrl.ctrlStk.top -= 1;
             elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_VAL;
               // If a name has been reported and the parser is expecting a
               // value as determined by the contents of the stack, we should
               // not be removing an object as that JSON name's value has not
               // been reported and so the JSON pair cannot be completed.
               reportError (parseCtrl: ERR_REMOVING_OBJECT);
               return;
             elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
               // If an array is encountered on the stack before an object
               // value is found to remove, we have a JSON syntax error in the
               // input as the array in question should have been closed
               // already resulting in an error reported.
               reportError (parseCtrl: ERR_REMOVING_OBJECT);
               return;
             else;
               parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = UNASSIGNED;
               parseCtrl.ctrlStk.top -= 1;
             endif;
           enddo;
         endif;
       end-proc;

       // ADD ARRAY ELEMENT TO CONTROL STACK
       // Responsible for adding Array Elements and their expected value child
       // entries to the control stack
       dcl-proc addArrayToStack;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         if parseCtrl.ctrlStk.top < MAX_CSTACK;
           if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_VAL;
             // In JSON, an array can be a value in a Name Value pair situation,
             // meaning we need to let the parser know in this situation that
             // we have found the value in question for the pair so that after
             // completing the array we can re-enter parsing as normal.
             parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_NAME;
             if parseCtrl.ctrlStk.top = 1;
               reportError (parseCtrl: ERR_STACK_ENTRY);
               // This would be an error situation as we would have a value
               // reported in the first position without having encountered any
               // objects, meaning it would be in error of the JSON standards
               // to accept any further arrays.
             else;
               parseCtrl.ctrlStk.top += 1;
               parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
             endif;
           elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = UNASSIGNED;
             parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
           elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
             parseCtrl.ctrlStk.top += 1;
             parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
           elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_OBJ;
             parseCtrl.ctrlStk.top += 1;
             parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
           else;
             reportError (parseCtrl: ERR_STACK_ENTRY);
           endif;
         else;
           reportError (parseCtrl: ERR_STACK_OVERFLOW);
         endif;
       end-proc;

       // REMOVE ARRAY ELEMENT FROM CONTROL STACK
       // Responsible for removing Array Elements and their children from the
       // stack
       dcl-proc removeArrayFromStack;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         if parseCtrl.ctrlStk.top = 1;
           if parseCtrl.ctrlStk.stack(1) = UNASSIGNED;
             reportError (parseCtrl : ERR_INVALID_STACK);
           elseif parseCtrl.ctrlStk.stack(1) = JSON_ARR;
             parseCtrl.ctrlStk.stack(1) = UNASSIGNED;
           else;
             reportError (parseCtrl: ERR_INVALID_STACK);
           endif;
         elseif parseCtrl.ctrlStk.top > 1;
           if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_ARR;
             parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = UNASSIGNED;
             parseCtrl.ctrlStk.top -= 1;
           else;
             reportError (parseCtrl: ERR_INVALID_STACK);
           endif;
         endif;
       end-proc;

       // CHANGE EXPECTED VALUE ON STACK
       // This procedure is utilized when names or values are reported
       // It enables us to keep track of whether we should report names or
       // values in complex JSON inputs
       dcl-proc changeExpectedVal;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         if parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_NAME;
           parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_VAL;
         elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_VAL;
           parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = JSON_NAME;
         elseif parseCtrl.ctrlStk.stack(parseCtrl.ctrlStk.top) = UNASSIGNED;
           parseCtrl.ctrlStk.noStructure = *on;
         else;
           reportError (parseCtrl: ERR_STACK_ERROR);
         endif;
       end-proc;

       // REPORT NUMBER
       // The report number procedure is responsible for reporting numeric
       // values
       dcl-proc reportNum;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dcl-s parseNum varucs2(65);
         dcl-s tokenPointer pointer;
         dcl-s dataChar ucs2(1) based(tokenPointer);
         dcl-s done ind inz(*off);
         dcl-s position uns(10) inz(0);
         dcl-s negInd ind inz(*off);
         dcl-s fracInd ind inz(*off);
         dcl-s expInd ind inz(*off);
         dcl-s zeroStart ind inz(*off);
         tokenPointer = parseCtrl.parserPointer;
         parseCtrl.curToken.startPointer = tokenPointer;
         parseCtrl.curToken.lengthInt = CHAR_LEN;
         parseNum = parseNum + dataChar;
         if parseCtrl.numberParsed < parseCtrl.maxLen;
           dou parseCtrl.numberParsed = parseCtrl.maxLen or done;
             if parseCtrl.curToken.lengthInt = CHAR_LEN and dataChar = '0';
               zeroStart = *on;
             endif;
             parseCtrl.numberParsed += CHAR_LEN;
             tokenPointer += CHAR_LEN;
             parseCtrl.curToken.lengthInt += CHAR_LEN;
             position += CHAR_LEN;
             IF parseCtrl.curToken.lengthInt > CHAR_LEN;
               // if not the first character we check for positive and negative
               // symbols
               if %scan(dataChar:POSNEG) > 0;
                 if expInd;
                 // shouldn't be any positive or negative signs unless starting
                 // a number or after exp
                 else;
                   // found an positive or negative symbol after the beggining
                   // and without an exponent
                   reportError (parseCtrl: ERR_EXTRA_NUMERIC_SIGN);
                 endif;
               endif;
             endif;
             if parseCtrl.curToken.lengthInt = (2 * CHAR_LEN)
             and %scan(dataChar: DIGIT) > 0 and zeroStart;
               reportError (parseCtrl: ERR_INVALID_NUMBER);
             endif;
             if %scan(dataChar: EXPONENT) > 0;
               if expInd;
                 // too many exponent declarations encountered
                 reportError (parseCtrl: ERR_TOO_MANY_EXPONENTS);
               else;
                 expInd = *on;
               endif;
             endif;
             if %scan(dataChar: DECIMAL) > 0;
               if fracInd or expInd;
                 // too many decimal symbols encountered OR found a fraction
                 // after an exponent
                 reportError (parseCtrl: ERR_UNEXPECTED_DECPOINT);
               else;
                 fracInd = *on;
               endif;
             endif;
             IF %scan(dataChar:NUMS) <= 0;
               // if we find something other than a number we end up here!
               if %scan(dataChar:AFTERNUM) <= 0
               and %scan(dataChar: CRLF + NEWLINE) <= 0; // End of line?
                 reportError (parseCtrl: ERR_INVALID_NUMBER);
               else;
                 parseCtrl.numberParsed -= CHAR_LEN;
                 parseCtrl.curToken.lengthInt -= CHAR_LEN;
                 done = *on;
               endif;
             ELSE;
               // if we find a number though, just continue!
               parseNum = parseNum + dataChar;
             endif;
           enddo;
         endif;
         if done;
           parseCtrl.curToken.startPointer = %addr(parseNum: *DATA);
           reportNameVal(parseCtrl);
         else;
           if parseCtrl.curToken.lengthInt >= CHAR_LEN;
             parseCtrl.curToken.startPointer = %addr(parseNum: *DATA);
             reportNameVal(parseCtrl);
             parseCtrl.curToken.type = END;
           else;
             return;
           endif;
         endif;
         parseCtrl.parserPointer = tokenPointer;
       end-proc;

       // REPORT STRING
       // Reports string values for the main parse procedure
       dcl-proc reportString;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dcl-s tokenPointer pointer;
         dcl-s dataChar ucs2(1) based(tokenPointer);
         dcl-s backslashEscapeFound ind inz(*off);
         dcl-s done ind inz(*off);
         tokenPointer = parseCtrl.parserPointer;
         parseCtrl.curToken.lengthInt = 0;
         done = *off;
         if parseCtrl.numberParsed < parseCtrl.maxLen;
           tokenPointer += CHAR_LEN;
           if dataChar = QUOTE;
             // in case we encounter an empty string we search for
             // the quote right away
             tokenPointer -= CHAR_LEN;
             parseCtrl.curToken.startPointer = tokenPointer;
             parseCtrl.curToken.lengthInt = 0;
             parseCtrl.numberParsed += CHAR_LEN;
             reportNameVal(parseCtrl);
             return;
           endif;
           // if quote is not found, set starting pointer to the value found
           parseCtrl.curToken.startPointer = tokenPointer;
           tokenPointer -= CHAR_LEN;
         endif;
         dou parseCtrl.numberParsed = parseCtrl.maxLen or done;
           parseCtrl.numberParsed += CHAR_LEN;
           tokenPointer += CHAR_LEN;
           parseCtrl.curToken.lengthInt += CHAR_LEN;
           if dataChar = BACKSLASH;
             backslashEscapeFound = *on;
             done = *on;
             parseCtrl.curToken.lengthInt -= CHAR_LEN;
           elseif dataChar = QUOTE;
             done = *on;
           endif;
         enddo;
         if dataChar = QUOTE;
           if backslashEscapeFound  = *on;
             parseCtrl.numberParsed -= parseCtrl.curToken.lengthInt;
             backslashHandler(parseCtrl);
             return;
           else;
             parseCtrl.curToken.lengthInt -= CHAR_LEN;
             reportNameVal(parseCtrl);
               if parseCtrl.numberParsed = parseCtrl.maxLen;
                 parseCtrl.curToken.type = END;
                 parseCtrl.parserPointer = tokenPointer;
                 // end found - set token type, first check in setToken is for
                 // the END type
                 return;
               else;
                 tokenPointer += CHAR_LEN;
                 parseCtrl.numberParsed += CHAR_LEN;
                 parseCtrl.parserPointer = tokenPointer;
                 return;
               endif;
           endif;
         elseif parseCtrl.numberParsed = parseCtrl.maxLen;
           reportError (parseCtrl: ERR_UNFINISHED);
         endif;
       end-proc;

       // ESCAPED STRING HANDLING PROCEDURE
       // Reports a backslash string value for the reportString function when
       // encountered
       dcl-proc backslashHandler;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dcl-s parseString pointer;
         dcl-s tokenPointer pointer;
         dcl-s dataChar ucs2(1) based(tokenPointer);
         dcl-s parseChar ucs2(1) based(parseString);
         dcl-s backslashEscapeFound ind inz(*off);
         dcl-s done ind inz(*off);
         tokenPointer = parseCtrl.parserPointer;
         parseString = %alloc(parseCtrl.maxLen - parseCtrl.numberParsed);
         parseCtrl.curToken.lengthInt = 0;
         done = *off;
         dou parseCtrl.numberParsed = parseCtrl.maxLen or done;
           parseCtrl.numberParsed += CHAR_LEN;
           tokenPointer += CHAR_LEN;
           parseCtrl.curToken.lengthInt += CHAR_LEN;
           if dataChar = BACKSLASH;
             backslashEscapeFound = *on;
             parseCtrl.curToken.lengthInt -= CHAR_LEN;
           // need to remove below elseif after completion of escapeString
           // procedure
           elseif backslashEscapeFound = *on;
             // found forward slash on previous character
             if dataChar = QUOTE
             or dataChar = FORWARDSLASH
             or dataChar = BACKSPACE
             or dataChar = FORMFEED;
               backslashEscapeFound = *off;
               parseChar = dataChar;
               parseString += CHAR_LEN;
             elseif dataChar = TAB
                 or dataChar = NEWLINE
                 or dataChar = CARRIAGE_RETURN;
               backslashEscapeFound = *off;
               parseChar = dataChar;
               parseString += CHAR_LEN;
             elseif dataChar = BACKSPACE_B
                 or dataChar = FORMFEED_F
                 or dataChar = NEWLINE_N;
               backslashEscapeFound = *off;
               parseChar = dataChar;
               parseString += CHAR_LEN;
             elseif dataChar = CARRIAGE_RETURN_R
                 or dataChar = TAB_T;
               backslashEscapeFound = *off;
               parseChar = dataChar;
               parseString += CHAR_LEN;
             else;
               // Can accept anything following slash with following else...
               // May need adjustment
               backslashEscapeFound = *off;
               parseChar = dataChar;
               parseString += CHAR_LEN;
             endif;
           elseif dataChar = QUOTE;
             done = *on;
           else;
             // No forward slash, QUOTE or end of data to finish loop,
             // continue parsing
             parseChar = dataChar;
             parseString += CHAR_LEN;
           endif;
         enddo;
         if dataChar = QUOTE;
           parseCtrl.curToken.lengthInt -= CHAR_LEN;
           parseString -= parseCtrl.curToken.lengthInt;
           parseCtrl.curToken.startPointer = parseString;
           reportNameVal(parseCtrl);
           if parseCtrl.numberParsed = parseCtrl.maxLen;
             parseCtrl.curToken.type = END;
             parseCtrl.parserPointer = tokenPointer;
             // end found - set token type, first check in setToken is for the
             // END type
             return;
           else;
             tokenPointer += CHAR_LEN;
             parseCtrl.numberParsed += CHAR_LEN;
             parseCtrl.parserPointer = tokenPointer;
             return;
           endif;
         elseif parseCtrl.numberParsed = parseCtrl.maxLen;
           reportError (parseCtrl: ERR_UNFINISHED);
         endif;
       on-exit;
          dealloc parseString;
       end-proc;

       // REPORT NAME VALUE
       // Reports a name or value token as directed by the stack
       // Calls to adjust the stack top after reporting in some scenarios
       dcl-proc reportNameVal;
         dcl-pi *n extproc(*dclcase);
           parseCtrl likeds(parseCtrl_t);
         end-pi;
         dcl-s stackTop like(stack_t);
         dcl-s stackTopPos int(3);
         dcl-s controlCharacter ucs2(1);
         dcl-s indVal varucs2(5); // big enough to hold "false"
         dcl-s nullVal varucs2(1);

         stackTopPos = parseCtrl.ctrlStk.top;
         stackTop = parseCtrl.ctrlStk.stack(stackTopPos);
         if stackTop = JSON_ARR;
           QrnDiReportValue(parseCtrl.handle
                          : parseCtrl.curToken.startPointer
                          : parseCtrl.curToken.lengthInt);
         elseif stackTop = JSON_NAME;
           if parseCtrl.curToken.type = STRING;
             QrnDiReportName(parseCtrl.handle
                           : parseCtrl.curToken.startPointer
                           : parseCtrl.curToken.lengthInt);
             changeExpectedVal(parseCtrl);
           else;
             reportError (parseCtrl: ERR_INVALID_NAME_TYPE);
           endif;
         elseif stackTop = JSON_VAL;
           select;
           when parseCtrl.curToken.type = MAYBE_BOOL_TRUE;
             if parseCtrl.booleanIsIndicator;
                indVal = '1';
             else;
                indVal = 'true';
             endif;
             QrnDiReportValue (parseCtrl.handle
                             : %addr(indVal : *data)
                             : %len(indVal) * 2);
           when parseCtrl.curToken.type = MAYBE_BOOL_FALSE;
             if parseCtrl.booleanIsIndicator;
                indVal = '0';
             else;
                indVal = 'false';
             endif;
             QrnDiReportValue (parseCtrl.handle
                             : %addr(indVal : *data)
                             : %len(indVal) * 2);
           when parseCtrl.curToken.type = MAYBE_NULL;
             // Report "null" as an empty string
             %len(nullVal) = 0;
             QrnDiReportValue (parseCtrl.handle
                             : %addr(nullVal : *data)
                             : 0);
           other;
             // It's not a special value
             QrnDiReportValue (parseCtrl.handle
                             : parseCtrl.curToken.startPointer
                             : parseCtrl.curToken.lengthInt);
           endsl;
           changeExpectedVal(parseCtrl);
         // no object or array encountered
         elseif stackTop = UNASSIGNED;
           if parseCtrl.ctrlStk.noStructure = *on;
             reportError (parseCtrl: ERR_INVALID_INPUT);
           elseif stackTopPos = 1;
             QrnDiReportValue(parseCtrl.handle
              :parseCtrl.curToken.startPointer
              :parseCtrl.curToken.lengthInt);
             changeExpectedVal(parseCtrl);
           else;
             reportError (parseCtrl: ERR_INVALID_INPUT);
           endif;
         else;
           QrnDiReportValue (parseCtrl.handle
                           : parseCtrl.curToken.startPointer
                           : parseCtrl.curToken.lengthInt);
         endif;
       end-proc;

       // REPORT ERROR
       dcl-proc reportError;
          dcl-pi *n extproc(*dclcase);
             parseCtrl likeds(parseCtrl_t);
             errorCode int(10) value;
          end-pi;

          if parseCtrl.issueDiagMessages;
            // For the following call, the stack entry
            // '*' represents the "issueMessage" stack
            // entry, so a stack offset of 2 from that
            // is the caller of this function
            issueMessage (errorCodeMessages.array(errorCode)
                        : DIAGNOSTIC_MESSAGE
                        : '*' : 2); // Send to my caller
          endif;

          QrnDiReportError (parseCtrl.handle
                          : errorCode
                          : parseCtrl.numberParsed);
          // Control will not reach here
       end-proc;

       // ISSUE MESSAGE
       // Sends a diagnostic or escape message
       dcl-proc issueMessage;
         dcl-pi *n extproc(*dclcase);
           msg varchar(200) const;
           msgType char(10) const;
           proc varchar(200) const;
           stackOffset int(10) const;
         end-pi;
         dcl-pr QMHSNDPM extpgm;
           msgId char(7) const;
           msgFile likeds(qualMsgf);
           msgData char(500) const;
           dataLen int(10) const;
           msgType char(10) const;
           stackEntry char(10) const;
           stackOffset int(10) const;
           msgKey char(4) const;
           errorCode likeds(errcode);
         end-pr;
         dcl-ds qualMsgf qualified;
           msgf char(10) inz('QCPFMSG');
           lib char(10) inz('*LIBL');
         end-ds;
         dcl-ds errCode qualified;
           bytesProvided int(10) inz(0); // issue exception if bad parms
           bytesAvailable int(10) inz(0);
         end-ds;
         dcl-s msgkey char(4);
         dcl-c STACK_OFFSET_TO_CALLER 2; // 1 for PEP + 1 for its caller

         QMHSNDPM ('CPF9898' : qualMsgf
                 : msg : %len(msg) : msgType
                 : proc : stackOffset
                 : msgkey : errCode);
       end-proc;
