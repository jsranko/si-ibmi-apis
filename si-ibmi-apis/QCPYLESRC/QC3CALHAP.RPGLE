**FREE
         /if not defined(QC3CALHAP)
         /define QC3CALHAP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        //             Konstanten
        //==========================================================================================

        dcl-c cQC3CALHA_InputDataFormatName_0100 const('DATA0100');
        dcl-c cQC3CALHA_InputDataFormatName_0200 const('DATA0200');

        dcl-c cQC3CALHA_FormatName_Token const('ALGD0100');
        dcl-c cQC3CALHA_FormatName_Hash const('ALGD0500');

        dcl-c cQC3CALHA_HashAlgorithm_MD5 const(1);
        dcl-c cQC3CALHA_HashAlgorithm_SHA1 const(2);
        dcl-c cQC3CALHA_HashAlgorithm_SHA256 const(3);
        dcl-c cQC3CALHA_HashAlgorithm_SHA384 const(4);
        dcl-c cQC3CALHA_HashAlgorithm_SHA512 const(5);

        dcl-c cQC3CALHA_CryptographicServiceProvider_Any const('0');
        dcl-c cQC3CALHA_CryptographicServiceProvider_Software const('1');
        dcl-c cQC3CALHA_CryptographicServiceProvider_Hardware const('2');

        //==========================================================================================
        //             Templates
        //==========================================================================================

        dcl-s tQC3CALHA_InputData char(32767) template;
        dcl-s tQC3CALHA_LengthOfInputData int(10) template;
        dcl-s tQC3CALHA_InputDataFormatName char(8) template;
        dcl-s tQC3CALHA_AlgorithmDescription char(32767) template;
        dcl-s tQC3CALHA_AlgorithmDescriptionFormatName char(8) template;
        dcl-s tQC3CALHA_CryptographicServiceProvider char(1) template;
        dcl-s tQC3CALHA_CryptographicDeviceName char(10) template;
        dcl-s tQC3CALHA_Hash char(64) template;
        dcl-s tQC3CALHA_HashHex char(128) template;
        dcl-s tQC3CALHA_MD5 char(16) template;
        dcl-s tQC3CALHA_MD5Hex char(32) template;

        dcl-ds tQC3CALHA_ALGD0500 qualified template;
          HashAlgorithm int(10);
        end-ds;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

        dcl-pr CalculateHash extpgm('QC3CALHA');
           InputData like(tQC3CALHA_InputData) options(*varsize) const;
           LengthOfInputData like(tQC3CALHA_LengthOfInputData) const;
           InputDataFormatName like(tQC3CALHA_InputDataFormatName) const;
           AlgorithmDescription like(tQC3CALHA_AlgorithmDescription) const;
           AlgorithmDescriptionFormatName like(tQC3CALHA_AlgorithmDescriptionFormatName) const;
           CryptographicServiceProvider like(tQC3CALHA_CryptographicServiceProvider) const;
           CryptographicDeviceName like(tQC3CALHA_CryptographicDeviceName) const;
           Hash like(tQC3CALHA_Hash);
           ErrorCode likeds(tQUSEC);
        end-pr;
