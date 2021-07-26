         /if not defined(STRSTRP)
         /define STRSTRP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Templates
        //==========================================================================================

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr strstr pointer Extproc(*dclcase);
           SourceString pointer Value Options(*String) ;
           SearchString pointer Value Options(*String) ;
         end-pr;
