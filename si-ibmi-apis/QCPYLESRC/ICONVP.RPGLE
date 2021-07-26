         /if not defined(ICONVP)
         /define ICONVP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Constants
        //==========================================================================================


        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-ds tICONV qualified template;
           trnval int(10);
           cd;
           cdi int(10) dim(12) overlay(cd);
         end-ds;
         dcl-s tICONV_InBuf pointer template;
         dcl-s tICONV_InBytesLeft int(10) template;
         dcl-s tICONV_OutBuf pointer template;
         dcl-s tICONV_OutBytesLeft int(10) template;
         dcl-s tICONV_Return int(10) template;
         dcl-s tICONV_Ccsid int(10) template;
         dcl-s tICONV_CnvAlternative int(10) template;
         dcl-s tICONV_SubsAlternative int(10) template;
         dcl-s tICONV_ShiftAlternative int(10) template;
         dcl-s tICONV_LengthOtion int(10) template;
         dcl-s tICONV_MXErrorOption int(10) template;
         dcl-s tICONV_ErrorPtionForMixData int(10) template;
         dcl-s tICONV_Reserved char(8) template;
         dcl-s tICONV_Reserved12 char(12) template;
         dcl-s tICONV_IBMCcsid char(8) template;
         dcl-s tICONV_InputLengthOption char(1) template;
         dcl-s tICONV_ShiftStateAlternative char(1) template;
         dcl-s tICONV_SubstitutionAlternative char(1) template;
         dcl-s tICONV_ConversionAlternative char(3) template;

         dcl-ds tICONV_QCode qualified template;
           ccsid like(tICONV_Ccsid) inz;
           CnvAlternative like(tICONV_CnvAlternative) inz;
           SubsAlternative like(tICONV_SubsAlternative) inz;
           ShiftAlternative like(tICONV_ShiftAlternative) inz;
           LengthOtion like(tICONV_LengthOtion) inz;
           MXErrorOption like(tICONV_MXErrorOption) inz;
           Reserved like(tICONV_Reserved) inz(*allx'00');
         end-ds;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr iconv_open like(tICONV) extproc('QtqIconvOpen');
           ToCode pointer value;
           FromCode pointer value;
         end-pr;

         dcl-pr iconv like(tICONV_Return) extproc(*dclcase);
           Cd like(tICONV) value;
           InBuf like(tICONV_InBuf);
           InBytesLeft like(tICONV_InBytesLeft);
           OutBuf like(tICONV_OutBuf);
           OutBytesLeft like(tICONV_OutBytesLeft);
         end-pr;

         dcl-pr iconv_close like(tICONV_Return) extproc(*dclcase);
           Cd like(tICONV) value;
         end-pr;
