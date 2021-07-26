**FREE

/if not defined(SIXCPP)
  /define SIXCPP
/else
  /eof
/endif

/include qcpylesrc/qmhsndpmp
/include qcpylesrc/siiiap

//==========================================================================================
// Constant
//==========================================================================================

dcl-c cSIXCP_QCPFMSG const('QCPFMSG   QSYS');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIXCP_MessageId like(tQMHSNDPM_MessageIdentifier) template;
dcl-s tSIXCP_MessageFile like(tQMHSNDPM_QualifiedMessageFileName) template;
dcl-s tSIXCP_MessageData like(tQMHSNDPM_MessageData) template;
dcl-s tSIXCP_CallStackEntryQualification char(20) template;
dcl-s tSIXCP_Year packed(4:0) template;

/if defined(SIXCP)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIXCP_throw extproc(*dclcase);
end-pr;

dcl-pr SIXCP_throwWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
  CallStackEntryQualification like(tSIXCP_CallStackEntryQualification) const options(*nopass);
end-pr;

dcl-pr SIXCP_throwWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
  CallStackEntryQualification like(tSIXCP_CallStackEntryQualification)
    const options(*nopass);
end-pr;

dcl-pr SIXCP_status extproc(*dclcase);
end-pr;

dcl-pr SIXCP_statusWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
end-pr;

dcl-pr SIXCP_statusWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pr;

dcl-pr SIXCP_diag extproc(*dclcase);
end-pr;

dcl-pr SIXCP_diagWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
end-pr;

dcl-pr SIXCP_diagWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pr;

dcl-pr SIXCP_info extproc(*dclcase);
end-pr;

dcl-pr SIXCP_infoWithMessage extproc(*dclcase);
  Message like(tSIXCP_MessageData) const;
end-pr;

dcl-pr SIXCP_infoWithMessageId extproc(*dclcase);
  MessageId like(tSIXCP_MessageId) const;
  MessageData like(tSIXCP_MessageData) const options(*omit);
  MessageFile like(tSIXCP_MessageFile) const;
end-pr;
