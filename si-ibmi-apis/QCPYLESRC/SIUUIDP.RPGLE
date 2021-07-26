         /if not defined(SIUUIDP)
         /define SIUUIDP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIUUID like(tSIUUID_Def) template;
         dcl-s tSIUUID_uuid16 char(16) template;
         dcl-s tSIUUID_uuid32 char(32) template;
         dcl-s tSIUUID_uuid   char(36) template;

         dcl-ds tSIUUID_Def qualified;
           Uuid16 Like(tSIUUID_uuid16);
           Uuid32 Like(tSIUUID_uuid32);
           Uuid   Like(tSIUUID_uuid);
         end-ds;

         /if defined(SIUUID)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIUUID_new like(tSIUUID) extproc(*dclcase);
         end-pr;

         dcl-pr SIUUID_get16 like(tSIUUID_uuid16) extproc(*dclcase);
           SIUUID like(tSIUUID);
         end-pr;

         dcl-pr SIUUID_get32 like(tSIUUID_uuid32) extproc(*dclcase);
           SIUUID like(tSIUUID);
         end-pr;

         dcl-pr SIUUID_get like(tSIUUID_uuid) extproc(*dclcase);
           SIUUID like(tSIUUID);
         end-pr;

         dcl-pr SIUUID_gen like(tSIUUID_uuid) extproc(*dclcase);
         end-pr;
