**FREE

//******************************************************************************************
//
//
// Programname    : SIDTQ
// Programautor   : Sranko Informatik
// Created on     : 24.03.2022
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

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SIDTQ
/include qcpylesrc/sidtqp

/include qcpylesrc/siodp
/include qcpylesrc/sixcpp
/include qcpylesrc/strlenp
/include qcpylesrc/qrcvdtaqp
/include qcpylesrc/qsnddtaqp
/include qcpylesrc/siobjtypp
/include qcpylesrc/systemp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_new export;
dcl-pi SIDTQ_new like(tSIDTQ) extproc(*dclcase);
  Name like(tSIDTQ_Name) value;
  Library like(tSIDTQ_Library) value;
  WaitTime like(tSIDTQ_WaitTime) const options(*nopass);
end-pi;
dcl-s sWaitTime like(tSIDTQ_WaitTime) inz(cQRCVDTAQ_WaitTime_Forever);
dcl-s dtaqObj like(tSIOD);
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) inz;

  if %parms >= %parmnum(WaitTime);
     sWaitTime = WaitTime;
  endif;

  dtaqObj = SIOD_new(Library:Name:cOBJECTTYPE_DataQueue);
  if SIOD_exist(dtaqObj);
     dsSIDTQ.Library = SIOD_getReturnLibrary(dtaqObj);
  else;
     dsSIDTQ.Library = Library;
  endif;

  dsSIDTQ.Name = Name;
  SIDTQ_setWaitTime(dsSIDTQ:sWaitTime);

  return dsSIDTQ;
on-exit;
    SIOD_close(dtaqObj);
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_close export;
dcl-pi SIDTQ_close extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pi;
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);
  clear dsSIDTQ;

on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_write export;
dcl-pi SIDTQ_write ind extproc(*dclcase);
  SIDTQ like(tSIDTQ);
  Data pointer value options(*string);
  DataLen like(tSIDTQ_DataLen) value options(*nopass);
end-pi;
dcl-s nDataLen like(tSIDTQ_DataLen);
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  if %parms >= %parmnum(DataLen);
     nDataLen = DataLen;
  else;
     nDataLen = strlen(Data);
  endif;

  monitor;
     SendDataQueue(dsSIDTQ.Name
                  :dsSIDTQ.Library
                  :nDataLen
                  :%str(Data));
  on-error;
     return *off;
  endmon;

  return *on;

on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_read export;
dcl-pi SIDTQ_read like(tQSNDDTAQ_Data) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pi;
dcl-s DataLen like(tQRCVDTAQ_LengthOfData);
dcl-s KeyOrder like(tQRCVDTAQ_KeyOrder) inz(*blanks);
dcl-s LengthOfKeyData like(tQRCVDTAQ_LengthOfKeyData) inz(0);
dcl-s KeyData like(tQRCVDTAQ_KeyData);
dcl-s LengthOfSenderInformation like(tQRCVDTAQ_LengthOfSenderInformation) inz(%size(SenderInformation));
dcl-s SenderInformation like(tQRCVDTAQ_SenderInformation);
dcl-s output like(tQRCVDTAQ_Data);
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  monitor;
     ReceiveDataQueue(dsSIDTQ.Name
                     :dsSIDTQ.Library
                     :DataLen
                     :output
                     :dsSIDTQ.WaitTime
                     :KeyOrder
                     :LengthOfKeyData
                     :KeyData
                     :LengthOfSenderInformation
                     :SenderInformation);
  on-error;
     return *allx'00';
  endmon;

  dsSIDTQ.DataLen = DataLen;
  dsSIDTQ.SenderInformation = SenderInformation;

  return output;

on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_setWaitTime export;
dcl-pi SIDTQ_setWaitTime extproc(*dclcase);
  SIDTQ like(tSIDTQ);
  WaitTime like(tSIDTQ_WaitTime);
end-pi;
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  dsSIDTQ.WaitTime = WaitTime;

  return;
