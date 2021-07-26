**FREE

//******************************************************************************************
//
//
// Programname    : SIEMAIL
// Programautor   : Sranko Informatik
// Created on     : 17.02.2021
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
// Constant
//==========================================================================================

dcl-c cATTACHMENT const('ATTACHMENT');
dcl-c cBODY const('BODY');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tTypeOfContentType varchar(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

 /define SIEMAIL
 /include qcpylesrc/siemailp

 /include qcpylesrc/systemp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_new export;
dcl-pi SIEMAIL_new like(tSIEMAIL) extproc(*dclcase);
  From like(tSIEMAIL_EmailAddress) const options(*omit:*nopass);
  Subject like(tSIEMAIL_Subject) const options(*omit:*nopass);
end-pi;
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) inz;

  if %parms() >= %parmnum(From);
    if %addr(From) <> *null;
      dsSIEMAIL.From = From;
      SIEMAIL_setFrom(dsSIEMAIL:From);
    endif;
  endif;

  if %parms() >= %parmnum(Subject);
    if %addr(Subject) <> *null;
      SIEMAIL_setSubject(dsSIEMAIL:Subject);
    endif;
  endif;

  return dsSIEMAIL;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_setFrom export;
dcl-pi SIEMAIL_setFrom ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  From like(tSIEMAIL_EmailAddress) const;
end-pi;
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  dsSIEMAIL.From = From;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_addTo export;
dcl-pi SIEMAIL_addTo ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  To like(tSIEMAIL_EmailAddress) const;
end-pi;
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  dsSIEMAIL.To.Count += 1;
  dsSIEMAIL.To.Data(dsSIEMAIL.To.Count) = To;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_addCc export;
dcl-pi SIEMAIL_addCc ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Cc like(tSIEMAIL_EmailAddress) const;
end-pi;
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  dsSIEMAIL.Cc.Count += 1;
  dsSIEMAIL.Cc.Data(dsSIEMAIL.Cc.Count) = Cc;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_addBcc export;
dcl-pi SIEMAIL_addBcc ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Bcc like(tSIEMAIL_EmailAddress) const;
end-pi;
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  dsSIEMAIL.Bcc.Count += 1;
  dsSIEMAIL.Bcc.Data(dsSIEMAIL.Bcc.Count) = Bcc;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_setSubject export;
dcl-pi SIEMAIL_setSubject ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Subject like(tSIEMAIL_Subject) const;
end-pi;
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  dsSIEMAIL.Subject = Subject;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_setBody export;
dcl-pi SIEMAIL_setBody ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Body like(tSIEMAIL_Body) const;
  ContentType like(tSIEMAIL_ContentType) const options(*nopass);
end-pi;
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  if %parms >= %parmnum(ContentType);
    if isContentTypeValid(ContentType:cBODY);
      dsSIEMAIL.Body.ContentType = ContentType;
    else;
      return *off;
    endif;
  else;
    dsSIEMAIL.Body.ContentType = cSIEMAIL_BODY_PLAIN;
  endif;

  dsSIEMAIL.Body.Data = Body;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_addAttachment export;
dcl-pi SIEMAIL_addAttachment ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  PathToAttachment like(tSIEMAIL_Path) const;
  ContentType like(tSIEMAIL_ContentType) const options(*nopass);
end-pi;
dcl-s sContentType like(tSIEMAIL_ContentType);
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  if %parms >= %parmnum(ContentType);
    if isContentTypeValid(ContentType:cATTACHMENT);
      sContentType = ContentType;
    else;
      return *off;
    endif;
  else;
    sContentType = cSIEMAIL_ATTACH_OCTET;
  endif;

  dsSIEMAIL.Attachments.Count += 1;
  dsSIEMAIL.Attachments.File(dsSIEMAIL.Attachments.Count).Path = PathToAttachment;
  dsSIEMAIL.Attachments.File(dsSIEMAIL.Attachments.Count).ContentType = sContentType;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_send export;
dcl-pi SIEMAIL_send ind extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Engine like(tSIEMAIL_Engine) const options(*omit:*nopass);
end-pi;
dcl-s sEngine like(tSIEMAIL_Engine);
dcl-s sCmd like(tSIEMAIL_Command);

  if %parms() >= %parmnum(Engine);
    if %addr(Engine) <> *null;
      sCmd = getCMD(SIEMAIL:Engine);
    endif;
  else;
    sCmd = getCMD(SIEMAIL);
  endif;

  if system(sCMD) <> cSystem_Return_Succesful;
    return *off;
  endif;

return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIEMAIL_toString export;
dcl-pi SIEMAIL_toString like(tSIEMAIL_Command) extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Engine like(tSIEMAIL_Engine) const options(*omit:*nopass);
end-pi;
dcl-s sCmd like(tSIEMAIL_Command);

  if %parms() >= %parmnum(Engine);
    if %addr(Engine) <> *null;
      sCmd = getCMD(SIEMAIL:Engine);
    endif;
  else;
    sCmd = getCMD(SIEMAIL);
  endif;

  return sCMD;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getSNDSMTPEMM;
