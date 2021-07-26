         /if not defined(QXXCHGDA)
         /define QXXCHGDA
         /else
         /eof
         /endif

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-s tQXXCHGDA_QualifiedDataAreaName char(20) template;
         dcl-s tQXXCHGDA_StartPosition int(5) template;
         dcl-s tQXXCHGDA_Length        int(5) template;
         dcl-s tQXXCHGDA_Data          char(2000) template;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr ChangeDataArea extpgm('QXXCHGDA');
           QualifiedDataAreaName
                like(tQXXCHGDA_QualifiedDataAreaName) const;
           StartPosition like(tQXXCHGDA_StartPosition) const;
           Length like(tQXXCHGDA_Length) const;
           Data like(tQXXCHGDA_Data) options(*varsize);
         end-pr;