on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_getSenderInformation export;
dcl-pi SIDTQ_getSenderInformation like(tQRCVDTAQ_SenderInformation) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pi;
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  return dsSIDTQ.SenderInformation;
on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_getDataLen export;
dcl-pi SIDTQ_getDataLen like(tSIDTQ_DataLen) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pi;
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  return dsSIDTQ.DataLen;
on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_exist export;
dcl-pi SIDTQ_exist ind extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pi;
dcl-s dtaqObj like(tSIOD);
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  dtaqObj = SIOD_new(dsSIDTQ.Library:dsSIDTQ.Name:cOBJECTTYPE_DataQueue);
  return SIOD_exist(dtaqObj);

on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_create export;
dcl-pi SIDTQ_create ind extproc(*dclcase);
  SIDTQ like(tSIDTQ);
  Type like(tSIDTQ_Type) const options(*nopass:*omit);
  MaxLen like(tSIDTQ_MaxLen) const options(*nopass:*omit);
  Seq like(tSIDTQ_Seq) const options(*nopass:*omit);
  SizeMaxCount like(tSIDTQ_SizeMaxCount) const options(*nopass:*omit);
  SizeCurrCount like(tSIDTQ_SizeCurrCount) const options(*nopass:*omit);
  Aut  like(tSIDTQ_Aut) const options(*nopass:*omit);
end-pi;
dcl-s sType like(tSIDTQ_Type) inz('*STD');
dcl-s nMaxLen like(tSIDTQ_MaxLen) inz(100);
dcl-s sSeq like(tSIDTQ_Seq) inz('*FIFO');
dcl-s sSizeMaxCount like(tSIDTQ_SizeMaxCount) inz('*MAX16MB');
dcl-s nSizeCurrCount like(tSIDTQ_SizeCurrCount) inz(16);
dcl-s sAut  like(tSIDTQ_Aut) inz('*LIBCRTAUT');
dcl-s cmd varchar(512);
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  if %parms >= %parmnum(Type)
  and %addr(Type) <> *null;
     sType = Type;
  endif;

  if %parms >= %parmnum(MaxLen)
  and %addr(MaxLen) <> *null;
     nMaxLen = MaxLen;
  endif;

  if %parms >= %parmnum(Seq)
  and %addr(Seq) <> *null;
     sSeq = Seq;
  endif;

  if %parms >= %parmnum(SizeMaxCount)
  and %addr(SizeMaxCount) <> *null;
     sSizeMaxCount = SizeMaxCount;
  endif;

  if %parms >= %parmnum(SizeCurrCount)
  and %addr(SizeCurrCount) <> *null;
     nSizeCurrCount = SizeCurrCount;
  endif;

  if %parms >= %parmnum(Aut)
  and %addr(Aut) <> *null;
     sAut = Aut;
  endif;

  cmd = 'CRTDTAQ DTAQ(' + dsSIDTQ.Library + '/' + dsSIDTQ.Name + ') ' +
               ' TYPE(' + sType + ') ' +
               ' MAXLEN(' + %editc(nMaxLen:'X') + ') ' +
               ' SEQ(' + sSeq + ') ' +
               ' SIZE(' + sSizeMaxCount + ' ' + %editc(nSizeCurrCount:'X') + ') ' +
               ' AUT(' + sAut + ') ';
  if system(cmd) <> cSystem_Return_Succesful;

  endif;

  return *on;

on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_getName export;
dcl-pi SIDTQ_getName like(tSIDTQ_Name) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pi;
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  return dsSIDTQ.Name;
on-exit;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIDTQ_getLibrary export;
dcl-pi SIDTQ_getLibrary like(tSIDTQ_Library) extproc(*dclcase);
  SIDTQ like(tSIDTQ);
end-pi;
dcl-ds dsSIDTQ likeds(tSIDTQ_Def) based(pSIDTQ);

  pSIDTQ = %addr(SIDTQ);

  return dsSIDTQ.Library;
on-exit;
end-proc;
