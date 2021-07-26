**FREE
         /if not defined(SIUIP)
         /define SIUIP
         /else
         /eof
         /endif

         /include qcpylesrc/qsyrusrip

        //==========================================================================================
        // Constant
        //==========================================================================================

         dcl-c cSIUI_HomeDirectoryLength const(%size(tQSYRUSRI_HomeDirectoryNameValue));

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIUI like(tSIUI_Def) template;
         dcl-s tSIUI_Userprofile like(tQSYRUSRI_UserProfileName) template;
         dcl-s tSIUI_HomeDirectory varchar(cSIUI_HomeDirectoryLength) template;
         dcl-s tSIUI_UserProfileName like(tQSYRUSRI_UserProfileName) template;

         dcl-ds tSIUI_Def qualified;
            Userprofile like(tSIUI_Userprofile);
            USRI0100 likeds(tQSYRUSRI_USRI0100);
            USRI0200 likeds(tQSYRUSRI_USRI0200);
            USRI0300 likeds(tQSYRUSRI_USRI0300);
         end-ds;

         /if defined(SIUI)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIUI_new like(tSIUI) extproc(*dclcase);
           Userprofile like(tSIUI_Userprofile) const options(*nopass);
         end-pr;

         dcl-pr SIUI_getUserProfileName like(tSIUI_UserProfileName) extproc(*dclcase);
           SIUI like(tSIUI);
         end-pr;

         dcl-pr SIUI_getHomeDirectory like(tSIUI_HomeDirectory) extproc(*dclcase);
           SIUI like(tSIUI);
         end-pr;


