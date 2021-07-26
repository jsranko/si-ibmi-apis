         /if not defined(QLGCNVCSP)
         /define QLGCNVCSP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cQlgConvertCase_ToLower const(1);
         dcl-c cQlgConvertCase_ToUpper const(0);
         dcl-c cQlgConvertCase_JobCCSID const(0);
         dcl-c cQlgConvertCase_TOR_CCSIDFormat const(1);
         dcl-c cQlgConvertCase_TOR_TableObjectFormat const(2);
         dcl-c cQlgConvertCase_TOR_UserDefinedFormat const(3);

        //==========================================================================================
        // Tempaltes
        //==========================================================================================

         dcl-s tQlgConvertCase_Data char(65534) template;
         dcl-s tQlgConvertCase_TypeOfRequest int(10) template;
         dcl-s tQlgConvertCase_CCSIDOfInputData int(10) template;
         dcl-s tQlgConvertCase_CaseRequest int(10) template;
         dcl-s tQlgConvertCase_Reserved1 char(10) template;

         dcl-ds tQlgConvertCase_RequestControlBlock qualified template;
           TypeOfRequest like(tQlgConvertCase_TypeOfRequest);
           CCSIDOfInputData like(tQlgConvertCase_CCSIDOfInputData);
           CaseRequest like(tQlgConvertCase_CaseRequest);
           Reserved1 like(tQlgConvertCase_Reserved1) inz(*allx'00');
         end-ds;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr QlgConvertCase pointer extproc(*dclcase);
           RequestControlBlock like(tQlgConvertCase_RequestControlBlock) const;
           InputData like(tQlgConvertCase_Data) const options(*varsize);
           OutputData like(tQlgConvertCase_Data) options(*varsize);
           LengthOfData int(10) const;
           ErrorCode likeds(tQUSEC);
         end-pr;

