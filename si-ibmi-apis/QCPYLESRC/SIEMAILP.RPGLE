**FREE

/if not defined( SIEMAILP)
  /define  SIEMAILP
/else
  /eof
/endif

//==========================================================================================
// Constant
//==========================================================================================

dcl-c cSIEMAIL_Count_Recipients const(20);
dcl-c cSIEMAIL_Count_Attachments const(20);
dcl-c cSIEMAIL_ATTACH_OCTET const('*OCTET');
dcl-c cSIEMAIL_ATTACH_PLAIN const('*PLAIN');
dcl-c cSIEMAIL_ATTACH_HTML const('*HTML');
dcl-c cSIEMAIL_ATTACH_XML const('*XML');
dcl-c cSIEMAIL_ATTACH_RTF const('*RTF');
dcl-c cSIEMAIL_ATTACH_OGG const('*OGG');
dcl-c cSIEMAIL_ATTACH_PDF const('*PDF');
dcl-c cSIEMAIL_ATTACH_VISIO const('*VISIO');
dcl-c cSIEMAIL_ATTACH_ZIP const('*ZIP');
dcl-c cSIEMAIL_ATTACH_POST const('*POST');
dcl-c cSIEMAIL_ATTACH_L123 const('*L123');
dcl-c cSIEMAIL_ATTACH_FREE const('*FREE');
dcl-c cSIEMAIL_ATTACH_WORD const('*WORD');
dcl-c cSIEMAIL_ATTACH_WORDPRO const('*WORDPRO');
dcl-c cSIEMAIL_ATTACH_POWERPT const('*POWERPT');
dcl-c cSIEMAIL_ATTACH_EXCEL const('*EXCEL');
dcl-c cSIEMAIL_ATTACH_AC3 const('*AC3');
dcl-c cSIEMAIL_ATTACH_MP3 const('*MP3');
dcl-c cSIEMAIL_ATTACH_WAV const('*WAV');
dcl-c cSIEMAIL_ATTACH_GIF const('*GIF');
dcl-c cSIEMAIL_ATTACH_JPEG const('*JPEG');
dcl-c cSIEMAIL_ATTACH_PNG const('*PNG');
dcl-c cSIEMAIL_ATTACH_MPEG const('*MPEG');
dcl-c cSIEMAIL_ATTACH_MSG const('*MSG');
dcl-c cSIEMAIL_ATTACH_BMP const('*BMP');
dcl-c cSIEMAIL_BODY_PLAIN const('*PLAIN');
dcl-c cSIEMAIL_BODY_HTML const('*HTML');
dcl-c cSIEMAIL_BODY_XML const('*XML');
dcl-c cSIEMAIL_SNDSMTPEMM const('SNDSMTPEMM');
dcl-c cSIEMAIL_CURL const('cURL');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIEMAIL like(tSIEMAIL_Def) template;
dcl-s tSIEMAIL_EmailAddress varchar(256) template;
dcl-s tSIEMAIL_Engine varchar(10) template;
dcl-s tSIEMAIL_Path varchar(256) template;
dcl-s tSIEMAIL_Subject varchar(256) template;
dcl-s tSIEMAIL_Body varchar(5000) template;
dcl-s tSIEMAIL_ContentType varchar(10) template;
dcl-s tSIEMAIL_Command varchar(32000) template;
dcl-s tSIEMAIL_Count int(5) template;

dcl-ds tSIEMAIL_Recipient qualified template;
  Count like(tSIEMAIL_Count);
  Data like(tSIEMAIL_EmailAddress) dim(cSIEMAIL_Count_Recipients);
end-ds;

dcl-ds tSIEMAIL_Attachment qualified template;
  Path like(tSIEMAIL_Path);
  ContentType like(tSIEMAIL_ContentType);
end-ds;

dcl-ds tSIEMAIL_Attachments qualified template;
  Count like(tSIEMAIL_Count);
  File likeds(tSIEMAIL_Attachment) dim(cSIEMAIL_Count_Attachments);
end-ds;

dcl-ds tSIEMAIL_Def qualified template;
  From like(tSIEMAIL_EmailAddress);
  To likeds(tSIEMAIL_Recipient);
  Cc likeds(tSIEMAIL_Recipient);
  Bcc likeds(tSIEMAIL_Recipient);
  Subject like(tSIEMAIL_Subject);
  dcl-ds Body ;
    Data like(tSIEMAIL_Body);
    ContentType like(tSIEMAIL_ContentType);
  end-ds;
  Attachments likeds(tSIEMAIL_Attachments);
end-ds;

/if defined( SIEMAIL)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIEMAIL_new like(tSIEMAIL) extproc(*dclcase);
  From like(tSIEMAIL_EmailAddress) const options(*omit:*nopass);
  Subject like(tSIEMAIL_Subject) const options(*omit:*nopass);
end-pr;

dcl-pr SIEMAIL_setFrom ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  From like(tSIEMAIL_EmailAddress) const;
end-pr;

dcl-pr SIEMAIL_addTo ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  To like(tSIEMAIL_EmailAddress) const;
end-pr;

dcl-pr SIEMAIL_addCc ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Cc like(tSIEMAIL_EmailAddress) const;
end-pr;

dcl-pr SIEMAIL_addBcc ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Bcc like(tSIEMAIL_EmailAddress) const;
end-pr;

dcl-pr SIEMAIL_setSubject ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Subject like(tSIEMAIL_Subject) const;
end-pr;

dcl-pr SIEMAIL_setBody ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Body like(tSIEMAIL_Body) const;
  ContentType like(tSIEMAIL_ContentType) const options(*nopass);
end-pr;

dcl-pr SIEMAIL_addAttachment ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  PathToAttachment like(tSIEMAIL_Path) const;
end-pr;

dcl-pr SIEMAIL_send ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
end-pr;

dcl-pr SIEMAIL_toString like(tSIEMAIL_Command) extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Engine like(tSIEMAIL_Engine) const options(*omit:*nopass);
end-pr;
