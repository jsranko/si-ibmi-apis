**FREE

/if not defined(ROPENP)
  /define ROPENP
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Templates
//==========================================================================================

dcl-ds tRopen_Return likeds(tRECIO_RFile) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Ropen()  Open a Record File for I/O Operations
dcl-pr Ropen pointer extproc('_Ropen');
  filename pointer value options(*string);
  mode pointer value options(*string);
end-pr;
