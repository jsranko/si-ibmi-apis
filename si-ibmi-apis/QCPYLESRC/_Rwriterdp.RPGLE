**FREE

/if not defined(Rwriterdp)
  /define Rwriterdp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Constants
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRwriterd_Size int(10) template;
dcl-ds tRwriterd_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rwriterd()  Write and Read a Record

dcl-pr Rwriterd pointer extproc('_Rwriterd');
  fp pointer value;
  buf pointer value;
  size like(tRwriterd_Size) value;
end-pr;
