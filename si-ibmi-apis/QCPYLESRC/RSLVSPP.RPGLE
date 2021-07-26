**FREE
/if not defined(RSLVSPP)
  /define RSLVSPP
/else
  /eof
/endif

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cRSLVSP_AUTH_NONE const(x'0000');
dcl-c cRSLVSP_AUTH_ALL const(x'FF1C');
dcl-c cRSLVSP_AUTH_REF const(x'0004');
dcl-c cRSLVSP_AUTH_ALTER const(x'0008');
dcl-c cRSLVSP_AUTH_EXECUTE const(x'0010');
dcl-c cRSLVSP_AUTH_LST_MGMT const(x'0020');
dcl-c cRSLVSP_AUTH_EXCLUDED const(x'0040');
dcl-c cRSLVSP_AUTH_OWNER const(x'0080');
dcl-c cRSLVSP_AUTH_UPDATE const(x'0100');
dcl-c cRSLVSP_AUTH_DELETE const(x'0200');
dcl-c cRSLVSP_AUTH_INSERT const(x'0400');
dcl-c cRSLVSP_AUTH_RETRIEVE const(x'0800');
dcl-c cRSLVSP_AUTH_SPACE const(x'1000');
dcl-c cRSLVSP_AUTH_POINTER const(x'8000');
dcl-c cRSLVSP_AUTH_OBJ_MGMT const(x'4000');
dcl-c cRSLVSP_AUTH_OBJ_CTRL const(x'8000');

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tRSLVSP_PointerForAddressabilityToObject char(2) template;
dcl-s tRSLVSP_AuthorityToBeSet char(2) template;
dcl-s tRSLVSP_SystemPointer pointer(*proc) template;

//==========================================================================================
//             Prototypes
//==========================================================================================

dcl-pr ResolveSystemPointer like(tRSLVSP_SystemPointer) extproc('rslvsp');
  PointerForAddressabilityToObject like(tRSLVSP_PointerForAddressabilityToObject) value;
  ResolveOptions pointer value options(*string);
  ContextThroughWhichObjectIsToBeLocated pointer value options(*string);
  AuthorityToBeSet like(tRSLVSP_AuthorityToBeSet) value;
end-pr;
