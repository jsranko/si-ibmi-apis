**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SIPATH
        // Programautor   : Sranko Informatik
        // Created on     : 01.03.2019
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

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIPATH
         /include qcpylesrc/sipathp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIPATH_isQualified export;
         dcl-pi SIPATH_isQualified ind extproc(*dclcase);
           Path pointer options(*string) value;
         end-pi;

         if %subst(%str(Path):1:1) = cSIPATH_SLASH_UNIX
         or %subst(%str(Path):1:1) = cSIPATH_SLASH_WINDOWS;
           return *on;
         else;
           return *off;
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIPATH_endWithSlash export;
         dcl-pi SIPATH_endWithSlash ind extproc(*dclcase);
           Path pointer options(*string) value;
         end-pi;
         dcl-s Path_len uns(10);

         Path_len = %len(%trim(%str(Path)));
         if %subst(%trim(%str(Path)):Path_len - 1:1) = cSIPATH_SLASH_UNIX
         or %subst(%trim(%str(Path)):Path_len - 1:1) = cSIPATH_SLASH_WINDOWS;
           return *on;
         else;
           return *off;
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIPATH_getSlashFromPath export;
         dcl-pi SIPATH_getSlashFromPath like(tSIPATH_Slash) extproc(*dclcase);
           Path pointer options(*string) value;
         end-pi;

         if %scan(cSIPATH_SLASH_UNIX : %trim(%str(Path))) > 0;
           return cSIPATH_SLASH_UNIX;
         endif;

         if %scan(cSIPATH_SLASH_WINDOWS : %trim(%str(Path))) > 0;
           return cSIPATH_SLASH_WINDOWS;
         endif;

         return '';
         end-proc;


