        //******************************************************************************************
        //
        //
        // Programname    : SINL
        // Programauthor  : Sranko Informatik
        // Created on     : 06.02.2019
        // Details        : https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_73/rzahz/rzahznls.htm
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,make
        //
        //==========================================================================================

         ctl-opt NoMain;

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SINL
         /include qcpylesrc/sinlp

        //==========================================================================================
        // Procedures
        //==========================================================================================

         dcl-proc SINL_forUTF8 export;
         dcl-pi SINL_forUTF8 like(tSINL) extproc(*dclcase);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) inz;

         dsSINL.ccsid = 1208;
         dsSINL.ascii = 1208;
         dsSINL.codepage = 1208;
         dsSINL.country = 'UTF8';
         dsSINL.regionId = 'EN';
         dsSINL.language = 'UTF8';
         dsSINL.languageId = 'US';
         dsSINL.locale = '/QSYS.LIB/UTF8.LOCALE';

         return dsSINL;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SINL_forGerman export;
         dcl-pi SINL_forGerman like(tSINL) extproc(*dclcase);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) inz;

         dsSINL.ccsid = 273;
         dsSINL.ascii = 819;
         dsSINL.codepage = 273;
         dsSINL.country = 'Germany';
         dsSINL.regionId = 'DE';
         dsSINL.language = 'German';
         dsSINL.languageId = 'DEU';
         dsSINL.locale = '/QSYS.LIB/DE_DE.LOCALE';

         return dsSINL;
         end-proc;


        //------------------------------------------------------------------------------------------

         dcl-proc SINL_getCCSID export;
         dcl-pi SINL_getCCSID like(tSINL_CCSID) extproc(*dclcase);
           SINL like(tSINL);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) based(pSINL);

         pSINL = %addr(SINL);

         return dsSINL.ccsid;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SINL_getASCII export;
         dcl-pi SINL_getASCII like(tSINL_ASCII) extproc(*dclcase);
           SINL like(tSINL);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) based(pSINL);

         pSINL = %addr(SINL);

         return dsSINL.ascii;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SINL_getCodePage export;
         dcl-pi SINL_getCodePage like(tSINL_CodePage) extproc(*dclcase);
           SINL like(tSINL);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) based(pSINL);

         pSINL = %addr(SINL);

         return dsSINL.codepage;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SINL_getCountry export;
         dcl-pi SINL_getCountry like(tSINL_Country) extproc(*dclcase);
           SINL like(tSINL);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) based(pSINL);

         pSINL = %addr(SINL);

         return dsSINL.Country;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SINL_getRegionId export;
         dcl-pi SINL_getRegionId like(tSINL_RegionId) extproc(*dclcase);
           SINL like(tSINL);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) based(pSINL);

         pSINL = %addr(SINL);

         return dsSINL.RegionId;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SINL_getLanguage export;
         dcl-pi SINL_getLanguage like(tSINL_Language) extproc(*dclcase);
           SINL like(tSINL);
         end-pi;
         dcl-ds dsSINL likeds(tSINL_Def) based(pSINL);

         pSINL = %addr(SINL);

         return dsSINL.Language;
         end-proc;


