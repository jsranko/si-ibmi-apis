         /if not defined(SIULCP)
         /define SIULCP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIULC like(tSIULC_Def) template;
         dcl-s tSIULC_Username varchar(25) template;
         dcl-s tSIULC_Password varchar(25) template;
         dcl-s tSIULC_PathToKey varchar(256) template;

         dcl-ds tSIULC_Def qualified;
            method char(1);
            Username like(tSIULC_Username);
            Password like(tSIULC_Password);
            PathToKey like(tSIULC_PathToKey);
         end-ds;

         /if defined(SIULC)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIULC_new like(tSIULC) extproc(*dclcase);
           Username like(tSIULC_Username) const;
           Password like(tSIULC_Password) value;
         end-pr;

         dcl-pr SIULC_newWithKey like(tSIULC) extproc(*dclcase);
           Username like(tSIULC_Username) const;
           Key like(tSIULC_PathToKey) const;
         end-pr;

         dcl-pr SIULC_isValid ind extproc(*dclcase);
           SIULC like(tSIULC);
         end-pr;

         dcl-pr SIULC_getUsername like(tSIULC_Username) extproc(*dclcase);
           SIULC like(tSIULC);
         end-pr;

         dcl-pr SIULC_getPassword like(tSIULC_Password) extproc(*dclcase);
           SIULC like(tSIULC);
         end-pr;

         dcl-pr SIULC_getPathToKey like(tSIULC_PathToKey) extproc(*dclcase);
           SIULC like(tSIULC);
         end-pr;

         dcl-pr SIULC_isWithUsernamePassword ind extproc(*dclcase);
           SIULC like(tSIULC);
         end-pr;

         dcl-pr SIULC_isWithKey ind extproc(*dclcase);
           SIULC like(tSIULC);
         end-pr;
