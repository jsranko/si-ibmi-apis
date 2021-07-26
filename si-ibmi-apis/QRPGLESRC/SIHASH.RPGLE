        //******************************************************************************************
        //
        //
        // Programname    : SIHASH
        // Programautor   : Sranko Informatik
        // Created on     : 11.05.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain;
         ctl-opt bnddir('$(LIBRARY)/SIIIA');

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIHASH
         /include qcpylesrc/sihashp

         /include qcpylesrc/cvthcp
         /include qcpylesrc/sixcpp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIHASH_calcMD5 export;
         dcl-pi SIHASH_calcMD5 like(tSIHASH_MD5Hex) extproc(*dclcase);
           InputData like(tSIHASH_InputData) options(*varsize);
           LengthOfInputData like(tSIHASH_LengthOfInputData) const;
         end-pi;
         dcl-s MD5 like(tSIHASH_MD5Hex);

         MD5 = getData(InputData:LengthOfInputData:cQC3CALHA_FormatName_Hash);

         return MD5;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getData;
         dcl-pi getData like(tSIHASH_HashHex) extproc(*dclcase);
           InputData like(tSIHASH_InputData) options(*varsize);
           LengthOfInputData like(tSIHASH_LengthOfInputData) const;
           FormatName like(tSIHASH_FormatName) const;
         end-pi;
         dcl-ds ALGD0500 likeds(tQC3CALHA_ALGD0500);
         dcl-s Hash like(tSIHASH_Hash);
         dcl-s HashHex like(tSIHASH_HashHex);
         dcl-ds ErrorCode likeds(tQUSEC) inz(*likeds);

         ALGD0500.HashAlgorithm = cQC3CALHA_HashAlgorithm_MD5;
         CalculateHash(InputData
                      :LengthOfInputData
                      :cQC3CALHA_InputDataFormatName_0100
                      :ALGD0500
                      :FormatName
                      :cQC3CALHA_CryptographicServiceProvider_Any
                      :*blanks
                      :Hash
                      :ErrorCode
                      );

         if ErrorCode.ExceptionId <> *blanks;
           SIXCP_throwWithMessage('Calculate Hash error.');
         endif;

         cvthc(HashHex:Hash:%size(Hash));

         return HashHex;
         end-proc;
