        //******************************************************************************************
        //
        //
        // Programname    : SIULC
        // Programautor   : Sranko Informatik
        // Created on     : 06.03.2019
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
        // Constants
        //==========================================================================================

         dcl-c cMETHOD_UsernamePassword const('1');
         dcl-c cMETHOD_UsernameKey const('2');

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIULC
         /include qcpylesrc/siulcp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_new export;
         dcl-pi SIULC_new like(tSIULC) extproc(*dclcase);
           Username like(tSIULC_Username) const;
           Password like(tSIULC_Password) value;
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) inz;

         dsSIULC.method = cMETHOD_UsernamePassword;
         dsSIULC.Username = Username;
         dsSIULC.Password = Password;

         return dsSIULC;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_newWithKey export;
         dcl-pi SIULC_newWithKey like(tSIULC) extproc(*dclcase);
           Username like(tSIULC_Username) const;
           Key like(tSIULC_PathToKey) const;
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) inz;

         dsSIULC.method = cMETHOD_UsernameKey;
         dsSIULC.Username = Username;
         dsSIULC.PathToKey = Key;

         return dsSIULC;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_isValid export;
         dcl-pi SIULC_isValid ind extproc(*dclcase);
           SIULC like(tSIULC);
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) based(pSIULC);

         pSIULC = %addr(SIULC);

         if dsSIULC.Username = *blanks;
           return *off;
         endif;

         if dsSIULC.method = *blanks;
           return *off;
         endif;

         if dsSIULC.method <> *blanks
         and dsSIULC.method = cMETHOD_UsernamePassword
         and dsSIULC.Password = *blanks;
           return *off;
         endif;

         if dsSIULC.method <> *blanks
         and dsSIULC.method = cMETHOD_UsernameKey
         and dsSIULC.PathToKey = *blanks;
           return *off;
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_getUsername export;
         dcl-pi SIULC_getUsername like(tSIULC_Username) extproc(*dclcase);
           SIULC like(tSIULC);
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) based(pSIULC);

         pSIULC = %addr(SIULC);


         return dsSIULC.Username;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_getPassword export;
         dcl-pi SIULC_getPassword like(tSIULC_Password) extproc(*dclcase);
           SIULC like(tSIULC);
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) based(pSIULC);

         pSIULC = %addr(SIULC);


         return dsSIULC.Password;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_getPathToKey export;
         dcl-pi SIULC_getPathToKey like(tSIULC_PathToKey) extproc(*dclcase);
           SIULC like(tSIULC);
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) based(pSIULC);

         pSIULC = %addr(SIULC);


         return dsSIULC.PathToKey;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_isWithUsernamePassword export;
         dcl-pi SIULC_isWithUsernamePassword ind extproc(*dclcase);
           SIULC like(tSIULC);
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) based(pSIULC);

         pSIULC = %addr(SIULC);

         if dsSIULC.method = cMETHOD_UsernamePassword ;
           return *on;
         else;
           return *off;
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIULC_isWithKey export;
         dcl-pi SIULC_isWithKey ind extproc(*dclcase);
           SIULC like(tSIULC);
         end-pi;
         dcl-ds dsSIULC likeds(tSIULC_Def) based(pSIULC);

         pSIULC = %addr(SIULC);

         if dsSIULC.method = cMETHOD_UsernameKey ;
           return *on;
         else;
           return *off;
         endif;
         end-proc;

