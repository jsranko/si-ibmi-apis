         /if not defined(MEMCPYP)
         /define MEMCPYP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Konstanten
        //==========================================================================================

        dcl-pr memcpy pointer extproc(*dclcase);
          Destination pointer value;
          Source      pointer value;
          Size        uns(10) value;
        end-pr;
