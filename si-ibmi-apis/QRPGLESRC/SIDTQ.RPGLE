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
  if not SIOD_exist(dtaqObj);
     SIXCP_throwWithMessage(Library + ' not valid.');
  endif;

  dsSIDTQ.Name = Name;
  dsSIDTQ.Library = SIOD_getReturnLibrary(dtaqObj);
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
