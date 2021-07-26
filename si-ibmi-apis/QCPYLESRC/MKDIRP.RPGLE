         /if not defined(MKDIRP)
         /define MKDIRP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Constants
        //==========================================================================================

         dcl-c cMKDIR_SUCCESSFUL const(0);
         dcl-c cMKDIR_NOT_SUCCESSFUL const(-1);

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-s tMKDIR_Return int(10) template;
         dcl-s tMKDIR_Mode   uns(10) template;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr mkdir like(tMKDIR_Return) extproc(*dclcase);
           Path pointer value options(*string);
           Mode like(tMKDIR_Mode) value;
         end-pr;
