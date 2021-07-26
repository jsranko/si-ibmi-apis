**FREE
         /if not defined(SIDBGAP)
         /define SIDBGAP
         /else
         /eof
         /endif

         /include qcpylesrc/qtedbgsp

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIDBGA_DebugJob like(tQtedbgs_AttributeValue) template;
         dcl-s tSIDBGA_AttributeValue like(tQtedbgs_AttributeValue) template;

         /if defined(SIDBGA)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIDBGA_isUpdProd ind extproc(*dclcase);
         end-pr;

         dcl-pr SIDBGA_getDebugJob like(tSIDBGA_DebugJob) extproc(*dclcase);
         end-pr;

         dcl-pr SIDBGA_isOpmSrc ind extproc(*dclcase);
         end-pr;

         dcl-pr SIDBGA_isInDebugMode ind extproc(*dclcase);
         end-pr;

         dcl-pr SIDBGA_startDebugMode extproc(*dclcase);
           UpdProdData ind const options(*nopass:*omit);
           OpmSrc ind const options(*nopass);
         end-pr;

         dcl-pr SIDBGA_endDebugMode extproc(*dclcase);
         end-pr;
