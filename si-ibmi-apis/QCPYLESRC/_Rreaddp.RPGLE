**FREE

/if not defined(Rreaddp)
  /define Rreaddp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRreadd_Size int(10) template;
dcl-s tRreadd_Rrn int(20) template;
dcl-s tRreadd_Opts int(10) template;
dcl-ds tRreadd_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadd()  Read a Record by Relative Record Number

dcl-pr Rreadd pointer extproc('_Rreadd');
  fp pointer value;
  buf pointer value;
  size like(tRreadd_Size) value;
  opts like(tRreadd_Opts) value;
  rrn like(tRreadd_Rrn) value;
end-pr;
