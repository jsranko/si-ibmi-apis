         /if not defined(QXXRTVDAP)
         /define QXXRTVDAP
         /else
         /eof
         /endif

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tQXXRTVDA_DataAreaName char(10) template;
         dcl-s tQXXRTVDA_DataAreaLibrary char(10) template;
         dcl-s tQXXRTVDA_Start int(5) template;
         dcl-s tQXXRTVDA_Length int(5) template;
         dcl-s tQXXRTVDA_Data char(2000) template;
         dcl-ds tQXXRTVDA_DataArea qualified template;
           Name like(tQXXRTVDA_DataAreaName);
           Library like(tQXXRTVDA_DataAreaLibrary);
         end-ds;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr RetrieveDataArea extpgm('QXXRTVDA');
           DataAreaName like(tQXXRTVDA_DataArea) const;
           StartPosition like(tQXXRTVDA_Start) const;
           Length like(tQXXRTVDA_Length) const;
           DataAreaData like(tQXXRTVDA_Data);
         end-pr;
