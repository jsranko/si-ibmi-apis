**FREE

/if not defined(Rwrreadp)
  /define Rwrreadp
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

dcl-s tRwrread_Size int(10) template;
dcl-ds tRwrread_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rwrread()  Write and Read a Record (separate buffers)

dcl-pr Rwrread pointer extproc('_Rwrread');
  fp pointer value;
  inBuf pointer value;
  inBufSize like(tRwrread_Size) value;
  outBuf pointer value;
  outBufSize like(tRwrread_Size) value;
end-pr;
