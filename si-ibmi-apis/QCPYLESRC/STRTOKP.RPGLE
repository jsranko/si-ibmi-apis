         /if not defined(STRTOKP)
         /define STRTOKP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Templates
        //==========================================================================================
         dcl-s tSTRTOK_Token pointer template;
        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr strtok like(tSTRTOK_Token) extproc('strtok');
           String pointer value options(*string);
           Delimiter pointer value options(*string);
         end-pr;
