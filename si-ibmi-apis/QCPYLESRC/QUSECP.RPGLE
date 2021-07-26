**FREE

/if not defined(QUSECP)
  /define QUSECP
/else
  /eof
/endif

//==========================================================================================
// Tempaltes
//==========================================================================================

dcl-ds tQUSEC qualified template;
  BytesProvided int(10) inz(%size(tQUSEC));
  BytesAvailable int(10);
  ExceptionId char(7);
  Reserved char(1);
  Data char(32767);
end-ds;
