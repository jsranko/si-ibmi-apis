**FREE

/if not defined(SIISFP)
/define SIISFP
/else
/eof
/endif

/include qsysinc/qrpglesrc,ifs
/include qcpylesrc/sinlp
/include qcpylesrc/siiofp
/include qcpylesrc/siimfp

//==========================================================================================
// Constant
//==========================================================================================

//==========================================================================================
// Templates
//==========================================================================================

 dcl-s tSIISF like(tSIISF_Def) template;
 dcl-s tSIISF_Name varchar(256) template;
 dcl-s tSIISF_FileDescriptor int(10) template;
 dcl-s tSIISF_Bytes int(10) template;
 dcl-s tSIISF_Count int(10) template;
 dcl-s tSIISF_EndLine char(2) template;
 dcl-s tSIISF_Buffer pointer template;
 dcl-s tSIISF_BufferSize int(10) template;
 dcl-s tSIISF_Size int(10) template;

 dcl-ds tSIISF_Def qualified;
   fd like(tSIISF_FileDescriptor);
   Name like(tSIISF_Name);
 end-ds;

/if defined(SIISF)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIISF_new like(tSIISF) extproc(*dclcase);
end-pr;

dcl-pr SIISF_newByFileName like(tSIISF) extproc(*dclcase);
  File like(tSIISF_Name) value;
end-pr;

dcl-pr SIISF_create like(tSIISF) extproc(*dclcase);
  SIISF like(tSIISF) value;
  Codepage like(tSINL);
  ObjectFlag like(tSIIOF);
  ModeFlag like(tSIIMF) options(*omit);
end-pr;

dcl-pr SIISF_createByFileName like(tSIISF) extproc(*dclcase);
  File like(tSIISF_Name) value;
  Codepage like(tSINL);
  ObjectFlag like(tSIIOF);
  ModeFlag like(tSIIMF);
end-pr;

dcl-pr SIISF_close extproc(*dclcase);
  SIISF like(tSIISF);
end-pr;

dcl-pr SIISF_writeText like(tSIISF_Bytes) extproc(*dclcase);
  SIISF like(tSIISF);
  TextToWrite pointer value options(*string);
end-pr;

dcl-pr SIISF_writeLine like(tSIISF_Bytes) extproc(*dclcase);
  SIISF like(tSIISF);
  TextToWrite pointer value options(*string);
  EndLine like(tSIISF_EndLine) value options(*nopass);
end-pr;

dcl-pr SIISF_open extproc(*dclcase);
  SIISF like(tSIISF);
  ObjectFlag like(tSIIOF);
end-pr;

dcl-pr SIISF_openFile like(tSIISF) extproc(*dclcase);
  File like(tSIISF_Name) value;
  ObjectFlag like(tSIIOF);
end-pr;

dcl-pr SIISF_delete extproc(*dclcase);
  SIISF like(tSIISF);
end-pr;

dcl-pr SIISF_getName like(tSIISF_Name) extproc(*dclcase);
  SIISF like(tSIISF);
end-pr;

dcl-pr SIISF_exist ind extproc(*dclcase);
  SIISF like(tSIISF);
end-pr;

dcl-pr SIISF_read like(tSIISF_BufferSize) extproc(*dclcase);
  SIISF like(tSIISF);
  Buffer like(tSIISF_Buffer) const;
  Size like(tSIISF_BufferSize) const;
end-pr;

dcl-pr SIISF_getSize like(tSIISF_Size) extproc(*dclcase);
  SIISF like(tSIISF);
end-pr;

dcl-pr SIISF_isDirectory ind extproc(*dclcase);
  SIISF like(tSIISF);
end-pr;
