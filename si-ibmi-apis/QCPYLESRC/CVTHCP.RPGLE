         /if not defined(CVTHCP)
         /define CVTHCP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tCVTHC_Result char(65534) template;
         dcl-s tCVTHC_ResultSize int(10) template;
         dcl-s tCVTHC_Source char(32767) template;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr cvthc extproc(*dclcase);
           Result like(tCVTHC_Result) options(*varsize);
           Source like(tCVTHC_Source) options(*varsize);
           ResultSize like(tCVTHC_ResultSize) value;
         end-pr;
