         /if not defined(SIPATHP)
         /define SIPATHP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

         dcl-c cSIPATH_SLASH_URL const('/');
         dcl-c cSIPATH_SLASH_UNIX const('/');
         dcl-c cSIPATH_SLASH_WINDOWS const('\');

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIPATH_Slash char(1) template;

         /if defined(SIPATH)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIPATH_isQualified ind extproc(*dclcase);
           Path pointer options(*string) value;
         end-pr;

         dcl-pr SIPATH_endWithSlash ind extproc(*dclcase);
           Path pointer options(*string) value;
         end-pr;

         dcl-pr SIPATH_getSlashFromPath like(tSIPATH_Slash) extproc(*dclcase);
           Path pointer options(*string) value;
         end-pr;
