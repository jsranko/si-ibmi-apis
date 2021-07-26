**FREE

/if not defined(Rupfbp)
  /define Rupfbp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Templates
//==========================================================================================

dcl-ds tRupfb_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rupfb()  Provide Information on Last I/O Operation

dcl-pr Rupfb pointer extproc('_Rupfb');
  fp pointer value;
end-pr;
