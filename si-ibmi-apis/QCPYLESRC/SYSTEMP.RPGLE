         /if not defined(SYSTEMP)
         /define SYSTEMP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Constants
        //==========================================================================================

         dcl-c cSystem_Return_Null_Pointer_Passed const(-1);
         dcl-c cSystem_Return_Fails const(1);
         dcl-c cSystem_Return_Succesful const(0);

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-s tSystem_Return int(10) template;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr system like(tSystem_Return) Extproc('system');
           Befehl pointer Value Options(*String) ;
         end-pr;
