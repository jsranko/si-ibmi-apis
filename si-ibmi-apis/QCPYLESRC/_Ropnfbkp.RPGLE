**FREE

/if not defined(Ropnfbkp)
  /define Ropnfbkp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Templates
//==========================================================================================

dcl-ds tRopnfbk_Return likeds(tRECIO_XXOPFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Ropnfbk()  Obtain Open Feedback Information

dcl-pr Ropnfbk pointer extproc('_Ropnfbk');
  fp pointer value;
end-pr;
