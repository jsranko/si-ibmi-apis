         /if not defined(SISTRP)
         /define SISTRP
         /else
         /eof
         /endif

         /include qcpylesrc/siitrp

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSISTR_String varchar(32756) template;
         dcl-s tSISTR_Delimiter char(1) template;
         dcl-s tSISTR_List like(tSIITR) template;

         /if defined(SISTR)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SISTR_toLower like(tSISTR_String) extproc(*dclcase);
           String pointer options(*string) value;
         end-pr;

         dcl-pr SISTR_toUpper like(tSISTR_String) extproc(*dclcase);
           String pointer options(*string) value;
         end-pr;

         dcl-pr SISTR_tokenize like(tSISTR_List) extproc(*dclcase);
           String pointer options(*string) value;
           Delimiter like(tSISTR_Delimiter) const;
         end-pr;

         dcl-pr SISTR_replace like(tSISTR_String) extproc(*dclcase);
           String pointer options(*string) value;
           Searchfor pointer options(*string) value;
           ReplaceWith pointer options(*string) value;
         end-pr;
