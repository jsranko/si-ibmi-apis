**FREE

/if not defined(SICRTMSGFP)
  /define SICRTMSGFP
/else
  /eof
/endif

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSICRTMSGF_Streamfile  char(256) template;

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SICRTMSGF extpgm('SICRTMSGF');
  Streamfile like(tSICRTMSGF_Streamfile) const;
end-pr;
