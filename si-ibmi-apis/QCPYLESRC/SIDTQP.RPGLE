**FREE

/if not defined(SIDTQP)
  /define SIDTQP
/else
  /eof
/endif

/include qcpylesrc/qsnddtaqp
/include qcpylesrc/qrcvdtaqp
/include qcpylesrc/siiiap

//==========================================================================================
// Constant
//==========================================================================================

dcl-c cSIDTQ_QCPFMSG const('QCPFMSG   QSYS');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIDTQ like(tSIDTQ_Def) template;

dcl-s tSIDTQ_Name varchar(10) template;
dcl-s tSIDTQ_Library varchar(10) template;
dcl-s tSIDTQ_WaitTime like(tQRCVDTAQ_WaitTime) template;
dcl-s tSIDTQ_Data like(tQRCVDTAQ_Data) template;
dcl-s tSIDTQ_DataLen like(tQRCVDTAQ_LengthOfData ) template;
dcl-s tSIDTQ_SenderInformation like(tQRCVDTAQ_SenderInformation) template;
dcl-s tSIDTQ_Type varchar(10) template;
dcl-s tSIDTQ_MaxLen int(5) template;
dcl-s tSIDTQ_Seq varchar(10) template;
dcl-s tSIDTQ_SizeMaxCount varchar(10) template;
dcl-s tSIDTQ_SizeCurrCount int(5) template;
dcl-s tSIDTQ_Aut varchar(10) template;

dcl-ds tSIDTQ_Def qualified;
  Name like(tSIDTQ_Name);
  Library like(tSIDTQ_Library);
  WaitTime like(tSIDTQ_WaitTime);
  DataLen like(tSIDTQ_DataLen);
  SenderInformation like(tSIDTQ_SenderInformation);
end-ds;

/if defined(SIDTQ)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIDTQ_new like(tSIDTQ) extproc(*dclcase);
  Name like(tSIDTQ_Name) value;
  Library like(tSIDTQ_Library) value;
  WaitTime like(tSIDTQ_WaitTime) const options(*nopass);
end-pr;

dcl-pr SIDTQ_close extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pr;

dcl-pr SIDTQ_write ind extproc(*dclcase);
  SIDTQ like(tSIDTQ);
  Data pointer value options(*string);
  DataLen like(tSIDTQ_DataLen) value options(*nopass);
end-pr;

dcl-pr SIDTQ_read like(tQSNDDTAQ_Data) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pr;

dcl-pr SIDTQ_setWaitTime extproc(*dclcase);
  SIDTQ like(tSIDTQ);
  WaitTime like(tSIDTQ_WaitTime);
end-pr;

dcl-pr SIDTQ_setSenderInformation like(tQRCVDTAQ_SenderInformation) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pr;

dcl-pr SIDTQ_getDataLen like(tSIDTQ_DataLen) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pr;

dcl-pr SIDTQ_exist ind extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pr;

dcl-pr SIDTQ_create ind extproc(*dclcase);
  SIDTQ like(tSIDTQ);
  Type like(tSIDTQ_Type) const options(*nopass:*omit);
  MaxLen like(tSIDTQ_MaxLen) const options(*nopass:*omit);
  Seq like(tSIDTQ_Seq) const options(*nopass:*omit);
  SizeMaxCount like(tSIDTQ_SizeMaxCount) const options(*nopass:*omit);
  SizeCurrCount like(tSIDTQ_SizeCurrCount) const options(*nopass:*omit);
  Aut  like(tSIDTQ_Aut) const options(*nopass:*omit);
end-pr;

dcl-pr SIDTQ_getName like(tSIDTQ_Name) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pr;

dcl-pr SIDTQ_getLibrary like(tSIDTQ_Library) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pr;
