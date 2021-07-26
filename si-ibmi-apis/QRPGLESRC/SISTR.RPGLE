**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SISTR
        // Programautor   : Sranko Informatik
        // Created on     : 08.02.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SISTR
         /include qcpylesrc/sistrp

         /include qcpylesrc/qlgcnvcsp
         /include qcpylesrc/strtokp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SISTR_toLower export;
         dcl-pi SISTR_toLower like(tSISTR_String) extproc(*dclcase);
           String pointer options(*string) value;
         end-pi;

         return convertCase(cQlgConvertCase_TOR_CCSIDFormat
                           :cQlgConvertCase_ToLower
                           :cQlgConvertCase_JobCCSID
                           :String);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SISTR_toUpper export;
         dcl-pi SISTR_toUpper like(tSISTR_String) extproc(*dclcase);
           String pointer options(*string) value;
         end-pi;

         return convertCase(cQlgConvertCase_TOR_CCSIDFormat
                           :cQlgConvertCase_ToUpper
                           :cQlgConvertCase_JobCCSID
                           :String);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc convertCase;
         dcl-pi convertCase like(tSISTR_String);
           TypeOfRequest like(tQlgConvertCase_TypeOfRequest) const;
           CaseRequest like(tQlgConvertCase_CaseRequest) const;
           CCSIDOfInputData like(tQlgConvertCase_CCSIDOfInputData) const;
           String pointer options(*string) value;
         end-pi;
         dcl-ds rcb likeds(tQlgConvertCase_RequestControlBlock) inz(*likeds);
         dcl-ds ErrorCode likeds(tQUSEC) inz(*likeds);
         dcl-s output char(65534);

         rcb.TypeOfRequest = cQlgConvertCase_TOR_CCSIDFormat;
         rcb.CaseRequest = cQlgConvertCase_ToLower;
         rcb.CCSIDOfInputData = cQlgConvertCase_JobCCSID;

         QlgConvertCase(rcb:%str(String):output:%len(%str(String)):ErrorCode);

         if ErrorCode.ExceptionId <> *blanks;
           dsply ('Conversion Error');
         endif;

         return %trim(output);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SISTR_tokenize export;
         dcl-pi SISTR_tokenize like(tSISTR_List) extproc(*dclcase);
           String pointer options(*string) value;
           Delimiter like(tSISTR_Delimiter) const;
         end-pi;
         dcl-s token like(tSTRTOK_Token);
         dcl-s tokenStr like(tSISTR_String);
         dcl-s output like(tSISTR_List);

         tokenStr = %str(String);
         token = strtok(tokenStr:delimiter);
         if token = *null;
           tokenStr = %str(token);
           SIITR_addEntry(output:%addr(tokenStr):1024);
           return *null;
         endif;

         dow not %shtdn(); // endlose Schleife

           tokenStr = %str(token);
           SIITR_addEntry(output:%addr(tokenStr):1024);

           token = strtok(*null: delimiter);
           if token = *null;
             leave;
           endif;

         enddo;

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SISTR_replace export;
         dcl-pi SISTR_replace like(tSISTR_String) extproc(*dclcase);
           String pointer options(*string) value;
           Searchfor pointer options(*string) value;
           ReplaceWith pointer options(*string) value;
         end-pi;
         dcl-s output like(tSISTR_String);

         output = %str(String);
         dow not %shtdn(); // endlose Schleife

           if %scan(%str(SearchFor):output) = 0;
             leave;
           endif;
           output = %scanrpl(%str(SearchFor):%str(ReplaceWith):output:1: %len(output));
         enddo;

         return output;
         end-proc;



