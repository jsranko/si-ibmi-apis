**FREE
//******************************************************************************************
//
//
// Programname    : SIDT
// Programautor   : Sranko Informatik
// Created on     : 20.03.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cLIBL const('*LIBL');
dcl-c cFIRST const('*FIRST');

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

 /define SIRIO
 /include qcpylesrc/siriop

 /include qsysinc/qrpglesrc,errno
 /include qcpylesrc/strerrorp
 /include qcpylesrc/_ropenp
 /include qcpylesrc/_rclosep
 /include qcpylesrc/_rreadnp
 /include qcpylesrc/_rlocatep
 /include qcpylesrc/_rreadpp
 /include qcpylesrc/_rupdatep
 /include qcpylesrc/_rwritedp
 /include qcpylesrc/_rwritep
 /include qcpylesrc/_rdeletep
 /include qcpylesrc/_riofbkp
 /include qcpylesrc/_rreadlp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_open export;
dcl-pi SIRIO_open like(tSIRIO) extproc(*dclcase);
  File like(tSIRIO_File) const;
  Library like(tSIRIO_Library) const options(*omit:*nopass);
  Format like(tSIRIO_Format) const options(*omit:*nopass);
  Mode like(tSIRIO_Mode) const options(*nopass);
end-pi;
dcl-s sFile like(tSIRIO_File);
dcl-s sLibrary like(tSIRIO_Library);
dcl-s sFormat like(tSIRIO_Format);
dcl-s sMode char(256);
dcl-s filename char(33);
dcl-ds dsSIRIO likeds(tSIRIO_Def);

  sFile = File;

  if %parms() >= %parmnum(Library);
    if %addr(Library) <> *null;
      sLibrary = Library;
    else;
      sLibrary = cLIBL;
    endif;
  else;
    sLibrary = cLIBL;
  endif;

  if %parms() >= %parmnum(Format);
    if %addr(Format) <> *null;
      sFormat = Format;
    else;
      sFormat = cFIRST;
    endif;
  else;
    sFormat = cFIRST;
  endif;

  if %parms() >= %parmnum(Mode);
    if %addr(Mode) <> *null;
      sMode = Mode;
    else;
      sMode = cRECIO_READ_ONLY;
    endif;
  else;
    sMode = cRECIO_READ_ONLY;
  endif;
  sMode = %trim(sMode) + ', nullcap=Y, arrseq=N';
  filename = sLibrary + '/' + sFile + '(' + sFormat + ')';

  dsSIRIO.fp = Ropen(%trim(filename):%trim(sMode));
  if dsSIRIO.fp = *null;
    dsSIRIO.error = getError(dsSIRIO);
  endif;

  return dsSIRIO;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_close export;
dcl-pi SIRIO_close ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);
dcl-s output like(tRclose_Return);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  output = rclose(dsSIRIO.fp);
  if output <> cRclose_Success;
    dsSIRIO.error = getError(SIRIO);
    return *off;
  endif;

  return isError(dsSIRIO);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_readNext export;
dcl-pi SIRIO_readNext ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
  Options like(tSIRIO_Options) const;
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rreadn(dsSIRIO.fp:Buffer:BufferLength:Options);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = BufferLength;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_readNextWithLock export;
dcl-pi SIRIO_readNextWithLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pi;

  return SIRIO_readNext(SIRIO:Buffer:BufferLength:cRECIO_DFT);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_readNextNoLock export;
dcl-pi SIRIO_readNextNoLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pi;

  return SIRIO_readNext(SIRIO:Buffer:BufferLength:cRECIO_NO_LOCK);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setBOF export;
