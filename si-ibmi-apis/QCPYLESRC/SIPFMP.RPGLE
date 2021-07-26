**FREE

/if not defined(SIPFMP)
  /define SIPFMP
/else
  /eof
/endif

/include qcpylesrc/siitrp

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cSIPFM_Buffer_Size const(10000);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIPFM like(tSIPFM_Def) template;
dcl-s tSIPFM_List like(tSIITR) template;
dcl-s tSIPFM_Libraryname varchar(10) template;
dcl-s tSIPFM_Filename varchar(10) template;
dcl-s tSIPFM_Membername varchar(10) template;
dcl-s tSIPFM_RecordLength int(5) template;
dcl-ds tSIPFM_Def qualified template;
  Libraryname like(tSIPFM_Libraryname);
  Filename like(tSIPFM_Filename);
  Membername like(tSIPFM_Membername);
  RecordLength like(tSIPFM_RecordLength);
end-ds;

 /if defined(SIPFM)
 /eof
 /endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIPFM_new like(tSIPFM) extproc(*dclcase);
  Libraryname like(tSIPFM_Libraryname) options(*varsize) const;
  Filename like(tSIPFM_Filename) options(*varsize) const;
  Membername like(tSIPFM_Membername) options(*varsize) const;
end-pr;

dcl-pr SIPFM_listRecords like(tSIPFM_List) extproc(*dclcase);
  SIPFM like(tSIPFM);
end-pr;

dcl-pr SIPFM_getRecordLength like(tSIPFM_RecordLength) extproc(*dclcase);
  SIPFM like(tSIPFM);
end-pr;

dcl-pr SIPFM_close extproc(*dclcase);
  SIPFM like(tSIPFM);
end-pr;

