**FREE

/if not defined(Rreadnp)
  /define Rreadnp
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

dcl-s tRreadn_Size int(10) template;
dcl-s tRreadn_Opts int(10) template;
dcl-ds tRreadn_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadn()  Read the Next Record

dcl-pr Rreadn pointer extproc('_Rreadn');
  fp pointer value;
  buf pointer value;
  size like(tRreadn_Size) value;
  opts like(tRreadn_Opts) value;
end-pr;
