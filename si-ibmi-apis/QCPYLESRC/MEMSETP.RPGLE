**FREE

/if not defined(MEMSETP)
  /define MEMSETP
/else
  /eof
/endif

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tMEMSET_Destination pointer template;
dcl-s tMEMSET_Char int(10) template;
dcl-s tMEMSET_Count uns(10) template;

//==========================================================================================
//             Prototypes
//==========================================================================================

dcl-pr memset pointer extproc(*dclcase);
  Destination like(tMEMSET_Destination) value;
  Char like(tMEMSET_Char) value;
  Count like(tMEMSET_Count) value;
end-pr;
