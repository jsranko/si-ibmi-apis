**FREE

/if not defined(Rreadkp)
  /define Rreadkp
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

dcl-s tRreadk_Size int(10) template;
dcl-s tRreadk_Opts int(10) template;
dcl-s tRreadk_KeyLen uns(10) template;
dcl-ds tRreadk_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadk()  Read a Record by Key

dcl-pr Rreadk pointer extproc('_Rreadk');
  fp pointer value;
  buf pointer value;
  size like(tRreadk_Size) value;
  opts like(tRreadk_Opts) value;
  key pointer value;
  keyLen like(tRreadk_KeyLen) value;
end-pr;
