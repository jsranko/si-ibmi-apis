**FREE
         /if not defined(SIHASHP)
         /define SIHASHP
         /else
         /eof
         /endif

         /include qcpylesrc/qc3calhap

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIHASH_InputData like(tQC3CALHA_InputData) template;
         dcl-s tSIHASH_LengthOfInputData like(tQC3CALHA_LengthOfInputData) template;
         dcl-s tSIHASH_FormatName like(tQC3CALHA_AlgorithmDescriptionFormatName) template;
         dcl-s tSIHASH_Hash like(tQC3CALHA_Hash) template;
         dcl-s tSIHASH_HashHex like(tQC3CALHA_HashHex) template;
         dcl-s tSIHASH_MD5 like(tQC3CALHA_MD5) template;
         dcl-s tSIHASH_MD5Hex like(tQC3CALHA_MD5Hex) template;

         /if defined(SIHASH)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIHASH_calcMD5 like(tSIHASH_MD5Hex) extproc(*dclcase);
           InputData like(tSIHASH_InputData) options(*varsize);
           LengthOfInputData like(tSIHASH_LengthOfInputData) const;
         end-pr;
