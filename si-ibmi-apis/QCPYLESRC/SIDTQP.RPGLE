**FREE

/if not defined(SIDTQP)
  /define SIDTQP
/else
  /eof
/endif

/include qcpylesrc/qmhsndpmp
/include qcpylesrc/siiiap

//==========================================================================================
// Constant
//==========================================================================================

dcl-c cSIDTQ_QCPFMSG const('QCPFMSG   QSYS');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIDTQ like(tSIDTQ_Def) template;

dcl-s tSIDTQ_Name like(tQSNDDTAQ_DataQueueName) template;
dcl-s tSIDTQ_Library like(tQSNDDTAQ_LibraryName) template;
dcl-s tSIDTQ_WaitTime like(tQRCVDTAQ_WaitTime) template;
dcl-s tSIDTQ_Data like(tQRCVDTAQ_Data) template;
dcl-s tSIDTQ_SenderInformation like(tQRCVDTAQ_SenderInformation) template;

dcl-ds tSIDTQ_Def qualified;
  Name like(tSIDTQ_Name);
  Library like(tSIDTQ_Library);
  WaitTime like(tSIDTQ_WaitTime);
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
