**FREE
/if defined(QCDRCMDDp)
/eof
/endif

/define QCDRCMDDp

/include qcpylesrc/qusecp

// -----------------------------------------------------------------------------
dcl-c cQCDRCMDD_Format_DEST0100 const('DEST0100');
dcl-c cQCDRCMDD_Format_DEST0200 const('DEST0200');
// -----------------------------------------------------------------------------
dcl-s tQCDRCMDD_QualifiedCommandName char(20) template;
dcl-s tQCDRCMDD_DestinationInformationF100 int(10) template;
dcl-s tQCDRCMDD_DestinationFormatName char(8) template;
dcl-s tQCDRCMDD_ReceiverVariable char(32765) template;
dcl-s tQCDRCMDD_ReceiverFormatName char(8) template;
// -----------------------------------------------------------------------------
dcl-pr RetrieveCommandDefinitionF100 extpgm('QCDRCMDD');
  QualifiedCommandName like(tQCDRCMDD_QualifiedCommandName) const;
  DestinationInformation like(tQCDRCMDD_DestinationInformationF100) const;
  DestinationFormatName like(tQCDRCMDD_DestinationFormatName) const;
  ReceiverVariable like(tQCDRCMDD_ReceiverVariable) options(*varsize);
  ReceiverFormatName like(tQCDRCMDD_ReceiverFormatName);
  ErrorCode like(tQUSEC);
end-pr;
