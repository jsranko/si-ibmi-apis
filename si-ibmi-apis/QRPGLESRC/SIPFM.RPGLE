**FREE

//******************************************************************************************
//
//
// Programname    : SIPFM
// Programautor   : Sranko Informatik
// Created on     : 19.05.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makesiiia
//
//==========================================================================================

ctl-opt NoMain;

/include qcpylesrc/sictlopt

//==========================================================================================
// Constants
//==========================================================================================

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SIPFM
/include qcpylesrc/sipfmp

/include qcpylesrc/fidsp

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SIPFM_new export;
dcl-pi SIPFM_new like(tSIPFM) extproc(*dclcase);
  Libraryname like(tSIPFM_Libraryname) options(*varsize) const;
  Filename like(tSIPFM_Filename) options(*varsize) const;
  Membername like(tSIPFM_Membername) options(*varsize) const;
end-pi;
dcl-ds SIPFM likeds(tSIPFM_Def) inz;

  SIPFM.Libraryname = Libraryname;
  SIPFM.Filename = Filename;
  SIPFM.Membername = Membername;

  return SIPFM;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIPFM_listRecords export;
dcl-pi SIPFM_listRecords like(tSIPFM_List) extproc(*dclcase);
  SIPFM like(tSIPFM);
end-pi;
dcl-f Member disk(cSIPFM_Buffer_Size) usage(*input) usropn extmbr(Membername) extfile(Filename) infds(OpenFb);
dcl-s Filename varchar(21);
dcl-s Membername like(tSIPFM_Membername);
dcl-s Liste like(tSIPFM_List);
dcl-ds Buffer len(cSIPFM_Buffer_Size);
end-ds;
dcl-ds OpenFb likeds(tFIDS_OpenFeedback);
dcl-ds dsSIPFM likeds(tSIPFM_Def) based(pSIPFM);

  pSIPFM = %addr(SIPFM);

  Membername = dsSIPFM.Membername;
  Filename = dsSIPFM.Libraryname + '/' + dsSIPFM.Filename;

  open Member;

  dsSIPFM.RecordLength = OpenFb.MaxRecordLength;

  dow not %shtdn();
    read(e) Member Buffer;
    if %eof(Member);
      leave;
    endif;
    SIITR_addEntry(Liste:%addr(Buffer):dsSIPFM.RecordLength);
  enddo;

  close Member;

  return Liste;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIPFM_getRecordLength export;
dcl-pi SIPFM_getRecordLength like(tSIPFM_RecordLength) extproc(*dclcase);
  SIPFM like(tSIPFM);
end-pi;
dcl-ds dsSIPFM likeds(tSIPFM_Def) based(pSIPFM);

  pSIPFM = %addr(SIPFM);

  return dsSIPFM.RecordLength;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIPFM_close export;
dcl-pi SIPFM_close extproc(*dclcase);
  SIPFM like(tSIPFM);
end-pi;
dcl-ds dsSIPFM likeds(tSIPFM_Def) based(pSIPFM);

  pSIPFM = %addr(SIPFM);

  clear dsSIPFM;

  return;
end-proc;