dcl-pi getSNDSMTPEMM like(tSIEMAIL_Command) extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Engine like(tSIEMAIL_Engine) const options(*omit:*nopass);
end-pi;
dcl-s idx like(tSIEMAIL_Count);
dcl-s output like(tSIEMAIL_Command);
dcl-s sAtts like(tSIEMAIL_Command);
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  for idx = 1 to dsSIEMAIL.To.Count;
    output = '(''' + dsSIEMAIL.To.Data(idx) + ''' *PRI'+ ') ';
  endfor;

  for idx = 1 to dsSIEMAIL.Cc.Count;
    output = output + '(''' + dsSIEMAIL.Cc.Data(idx) + ''' *CC'+ ') ';
  endfor;

  for idx = 1 to dsSIEMAIL.Bcc.Count;
    output = output + '(''' + dsSIEMAIL.Bcc.Data(idx) + ''' *BCC'+ ') ';
  endfor;

  for idx = 1 to dsSIEMAIL.Attachments.Count;
    sAtts = sAtts + '(''' + dsSIEMAIL.Attachments.File(idx).Path + ''' ' +
            dsSIEMAIL.Attachments.File(idx).ContentType + ' ' +
            '*BIN) ';
  endfor;

  output = 'QSYS/SNDSMTPEMM RCP(' + output + ') ' +
              'SUBJECT(''' + dsSIEMAIL.Subject + ''') ' +
              'NOTE(''' + dsSIEMAIL.Body.Data + ''') ' +
              'CHARSET(*UTF8 *DFT) ' +
              'SMIME(*NONE) ' +
              'ATTACH(' + sAtts + ') ' +
              'CONTENT(' + dsSIEMAIL.Body.ContentType + ') ';

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getCURL;
dcl-pi getCURL like(tSIEMAIL_Command) extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Engine like(tSIEMAIL_Engine) const options(*omit:*nopass);
end-pi;
dcl-s output like(tSIEMAIL_Command);
dcl-ds dsSIEMAIL likeds(tSIEMAIL_Def) based(pSIEMAIL);

  pSIEMAIL = %addr(SIEMAIL);

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isContentTypeValid;
dcl-pi isContentTypeValid ind;
  ContentType like(tSIEMAIL_ContentType) const;
  TypeOfContentType like(tTypeOfContentType) const;
end-pi;
dcl-s output ind inz(*off);

  select;
  when TypeOfContentType = cATTACHMENT;
    exsr attachment;
  when TypeOfContentType = cBODY;
    exsr body;
  endsl;

  return output;

  // ------------------------------------------------------------
  begsr attachment;

    if ContentType = cSIEMAIL_ATTACH_OCTET
    or ContentType = cSIEMAIL_ATTACH_PLAIN
    or ContentType = cSIEMAIL_ATTACH_HTML
    or ContentType = cSIEMAIL_ATTACH_XML
    or ContentType = cSIEMAIL_ATTACH_RTF
    or ContentType = cSIEMAIL_ATTACH_OGG
    or ContentType = cSIEMAIL_ATTACH_PDF
    or ContentType = cSIEMAIL_ATTACH_VISIO
    or ContentType = cSIEMAIL_ATTACH_ZIP
    or ContentType = cSIEMAIL_ATTACH_POST
    or ContentType = cSIEMAIL_ATTACH_L123
    or ContentType = cSIEMAIL_ATTACH_FREE
    or ContentType = cSIEMAIL_ATTACH_WORD
    or ContentType = cSIEMAIL_ATTACH_WORDPRO
    or ContentType = cSIEMAIL_ATTACH_POWERPT
    or ContentType = cSIEMAIL_ATTACH_EXCEL
    or ContentType = cSIEMAIL_ATTACH_AC3
    or ContentType = cSIEMAIL_ATTACH_MP3
    or ContentType = cSIEMAIL_ATTACH_WAV
    or ContentType = cSIEMAIL_ATTACH_GIF
    or ContentType = cSIEMAIL_ATTACH_JPEG
    or ContentType = cSIEMAIL_ATTACH_PNG
    or ContentType = cSIEMAIL_ATTACH_MPEG
    or ContentType = cSIEMAIL_ATTACH_MSG
    or ContentType = cSIEMAIL_ATTACH_BMP;
      output = *on;
    else;
      output = *off;
    endif;

  endsr;

  // ------------------------------------------------------------
  begsr body;

    if ContentType = cSIEMAIL_BODY_PLAIN
    or ContentType = cSIEMAIL_BODY_HTML
    or ContentType = cSIEMAIL_BODY_XML;
      output = *on;
    else;
      output = *off;
    endif;

  endsr;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getCMD;
dcl-pi getCMD like(tSIEMAIL_Command) extproc(*dclcase);
  SIEMAIL like(tSIEMAIL);
  Engine like(tSIEMAIL_Engine) const options(*omit:*nopass);
end-pi;
dcl-s output like(tSIEMAIL_Command);
dcl-s sEngine like(tSIEMAIL_Engine);

  if %parms() >= %parmnum(Engine);
    if %addr(Engine) <> *null;
      sEngine = Engine;
    endif;
  endif;

  select;
  when sEngine = cSIEMAIL_CURL;
    output = getCURL(SIEMAIL);
  when sEngine = cSIEMAIL_SNDSMTPEMM;
    output = getSNDSMTPEMM(SIEMAIL);
  other;
    output = getSNDSMTPEMM(SIEMAIL);
  endsl;

  return output;
end-proc;
