**FREE

/if not defined(SICJP)
  /define SICJP
/else
  /eof
/endif

/include qcpylesrc/qusrjobip

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cSICJ_CurrentJob const('*');

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSICJ_CodedCharacterSetID int(10) template;
dcl-s tSICJ_Jobname char(10) template;
dcl-s tSICJ_Username char(10) template;
dcl-s tSICJ_Jobnumber char(6) template;
dcl-ds tSICJ_QualifiedJobName qualified template;
   Jobname like(tSICJ_Jobname);
   Username like(tSICJ_Username);
   Jobnumber like(tSICJ_Jobnumber);
end-ds;
dcl-s tSICJ_CCSID like(tSICJ_CodedCharacterSetID) template;

 /if defined(SICJ)
 /eof
 /endif

//==========================================================================================
// Prototypes
//==========================================================================================

 dcl-pr SICJ_setCCSID ind extproc(*dclcase);
   QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
   CCSID like(tSICJ_CCSID) const;
 end-pr;

 dcl-pr SICJ_setCodedCharacterSetID ind extproc(*dclcase);
   QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
   CodedCharacterSetID like(tSICJ_CodedCharacterSetID) value;
 end-pr;
