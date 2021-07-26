**FREE
/if not defined(QLICVTTPP)
  /define QLICVTTPP
/else
  /eof
/endif

/include qcpylesrc/qusecp

//==========================================================================================
//             Constants
//==========================================================================================

dcl-c cQLICVTTP_TO_HEX const('*SYMTOHEX');
dcl-c cQLICVTTP_TO_SYMBOLIC const('*HEXTOSYM');

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tQLICVTTP_Conversion char(10) template;
dcl-s tQLICVTTP_SymbolicObjectType char(10) template;
dcl-s tQLICVTTP_HexadecimalObjectType char(2) template;

//==========================================================================================
//             Prototypes
//==========================================================================================

dcl-pr ConvertType extpgm('QLICVTTP');
  Conversion like(tQLICVTTP_Conversion) const;
  SymbolicObjectType like(tQLICVTTP_SymbolicObjectType);
  HexadecimalObjectType like(tQLICVTTP_HexadecimalObjectType);
  ErrorCode likeds(tQUSEC);
end-pr;
