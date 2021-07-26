**FREE

//******************************************************************************************
//
//
// Programname    : SIPFMLR
// Programautor   : Sranko Informatik
// Created on     : 19.05.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
//
//==========================================================================================

ctl-opt main(SIPFMLR) dftactgrp(*no) actgrp(*caller) stgmdl(*teraspace);

/include qcpylesrc/sictlopt

//==========================================================================================
// Templates
//==========================================================================================

/include qcpylesrc/siudtfp
/include qcpylesrc/sipfmp

dcl-s tSIPFMLR_Libraryname varchar(10) template;
dcl-s tSIPFMLR_Filename varchar(10) template;
dcl-s tSIPFMLR_Membername varchar(10) template;
dcl-s tSIPFMLR_MemberData varchar(cSIPFM_Buffer_Size) template;

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/memcpyp

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIPFMLR;
dcl-pi SIPFMLR;
  // Input Parameters
  Inp_Libraryname like(tSIPFMLR_Libraryname);
  Inp_Filename like(tSIPFMLR_Filename);
  Inp_Membername like(tSIPFMLR_Membername);
  // Output Parameters
  Out_MemberData like(tSIPFMLR_MemberData);
  // Null Input Parameters
  Null_Libraryname like(tSIPFMLR_Indicator);
  Null_Filename like(tSIPFMLR_Indicator);
  Null_Membername like(tSIPFMLR_Indicator);
  // Null Output Parameters
  Null_MemberData like(tSIPFMLR_Indicator);
  // SQL Style Parms
  SQLState like(tSIUDTF_SQLState);
  FunctionName like(tSIUDTF_FunctionName);
  SpecificName like(tSIUDTF_SpecificName);
  MessageText like(tSIUDTF_MessageText);
  // UDTF CallType flag PARM  (Open,Fetch,Close)
  CallType like(tSIUDTF_CallType);
end-pi;
dcl-s Member like(tSIPFM) static;
dcl-s MembersData like(tSIPFM_List) static;
dcl-s RecordData char(cSIPFM_Buffer_Size);

  Select;
  When CallType = cSIUDTF_Call_FrstCall ;
    EXSR FirstCall ;

  When CallType = cSIUDTF_Call_Open ;
    EXSR Open ;

  When CallType = cSIUDTF_Call_Fetch ;
    EXSR Fetch ;

  When CallType = cSIUDTF_Call_Close ;
    EXSR Close ;

  When CallType = cSIUDTF_Call_LastCall ;
    EXSR LastCall ;

  Endsl ;

  return;

  // ..........................................................................

  begsr FirstCall;

  endsr;

  // ..........................................................................

  begsr Open;

    Member = SIPFM_new(Inp_Libraryname:Inp_Filename:Inp_Membername);
    MembersData = SIPFM_listRecords(Member);
    
  endsr;

  // ..........................................................................

  begsr Fetch;

   if not SIITR_isEmpty(MembersData);
     if not SIITR_ForEach(MembersData);
       SQLState = cSIUDTF_State_EOT;
       leavesr;
     else;
       SQLState = cSIUDTF_State_OK;
     endif;
     SIITR_setValue(MembersData:%addr(RecordData));

     %len(Out_MemberData) = SIPFM_getRecordLength(Member);
     memcpy(%addr(Out_MemberData:*data):%addr(RecordData):SIPFM_getRecordLength(Member));
   else;
     SQLState = cSIUDTF_State_EOT;
   endif;

  endsr;

  // ..........................................................................

  begsr Close;

    SIITR_close(MembersData);

  endsr;

  // ..........................................................................

  begsr LastCall;

  endsr;

 end-proc;