dcl-pi SIRIO_setBOF ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:*null:0:cRECIO_START);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = tRlocate_Successful;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setGT export;
dcl-pi SIRIO_setGT ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key) const;
  KeyLength like(tSIRIO_KeyLength) const;
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:Key:KeyLength:cRECIO_KEY_GT);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = tRlocate_Successful;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setLL export;
dcl-pi SIRIO_setLL ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key) const;
  KeyLength like(tSIRIO_KeyLength) const;
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:Key:KeyLength:cRECIO_KEY_LT );
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = tRlocate_Successful;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setEOF export;
dcl-pi SIRIO_setEOF ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:*null:0:cRECIO_END);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = tRlocate_Successful;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setFIRST export;
dcl-pi SIRIO_setFIRST ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:*null:0:cRECIO_FIRST);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = tRlocate_Successful;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setLAST export;
dcl-pi SIRIO_setLAST ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:*null:0:cRECIO_LAST);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = tRlocate_Successful;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_readPrevious export;
dcl-pi SIRIO_readPrevious ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
  Options like(tSIRIO_Options) const;
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);
  init(dsSIRIO);

  dsSIRIO.fb = Rreadp(dsSIRIO.fp:Buffer:BufferLength:Options);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = BufferLength;
    dsSIRIO.found = *on;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_readPreviousWithLock export;
dcl-pi SIRIO_readPreviousWithLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pi;

  return SIRIO_readPrevious(SIRIO:Buffer:BufferLength:cRECIO_DFT);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_readPreviousNoLock export;
dcl-pi SIRIO_readPreviousNoLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pi;

  return SIRIO_readPrevious(SIRIO:Buffer:BufferLength:cRECIO_NO_LOCK);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_isOpen export;
dcl-pi SIRIO_isOpen ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  if dsSIRIO.fp <> *null;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_isEOF export;
dcl-pi SIRIO_isEOF ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = cRECIO_EOF;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_update export;
dcl-pi SIRIO_update ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  dsSIRIO.fb = Rupdate(dsSIRIO.fp : Buffer : BufferLength);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = BufferLength;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_write export;
dcl-pi SIRIO_write ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-s rrn like(tSIRIO_Rrn);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  //rrn = getNextRRN(dsSIRIO);
  dsSIRIO.fb = Rwrited(dsSIRIO.fp : Buffer : BufferLength: rrn);
  //dsSIRIO.fb = Rwrite(dsSIRIO.fp : Buffer : BufferLength);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = BufferLength;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_delete export;
dcl-pi SIRIO_delete ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  dsSIRIO.fb = Rdelete(dsSIRIO.fp);
  pIoFeedBack = dsSIRIO.fb;
  if ioFeedBack.num_bytes = cRdelete_Success;
    return *on;
  endif;
  dsSIRIO.error = getError(dsSIRIO);

  return *off;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_getErrorAsText export;
dcl-pi SIRIO_getErrorAsText like(tSIRIO_ErrorAsText) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-s output like(tSIRIO_ErrorAsText);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  output = %char(dsSIRIO.error.Nummer) + ': ' +
           %trim(dsSIRIO.error.Text);

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_found export;
dcl-pi SIRIO_found ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  return dsSIRIO.found;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc init;
dcl-pi init;
  dsSIRIO likeds(tSIRIO_Def);
end-pi;

  clear dsSIRIO.error;

  return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getError;
dcl-pi getError likeds(tSIRIO_Error);
  dsSIRIO likeds(tSIRIO_Def);
end-pi;
dcl-s errno int(10) BASED(pErrno);
dcl-ds output likeds(tSIRIO_Error);

  pErrno = getErrnoPtr();
  output.Nummer = errno;
  output.Text = %str(strerror(errno));

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isError;
dcl-pi isError ind;
  dsSIRIO likeds(tSIRIO_Def);
end-pi;
dcl-s errno int(10) BASED(pErrno);
dcl-ds output likeds(tSIRIO_Error);

  dsSIRIO.error = getError(dsSIRIO);

  if dsSIRIO.error.Nummer = *zeros;
    return *off;
  else;
    return *on;
  endif;

end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getNextRRN;
dcl-pi getNextRRN like(tSIRIO_Rrn);
  dsSIRIO likeds(tSIRIO_Def);
end-pi;
dcl-ds ioFeedBack likeds(tRECIO_RIOFB) based(pIoFeedBack);
dcl-s output like(tSIRIO_Rrn);

  pIoFeedBack = Rreadl(dsSIRIO.fp:*null:0:cRECIO_NO_LOCK);
  if pIoFeedBack = *null;
    dsSIRIO.error = getError(dsSIRIO);
    return *zeros;
  endif;

  output = ioFeedBack.rrn + 1;

  return output;

end-proc;
