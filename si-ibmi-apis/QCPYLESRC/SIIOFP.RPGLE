         /if not defined(SIIOFP)
         /define SIIOFP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIIOF like(tSIIOF_Def) template;
         dcl-s tSIIOF_Object_Flag uns(10) template;
         dcl-s tSIIOF_ReadOnly like(tSIIOF_Object_Flag) template;
         dcl-s tSIIOF_WriteOnly like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_ReadWrite like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_Create like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_CreateExclu like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_Truncate like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_Append like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_CodePage like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_TextData like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_TextCreate like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_CCSID like(tSIIOF_Object_Flag);
         dcl-s tSIIOF_InheritMode like(tSIIOF_Object_Flag);

         dcl-ds tSIIOF_Def qualified;
           ReadOnly like(tSIIOF_ReadOnly);
           WriteOnly like(tSIIOF_WriteOnly);
           ReadWrite like(tSIIOF_ReadWrite);
           Create like(tSIIOF_Create);
           CreateExclu like(tSIIOF_CreateExclu);
           Truncate like(tSIIOF_Truncate);
           Append like(tSIIOF_Append);
           CodePage like(tSIIOF_CodePage);
           CCSID like(tSIIOF_CCSID);
           TextData like(tSIIOF_TextData);
           TextCreate like(tSIIOF_TextCreate);
           InheritMode like(tSIIOF_InheritMode);
         end-ds;

         /if defined(SIIOF)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIIOF_new like(tSIIOF) extproc(*dclcase);
         end-pr;

         dcl-pr SIIOF_readingOnly like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_writingOnly like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_readingAndWriting like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_createIfNotExist like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_createExclusively like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_truncateFile like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_appendToFile like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_convertTextToCodePage like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_openInTextMode like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_allowTextConversion like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_authoritiesFromDirectory like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_allowMixedConversion like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;

         dcl-pr SIIOF_getFlags like(tSIIOF_Object_Flag) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pr;
