**FREE

/if not defined(Riofbkp)
  /define Riofbkp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Templates
//==========================================================================================

dcl-ds tRiofbk_Return likeds(tRECIO_XXIOPFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Riofbk()  Obtain I/O Feedback Information

dcl-pr Riofbk pointer extproc('_Riofbk');
  fp pointer value;
end-pr;
