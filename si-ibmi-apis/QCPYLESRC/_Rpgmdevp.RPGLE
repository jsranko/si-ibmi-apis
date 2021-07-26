**FREE

/if not defined(Rpgmdevp)
  /define Rpgmdevp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Templates
//==========================================================================================


dcl-s tRpgmdev_Return int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rfeod()  Force the End-of-Data

dcl-pr Rpgmdev like(tRpgmdev_Return) extproc('_Rpgmdev');
  fp pointer value;
  dev pointer value options(*string);
end-pr;
