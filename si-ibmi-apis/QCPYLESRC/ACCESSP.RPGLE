         /if not defined(ACCESSP)
         /define ACCESSP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Constants
        //==========================================================================================

         dcl-c cACCESS_SUCCESSFUL const(0);
         dcl-c cACCESS_NOT_SUCCESSFUL const(-1);
         dcl-c cACCESS_F_OK const(0);
         dcl-c cACCESS_R_OK const(4);
         dcl-c cACCESS_W_OK const(2);
         dcl-c cACCESS_X_OK const(1);

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-s tACCESS_Return int(10) template;
         dcl-s tACCESS_Mode   int(10) template;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr access like(tACCESS_Return) extproc(*dclcase);
           Path pointer value options(*string);
           AccessMode like(tACCESS_Mode) value;
         end-pr;
