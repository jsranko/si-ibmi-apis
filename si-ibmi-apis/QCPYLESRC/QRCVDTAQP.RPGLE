**FREE
/if not defined(QRCVDTAQP)
  /define QRCVDTAQP
/else
  /eof
/endif

/include qcpylesrc/qusecp

//==========================================================================================
// Constant
//==========================================================================================

dcl-c cQRCVDTAQ_Max_Entry_Len const(64512);

dcl-c cQRCVDTAQ_WaitTime_Forever const(-1);
dcl-c cQRCVDTAQ_WaitTime_None const(0);

dcl-c cQRCVDTAQ_KeyOrder_GT const('GT');
dcl-c cQRCVDTAQ_KeyOrder_LT const('LT');
dcl-c cQRCVDTAQ_KeyOrder_NE const('NE');
dcl-c cQRCVDTAQ_KeyOrder_EQ const('EQ');
dcl-c cQRCVDTAQ_KeyOrder_GE const('GE');
dcl-c cQRCVDTAQ_KeyOrder_LE const('LE');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tQRCVDTAQ_DataQueueName char(10) template;
dcl-s tQRCVDTAQ_LibraryName char(10) template;
dcl-s tQRCVDTAQ_LengthOfData packed(5:0) template;
dcl-s tQRCVDTAQ_Data char(cQRCVDTAQ_Max_Entry_Len) template;
dcl-s tQRCVDTAQ_WaitTime packed(5:0) template;
dcl-s tQRCVDTAQ_KeyOrder char(2) template;
dcl-s tQRCVDTAQ_LengthOfKeyData packed(3:0) template;
dcl-s tQRCVDTAQ_KeyData char(999) template;
dcl-s tQRCVDTAQ_LengthOfSenderInformation packed(3:0) template;
dcl-s tQRCVDTAQ_SenderInformation char(999) template;
dcl-s tQRCVDTAQ_RemoveMessage char(10) template;
dcl-s tQRCVDTAQ_SizeOfDataReceiver packed(5:0) template;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr ReceiveDataQueue extpgm('QRCVDTAQ');
  DataQueueName like(tQRCVDTAQ_DataQueueName) const;
  LibraryName like(tQRCVDTAQ_LibraryName) const;
  LengthOfData like(tQRCVDTAQ_LengthOfData);
  Data like(tQRCVDTAQ_Data);
  WaitTime like(tQRCVDTAQ_WaitTime) const options(*nopass);
  KeyOrder like(tQRCVDTAQ_KeyOrder) options(*nopass);
  LengthOfKeyData like(tQRCVDTAQ_LengthOfKeyData) options(*nopass);
  KeyData like(tQRCVDTAQ_KeyData) options(*nopass);
  LengthOfSenderInformation like(tQRCVDTAQ_LengthOfSenderInformation) options(*nopass);
  SenderInformation like(tQRCVDTAQ_SenderInformation) options(*nopass);
  RemoveMessage like(tQRCVDTAQ_RemoveMessage) options(*nopass);
  SizeOfDataReceiver like(tQRCVDTAQ_SizeOfDataReceiver) options(*nopass);
  ErrorCode likeds(tQUSEC) options(*nopass);
end-pr;
