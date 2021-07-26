**FREE

/if not defined(SIUDTFP)
  /define SIUDTFP
/else
  /eof
/endif

//==========================================================================================
//             Constants
//==========================================================================================

dcl-c cSIUDTF_Call_FrstCall const(-2);
dcl-c cSIUDTF_Call_Open const(-1);
dcl-c cSIUDTF_Call_Fetch const(0);
dcl-c cSIUDTF_Call_Close const(1);
dcl-c cSIUDTF_Call_LastCall const(2);

dcl-c cSIUDTF_State_OK const('00000');
dcl-c cSIUDTF_State_EOT const('02000' );
dcl-c cSIUDTF_State_ERR const('US001' );

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tSIUDTF_SQLState char(5) template;
dcl-s tSIUDTF_FunctionName char(517) template;
dcl-s tSIUDTF_SpecificName char(128) template;
dcl-s tSIUDTF_MessageText varchar(70) template;
dcl-s tSIUDTF_CallType int(10) template;
dcl-s tSIPFMLR_Indicator int(5) template;
