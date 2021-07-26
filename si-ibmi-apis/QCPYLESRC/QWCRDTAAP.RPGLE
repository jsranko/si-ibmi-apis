**FREE
/if not defined(QWCRDTAAP)
/define QWCRDTAAP
/else
/eof
/endif

/include qcpylesrc/qusecp

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cQWCRDTAA_Max_Length const(2000);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tQWCRDTAA_DataAreaName char(10) template;
dcl-s tQWCRDTAA_DataAreaLibrary char(10) template;
dcl-s tQWCRDTAA_ReceiverVariable char(2035) template;
dcl-s tQWCRDTAA_LengthOfReceiverVariable int(10) template;
dcl-ds tQWCRDTAA_QualifiedDataAreaName qualified template;
  Name like(tQWCRDTAA_DataAreaName);
  Library like(tQWCRDTAA_DataAreaLibrary);
end-ds;
dcl-s tQWCRDTAA_StartingPosition int(10) template;
dcl-s tQWCRDTAA_LengthOfData int(10) template;
dcl-s tQWCRDTAA_BytesAvailable int(10) template;
dcl-s tQWCRDTAA_BytesReturned int(10) template;
dcl-s tQWCRDTAA_TypeOfValueReturned char(10) template;
dcl-s tQWCRDTAA_LibraryName char(10) template;
dcl-s tQWCRDTAA_LengthOfValueReturned int(10) template;
dcl-s tQWCRDTAA_NumberOfDecimalPositions int(10) template;
dcl-s tQWCRDTAA_Value char(2000) template;
dcl-ds tQWCRDTAA_FormatOfDataReturned qualified template;
  BytesAvailable like(tQWCRDTAA_BytesAvailable);
  BytesReturned like(tQWCRDTAA_BytesReturned);
  TypeOfValueReturned like(tQWCRDTAA_TypeOfValueReturned);
  LibraryName like(tQWCRDTAA_LibraryName);
  LengthOfValueReturned like(tQWCRDTAA_LengthOfValueReturned);
  NumberOfDecimalPositions like(tQWCRDTAA_NumberOfDecimalPositions);
  Value like(tQWCRDTAA_Value);
end-ds;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr RetrieveDataArea extpgm('QWCRDTAA');
  FormatOfDataReturned like(tQWCRDTAA_FormatOfDataReturned) const;
  LengthOfReceiverVariable like(tQWCRDTAA_LengthOfReceiverVariable) const;
  QualifiedDataAreaName like(tQWCRDTAA_QualifiedDataAreaName) const;
  StartingPosition like(tQWCRDTAA_StartingPosition) const;
  LengthOfData like(tQWCRDTAA_LengthOfData) const;
  ErrorCode likeds(tQUSEC);
end-pr;
