        //******************************************************************************************
        //
        //
        // Programname    : SIUUID
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

         /define SIUUID
         /include qcpylesrc/siuuidp

         /include qcpylesrc/genuuidp
         /include qcpylesrc/cvthcp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIUUID_new export;
         dcl-pi SIUUID_new like(tSIUUID) extproc(*dclcase);
         end-pi;
         dcl-ds dsSIUUID likeds(tSIUUID_Def) inz;
         dcl-ds dsTemplate likeds(tGENUUID_template) inz(*likeds);
         dcl-s UUID_String like(tSIUUID_uuid32);

         genUUID(%addr(dsTemplate));

         dsSIUUID.uuid16 = dsTemplate.Uuid16;
         cvthc(dsSIUUID.uuid32:dsSIUUID.uuid16:%len(dsSIUUID.uuid16)*2);
         dsSIUUID.uuid = %subst(dsSIUUID.uuid32:1:8) + '-' +
                         %subst(dsSIUUID.uuid32:9:4) + '-' +
                         %subst(dsSIUUID.uuid32:13:4) + '-' +
                         %subst(dsSIUUID.uuid32:17:4) + '-' +
                         %subst(dsSIUUID.uuid32:21:12);

         return dsSIUUID;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIUUID_get16 export;
         dcl-pi SIUUID_get16 like(tSIUUID_uuid16) extproc(*dclcase);
           SIUUID like(tSIUUID);
         end-pi;
         dcl-ds dsSIUUID likeds(tSIUUID_Def) based(pSIUUID);

         pSIUUID = %addr(SIUUID);

         return dsSIUUID.Uuid16;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIUUID_get32 export;
         dcl-pi SIUUID_get32 like(tSIUUID_uuid32) extproc(*dclcase);
           SIUUID like(tSIUUID);
         end-pi;
         dcl-ds dsSIUUID likeds(tSIUUID_Def) based(pSIUUID);

         pSIUUID = %addr(SIUUID);

         return dsSIUUID.Uuid32;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIUUID_get export;
         dcl-pi SIUUID_get like(tSIUUID_uuid) extproc(*dclcase);
           SIUUID like(tSIUUID);
         end-pi;
         dcl-ds dsSIUUID likeds(tSIUUID_Def) based(pSIUUID);

         pSIUUID = %addr(SIUUID);

         return dsSIUUID.Uuid;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIUUID_gen export;
         dcl-pi SIUUID_gen like(tSIUUID_uuid) extproc(*dclcase);
         end-pi;
         dcl-s uuid like(tSIUUID);

         uuid = SIUUID_new();

         return SIUUID_get(uuid);
         end-proc;


