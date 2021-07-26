**FREE
/if not defined(CEEDODP)
  /define CEEDODP
/else
  /eof
/endif

/include qcpylesrc/fbp

//==========================================================================================
// Constant
//==========================================================================================

dcl-c cCEEDOD_DescType_Esc const(1);
dcl-c cCEEDOD_DescType_Elmt const(2);
dcl-c cCEEDOD_DescType_Array const(3);
dcl-c cCEEDOD_DescType_Struct const(4);

dcl-c cCEEDOD_DataType_Esc const(1);
dcl-c cCEEDOD_DataType_Char const(2);
dcl-c cCEEDOD_DataType_CharZ const(3);
dcl-c cCEEDOD_DataType_CharV2 const(4);
dcl-c cCEEDOD_DataType_CharV4 const(5);
dcl-c cCEEDOD_DataType_Bit const(6);
dcl-c cCEEDOD_DataType_BitV2 const(7);
dcl-c cCEEDOD_DataType_BitV4 const(8);
dcl-c cCEEDOD_DataType_GChar const(9);
dcl-c cCEEDOD_DataType_GCharZ const(10);
dcl-c cCEEDOD_DataType_GCharV2 const(11);
dcl-c cCEEDOD_DataType_GCharV4 const(12);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tCEEDOD_Posn int(10) template;
dcl-s tCEEDOD_DescType int(10) template;
dcl-s tCEEDOD_DataType int(10) template;
dcl-s tCEEDOD_DescInf1 int(10) template;
dcl-s tCEEDOD_DescInf2 int(10) template;
dcl-s tCEEDOD_DataLen int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr RetrieveOperationalDescriptorInformation extproc('CEEDOD');
  Posn like(tCEEDOD_Posn) const;
  DescType like(tCEEDOD_DescType);
  DataType like(tCEEDOD_DataType);
  DescInf1 like(tCEEDOD_DescInf1);
  DescInf2 like(tCEEDOD_DescInf2);
  DataLen  like(tCEEDOD_DataLen);
  Feedback likeds(tFB_Information) options(*omit:*nopass);
end-pr;
