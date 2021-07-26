         /if not defined(SIIMFP)
         /define SIIMFP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIIMF like(tSIIMF_Def) template;
         dcl-s tSIIMF_Mode_Flag int(10) template;
         dcl-s tSIIMF_OwnerRead like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_OwnerWrite like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_OwnerExec like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_OwnerAll like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_GroupRead like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_GroupWrite like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_GroupExec like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_GroupAll like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_PublicRead like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_PublicWrite like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_PublicExec like(tSIIMF_Mode_Flag) template;
         dcl-s tSIIMF_PublicAll like(tSIIMF_Mode_Flag) template;

         dcl-ds tSIIMF_Def qualified;
           OwnerRead Like(tSIIMF_OwnerRead);
           OwnerWrite Like(tSIIMF_OwnerWrite);
           OwnerExec Like(tSIIMF_OwnerExec);
           OwnerAll Like(tSIIMF_OwnerAll);
           GroupRead Like(tSIIMF_GroupRead);
           GroupWrite Like(tSIIMF_GroupWrite);
           GroupExec Like(tSIIMF_GroupExec);
           GroupAll Like(tSIIMF_GroupAll);
           PublicRead Like(tSIIMF_PublicRead);
           PublicWrite Like(tSIIMF_PublicWrite);
           PublicExec Like(tSIIMF_PublicExec);
           PublicAll Like(tSIIMF_PublicAll);
         end-ds;

         /if defined(SIIMF)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIIMF_new like(tSIIMF) extproc(*dclcase);
         end-pr;

         dcl-pr SIIMF_setReadForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setWriteForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setExecForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setAllForOwner like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setReadForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setWriteForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setExecForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setAllForGroup like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setReadForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setWriteForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setExecForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_setAllForPublic like(tSIIMF) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;

         dcl-pr SIIMF_getFlags like(tSIIMF_Mode_Flag) extproc(*dclcase);
           SIIMF like(tSIIMF);
         end-pr;
