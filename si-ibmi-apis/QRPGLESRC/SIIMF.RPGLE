        //******************************************************************************************
        //
        //
        // Programname    : SIIMF
        // Programautor   : Sranko Informatik
        // Created on     : 06.02.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,make
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

         /define SIIMF
         /include qcpylesrc/siimfp

         /include qsysinc/qrpglesrc,sysstat

        //==========================================================================================
        // Procedures
        //==========================================================================================

         dcl-proc SIIMF_new export;
         dcl-pi SIIMF_new like(tSIIMF) extproc(*dclcase);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) inz;

         clear dsSIIMF;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setReadForOwner export;
         dcl-pi SIIMF_setReadForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.OwnerRead = S_IRUSR;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setWriteForOwner export;
         dcl-pi SIIMF_setWriteForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.OwnerWrite = S_IWUSR;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setExecForOwner export;
         dcl-pi SIIMF_setExecForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.OwnerExec = S_IXUSR;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setAllForOwner export;
         dcl-pi SIIMF_setAllForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.OwnerAll = S_IRWXU;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setReadForGroup export;
         dcl-pi SIIMF_setReadForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.GroupRead = S_IRGRP;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setWriteForGroup export;
         dcl-pi SIIMF_setWriteForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.GroupWrite = S_IWGRP;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setExecForGroup export;
         dcl-pi SIIMF_setExecForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.GroupExec = S_IXGRP;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setAllForGroup export;
         dcl-pi SIIMF_setAllForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.GroupAll = S_IRWXG;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setReadForPublic export;
         dcl-pi SIIMF_setReadForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.PublicRead = S_IROTH;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setWriteForPublic export;
         dcl-pi SIIMF_setWriteForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.PublicWrite = S_IWOTH;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setExecForPublic export;
         dcl-pi SIIMF_setExecForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.PublicExec = S_IXOTH;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_setAllForPublic export;
         dcl-pi SIIMF_setAllForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);
         dsSIIMF.PublicAll = S_IRWXO;

         return dsSIIMF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIIMF_getFlags export;
         dcl-pi SIIMF_getFlags like(tSIIMF_Mode_Flag) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pi;
         dcl-ds dsSIIMF likeds(tSIIMF_Def) based(pSIIMF);

         pSIIMF = %addr(SIIMF);

         return dsSIIMF.OwnerRead +
                dsSIIMF.OwnerWrite +
                dsSIIMF.OwnerExec +
                dsSIIMF.OwnerAll +
                dsSIIMF.GroupRead +
                dsSIIMF.GroupWrite +
                dsSIIMF.GroupExec +
                dsSIIMF.GroupAll +
                dsSIIMF.PublicRead +
                dsSIIMF.PublicWrite +
                dsSIIMF.PublicExec +
                dsSIIMF.PublicAll;

         end-proc;

