**FREE
/if defined(SIEPCSQ01P)
/eof
/endif

/define SIEPCSQ01P

// -----------------------------------------------------------------------------
dcl-s tSIEPCSQ01_RetrieveCommandExitInformation char(32767) template;
// -----------------------------------------------------------------------------
dcl-pr SIEPCSQ01 extpgm('SIEPCSQ01');
  RetrieveCommandExitInformation like(tSIEPCSQ01_RetrieveCommandExitInformation);
end-pr;
