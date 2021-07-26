         /if not defined(GENUUIDP)
         /define GENUUIDP
         /else
         /eof
         /endif

        //==========================================================================================
        // Tempaltes
        //==========================================================================================

         dcl-ds tGENUUID_template qualified template;
           Bytes_provided uns(10) inz(%size(tGENUUID_template));
           Bytes_available uns(10);
           Reserved char(8) inz(*allx'00');
           UUID16 char(16);
         end-ds;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

        dcl-pr genUUID extproc('_GENUUID');
          UUID_Template pointer value;
        end-pr;
