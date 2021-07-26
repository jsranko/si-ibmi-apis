**FREE

/if not defined(FBP)
  /define FBP
/else
  /eof
/endif

//==========================================================================================
// Tempaltes
//==========================================================================================

dcl-s tFB_Severity uns(5) template;
dcl-s tFB_MsgNr uns(5) template;
dcl-s tFB_Flags char(1) template;
dcl-s tFB_MsgPrefix char(3) template;
dcl-s tFB_Isi uns(10) template;
dcl-s tFB_MsgId char(7) template;

dcl-ds tFB_Information qualified template;
  Severity like(tFB_Severity);
  MsgNr like(tFB_MsgNr);
  Flags like(tFB_Flags);
  MsgPrefix like(tFB_MsgPrefix);
  Isi like(tFB_Isi);
end-ds;
