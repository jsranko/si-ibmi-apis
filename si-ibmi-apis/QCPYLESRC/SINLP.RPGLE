         /if not defined(SINLP)
         /define SINLP
         /else
         /eof
         /endif

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSINL like(tSINL_Def) template;
         dcl-s tSINL_CCSID uns(5) template;
         dcl-s tSINL_ASCII uns(5) template;
         dcl-s tSINL_CodePage uns(5) template;
         dcl-s tSINL_Country varchar(15) template;
         dcl-s tSINL_RegionId char(2) template;
         dcl-s tSINL_Language varchar(25) template;
         dcl-s tSINL_LanguageId char(3) template;
         dcl-s tSINL_Locale varchar(30) template;

         dcl-ds tSINL_Def qualified;
           ccsid like(tSINL_CCSID);
           ascii like(tSINL_ASCII);
           codepage like(tSINL_CodePage);
           country like(tSINL_Country);
           regionId like(tSINL_RegionId);
           language like(tSINL_Language);
           languageId like(tSINL_LanguageId);
           locale like(tSINL_Locale);
         end-ds;

         /if defined(SINL)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SINL_forGerman like(tSINL) extproc(*dclcase);
         end-pr;

         dcl-pr SINL_forUTF8 like(tSINL) extproc(*dclcase);
         end-pr;

         dcl-pr SINL_getCCSID like(tSINL_CCSID) extproc(*dclcase);
           SINL like(tSINL);
         end-pr;

         dcl-pr SINL_getASCII like(tSINL_ASCII) extproc(*dclcase);
           SINL like(tSINL);
         end-pr;

         dcl-pr SINL_getCodePage like(tSINL_CodePage) extproc(*dclcase);
           SINL like(tSINL);
         end-pr;

         dcl-pr SINL_getCountry like(tSINL_Country) extproc(*dclcase);
           SINL like(tSINL);
         end-pr;

         dcl-pr SINL_getRegionId like(tSINL_RegionId) extproc(*dclcase);
           SINL like(tSINL);
         end-pr;

         dcl-pr SINL_getLanguage like(tSINL_Language) extproc(*dclcase);
           SINL like(tSINL);
         end-pr;
