**FREE

/if not defined(SIMFP)
  /define SIMFP
/else
  /eof
/endif

/include qcpylesrc/siitrp

// -----------------------------------------------------------------------------
dcl-s tSIMF like(tSIMF_Def) template;
dcl-s tSIMF_List like(tSIITR) template;
dcl-s tSIMF_File char(10) template;
dcl-s tSIMF_Library char(10) template;
dcl-s tSIMF_Streamfile char(512) template;
dcl-s tSIMF_Text char(50) template;
dcl-s tSIMF_SizeInitialStorageSize int(10) template;
dcl-s tSIMF_SizeIncrementStorageSize int(10) template;
dcl-s tSIMF_SizeMaximumIncrements char(6) template;
dcl-s tSIMF_Aut char(10) template;
dcl-s tSIMF_Ccsid char(11) template;
dcl-s tSIMF_Msgid char(7) template;
dcl-s tSIMF_Msg char(132) template;
dcl-s tSIMF_SecLvl char(3000) template;
dcl-s tSIMF_Sev int(10) template;
dcl-s tSIMF_FmtDataType char(8) template;
dcl-s tSIMF_FmtLength int(10) template;
dcl-s tSIMF_FmtDecimalPositions int(10) template;
dcl-s tSIMF_Type char(6) template;
dcl-s tSIMF_LenLength char(6) template;
dcl-s tSIMF_LenDecimalPositions int(10) template;
dcl-s tSIMF_Values char(660) template;
dcl-s tSIMF_SpcvalOriginalFromValue char(660) template;
dcl-s tSIMF_SpcvalReplacementToValue char(660) template;
dcl-s tSIMF_RangeLowerValue char(33) template;
dcl-s tSIMF_RangeUpperValue char(33) template;
dcl-s tSIMF_RelRelationOperator char(5) template;
dcl-s tSIMF_RelValue char(33) template;
dcl-s tSIMF_Dft char(132) template;
dcl-s tSIMF_DftpgmObject char(10) template;
dcl-s tSIMF_DftpgmLibrary char(10) template;
dcl-s tSIMF_Dmplst char(7) template;
dcl-s tSIMF_AlroptAlertArt char(9) template;
dcl-s tSIMF_AlroptressourceNameVariable char(6) template;
dcl-s tSIMF_Logprb char(4) template;
dcl-ds tSIMF_Description qualified template;
  text like(tSIMF_Text);
  sizeInitialStorageSize like(tSIMF_SizeInitialStorageSize);
  sizeIncrementStorageSize like(tSIMF_SizeIncrementStorageSize);
  sizeMaximumIncrements like(tSIMF_SizeMaximumIncrements);
  aut like(tSIMF_Aut);
  ccsid like(tSIMF_Ccsid);
end-ds;
dcl-ds tSIMF_Message qualified template;
  msgid like(tSIMF_Msgid);
  msg like(tSIMF_Msg);
  seclvl like(tSIMF_SecLvl);
  sev like(tSIMF_Sev);
  fmtDataType like(tSIMF_FmtDataType);
  fmtLength like(tSIMF_FmtLength);
  fmtDecimalPositions like(tSIMF_FmtDecimalPositions);
  type like(tSIMF_Type);
  lenLength like(tSIMF_LenLength);
  lenDecimalPositions like(tSIMF_LenDecimalPositions);
  values like(tSIMF_Values);// dim(20);
  spcvalOriginalFromValue like(tSIMF_SpcvalOriginalFromValue);// dim(20);
  spcvalReplacementToValue like(tSIMF_SpcvalReplacementToValue);// dim(20);
  rangeLowerValue like(tSIMF_RangeLowerValue);
  rangeUpperValue like(tSIMF_RangeUpperValue);
  relRelationOperator like(tSIMF_RelRelationOperator);
  relValue like(tSIMF_RelValue);
  dft like(tSIMF_Dft);
  dftpgmObject like(tSIMF_DftpgmObject);
  dftpgmLibrary like(tSIMF_DftpgmLibrary);
  dmplst like(tSIMF_Dmplst);// dim(20);
  alroptAlertArt like(tSIMF_AlroptAlertArt);
  alroptressourceNameVariable like(tSIMF_AlroptressourceNameVariable);
  logprb like(tSIMF_Logprb);
  ccsid like(tSIMF_Ccsid);
end-ds;

dcl-ds tSIMF_Def qualified;
  File like(tSIMF_File);
  Library like(tSIMF_Library);
  Streamfile like(tSIMF_Streamfile);
  Description likeds(tSIMF_Description);
  Messages likeds(tSIMF_Description);
end-ds;

/if defined(SIMF)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

 dcl-pr SIMF_new like(tSIMF) extproc(*dclcase);
   File like(tSIMF_File) const;
   Library like(tSIMF_Library) const;
   Description likeds(tSIMF_Description) options(*nopass);
 end-pr;

 dcl-pr SIMF_createFromFile like(tSIMF) extproc(*dclcase);
   SIMF like(tSIMF);
   Streamfile like(tSIMF_Streamfile) const;
 end-pr;

