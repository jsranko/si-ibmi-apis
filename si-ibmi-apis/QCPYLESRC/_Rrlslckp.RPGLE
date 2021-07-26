**FREE

/if not defined(Rrlslckp)
  /define Rrlslckp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Constants
//==========================================================================================

dcl-c tRrlslck_Successful const(1);
dcl-c tRrlslck_Unsuccessful const(0);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRrlslck_Return int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rrlslck()  Release a Record Lock

dcl-pr Rrlslck like(tRrlslck_Return) extproc('_Rrlslck');
  fp pointer value;
end-pr;
