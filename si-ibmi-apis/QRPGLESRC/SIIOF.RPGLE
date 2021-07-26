        //******************************************************************************************
        //
        //
        // Programname    : SIIOF
        // Programautor   : Sranko Informatik
        // Created on     : 06.02.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain;

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIIOF
         /include qcpylesrc/siiofp

         /include qsysinc/qrpglesrc,fcntl

        //==========================================================================================
        // Procedures
        //==========================================================================================

         dcl-proc SIIOF_new export;
         dcl-pi SIIOF_new like(tSIIOF) extproc(*dclcase);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) inz;

         clear dsSIIOF;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_readingOnly export;
         dcl-pi SIIOF_readingOnly like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.ReadOnly = O_RDONLY;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_writingOnly export;
         dcl-pi SIIOF_writingOnly like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.WriteOnly = O_WRONLY;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_readingAndWriting export;
         dcl-pi SIIOF_readingAndWriting like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.ReadWrite = O_RDWR;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_createIfNotExist export;
         dcl-pi SIIOF_createIfNotExist like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.Create = O_CREAT;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_createExclusively export;
         dcl-pi SIIOF_createExclusively like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.CreateExclu = O_EXCL;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_truncateFile export;
         dcl-pi SIIOF_truncateFile like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.Truncate = O_TRUNC;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_appendToFile export;
         dcl-pi SIIOF_appendToFile like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.Append = O_APPEND;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_convertTextToCodePage export;
         dcl-pi SIIOF_convertTextToCodePage like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.CodePage = O_CODEPAGE;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_openInTextMode export;
         dcl-pi SIIOF_openInTextMode like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.TextData = O_TEXTDATA;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_allowTextConversion export;
         dcl-pi SIIOF_allowTextConversion like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.TextCreate = O_TEXT_CREAT;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_allowMixedConversion export;
         dcl-pi SIIOF_allowMixedConversion like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.CCSID = O_CCSID;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_authoritiesFromDirectory export;
         dcl-pi SIIOF_authoritiesFromDirectory like(tSIIOF) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);
         dsSIIOF.InheritMode = O_INHERITMODE;

         return dsSIIOF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIOF_getFlags export;
         dcl-pi SIIOF_getFlags like(tSIIOF_Object_Flag) extproc(*dclcase);
           SIIOF like(tSIIOF);
         end-pi;
         dcl-ds dsSIIOF likeds(tSIIOF_Def) based(pSIIOF);

         pSIIOF = %addr(SIIOF);

         return dsSIIOF.ReadOnly +
                dsSIIOF.WriteOnly +
                dsSIIOF.ReadWrite +
                dsSIIOF.Create +
                dsSIIOF.CreateExclu +
                dsSIIOF.Truncate +
                dsSIIOF.Append +
                dsSIIOF.CodePage +
                dsSIIOF.TextData +
                dsSIIOF.TextCreate +
                dsSIIOF.CCSID +
                dsSIIOF.InheritMode;
         end-proc;

