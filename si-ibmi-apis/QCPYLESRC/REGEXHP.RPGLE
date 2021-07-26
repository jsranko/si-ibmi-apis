**FREE

//  ** Header file for calling the "Regular Expression" functions
//  **   provided by the ILE C Runtime Library from an RPG IV
//  **   program.                 Scott Klement, 2001-05-04
//  **                       Converted to qualified DS 2003-11-29
//  **                       Modified by Jarrett Gilliam 2014-11-05
//  **
//  ** This copy book is for using the C regular expression library, regex.h, in RPG.
//  ** You can go to http://www.regular-expressions.info/ to learn more about
//  ** regular expressions. This regex flavor is POSIX ERE. You can go to
//  ** http://www-01.ibm.com/support/knowledgecenter/ssw_ibm_i_71/rtref/regexec.htm
//  ** to learn more about how the C functions work.

/if defined(REGEX_H)
/eof
/endif
/define REGEX_H

////  **------------------------------------------------------------
////  * cflags for regcomp()
////  **------------------------------------------------------------

dcl-c REG_BASIC CONST(0);
dcl-c REG_EXTENDED CONST(1);
dcl-c REG_ICASE CONST(2);
dcl-c REG_NEWLINE CONST(4);
dcl-c REG_NOSUB CONST(8);

////  **------------------------------------------------------------
////  * eflags for regexec()
////  **------------------------------------------------------------

dcl-c REG_NOTBOL CONST(256);
dcl-c REG_NOTEOL CONST(512);

////  **------------------------------------------------------------
////  *  errors returned
////  **------------------------------------------------------------

////  * RE pattern not found
dcl-c REG_NOMATCH CONST(1);
////  * Invalid Regular Expression
dcl-c REG_BADPAT CONST(2);
////  * Invalid collating element
dcl-c REG_ECOLLATE CONST(3);
////  * Invalid character class
dcl-c REG_ECTYPE CONST(4);
////  * Last character is \
dcl-c REG_EESCAPE CONST(5);
////  * Invalid number in \digit
dcl-c REG_ESUBREG CONST(6);
////  * imbalance
dcl-c REG_EBRACK CONST(7);
////  * \( \) or () imbalance
dcl-c REG_EPAREN CONST(8);
////  * \{ \} or { } imbalance
dcl-c REG_EBRACE CONST(9);
////  * Invalid \{ \} range exp
dcl-c REG_BADBR CONST(10);
////  * Invalid range exp endpoint
dcl-c REG_ERANGE CONST(11);
////  * Out of memory
dcl-c REG_ESPACE CONST(12);
////  * ?*+ not preceded by valid RE
dcl-c REG_BADRPT CONST(13);
////  * invalid multibyte character
dcl-c REG_ECHAR CONST(14);
////  * (shift 6 caret or not) anchor and not BOL
dcl-c REG_EBOL  CONST(15);
////  * $ anchor and not EOL
dcl-c REG_EEOL  CONST(16);
////  * Unknown error in regcomp() call
dcl-c REG_ECOMP CONST(17);
////  * Unknown error in regexec() call
dcl-c REG_EEXEC CONST(18);

////  **------------------------------------------------------------
//  *  Structure of a compiled regular expression:
////  **------------------------------------------------------------
dcl-c REG_SUBEXP_MAX const(20);

dcl-ds tRegex qualified align template;
  re_nsub int(10);
  re_comp pointer;
  re_cflags int(10);
  re_erroff int(10);
  re_len int(10);
  re_ucoll int(10) dim(2);
  re_lsub pointer dim(REG_SUBEXP_MAX);
  re_esub pointer dim(REG_SUBEXP_MAX);
  re_map  char(256);
  re_shift int(5);
  re_dbcs int(5);
end-ds;

////  **------------------------------------------------------------
//  *  structure used to report matches found by regexec()
////  **------------------------------------------------------------
dcl-ds tRegexMatch qualified align template;
  rm_so int(10);
  rm_ss int(5);
  rm_eo int(10);
  rm_es int(5);
end-ds;

////  **------------------------------------------------------------
//  * regcomp() -- Compile a Regular Expression ("RE")
//  *
//  *     int regcomp(regex_t *preg, const char *pattern,
//  *              int cflags);
//  *
//  * where:
//  *       preg (output) = the compiled regular expression.
//  *    pattern (input)  = the RE to be compiled.
//  *     cflags (input)  = the sum of the cflag constants
//  *                       (listed above) for this RE.
//  *
//  * Returns 0 = success, otherwise an error number.
////  **------------------------------------------------------------

dcl-pr regcomp int(10) extproc('regcomp');
  preg like(tRegex);
  pattern pointer value options(*string);
  cflags int(10) value;
end-pr;

////  **------------------------------------------------------------
//  * regexec() -- Execute a compiled Regular Expression ("RE")
//  *
//  *     int regexec(const regex_t *preg, const char *string,
//  *              size_t nmatch, regmatch_t *pmatch, int eflags);
//  *
//  * where:
//  *       preg (input)  = the compiled regular expression
//  *                       (the output of regcomp())
//  *     string (input)  = string to run the RE upon
//  *     nmatch (input)  = the number of matches to return.
//  *     pmatch (output) = array of regmatch_t DS's
//  *                       showing what matches were found.
//  *     eflags (input)  = the sum of the flags (constants
//  *                       provided above) modifying the RE
//  *
//  * Returns 0 = success, otherwise an error number.
////  **------------------------------------------------------------

dcl-pr regexec int(10) extproc('regexec');
  preg like(tRegex) const;
  string pointer value options(*string);
  nmatch uns(10) value;
  pmatch pointer value;
  eflags int(10) value;
end-pr;

////  **------------------------------------------------------------
//  * regerror() -- return error information from regcomp/regexec
//  *
//  *   size_t regerror(int errcode, const regex_t *preg,
//  *              char *errbuf, size_t errbuf_size);
//  *
//  *  where:
//  *    errcode (input)  = the error code to return info on
//  *                      (obtained as the return value from
//  *                      either regcomp() or regexec())
//  *       preg (input)  = the (compiled) RE to return the
//  *                      error for.
//  *     errbuf (output) = buffer containing human-readable
//  *                      error message.
//  * errbuf_size (input) = size of errbuf (max length of msg
//  *                      that will be returned)
//  *
//  * returns:  length of buffer needed to get entire error msg
////  **------------------------------------------------------------

dcl-pr regerror uns(10) extproc('regerror');
  errcode int(10) value;
  preg like(tRegex) const;
  errbuf pointer value;
  errbuf_size int(10) value;
end-pr;

////  **------------------------------------------------------------
//  * regfree() -- free memory locked by Regular Expression
//  *
//  *    void regfree(regex_t *preg);
//  *
//  *   where:
//  *        preg (input) = regular expression to free mem for.
//  *
//  *   NOTE:  regcomp() will always allocate extra memory
//  *        to be pointed to by the various pointers in
//  *        the regex_t structure.  if you don't call this,
//  *        that memory will never be returned to the system!
////  **------------------------------------------------------------

dcl-pr regfree extproc('regfree');
  preg like(tRegex);
end-pr;
