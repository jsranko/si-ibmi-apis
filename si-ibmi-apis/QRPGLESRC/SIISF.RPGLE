**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SIISF
        // Programautor   : Sranko Informatik
        // Created on     : 06.02.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,make
        //
        //==========================================================================================

         ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cMODE_MASK_Directory const(x'0001F000');
         dcl-c cMODE_VALUE_Directory const(x'00004000');

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIISF
         /include qcpylesrc/siisfp

         /include qcpylesrc/siiofp
         /include qcpylesrc/siimfp
         /include qcpylesrc/sinlp
         /include qcpylesrc/errnop
         /include qcpylesrc/strerrorp
         /include qcpylesrc/sidbgap
         /include qcpylesrc/sijlp
         ///include qcpylesrc/statp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_new export;
         dcl-pi SIISF_new like(tSIISF) extproc(*dclcase);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) inz;

         clear dsSIISF;

         return dsSIISF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_newByFileName export;
         dcl-pi SIISF_newByFileName like(tSIISF) extproc(*dclcase);
           File like(tSIISF_Name) value;
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) inz;

         dsSIISF.Name = File;

         return dsSIISF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_createByFileName export;
         dcl-pi SIISF_createByFileName like(tSIISF) extproc(*dclcase);
           File like(tSIISF_Name) value;
           Codepage like(tSINL);
           ObjectFlag like(tSIIOF);
           ModeFlag like(tSIIMF);
         end-pi;

         return doCreate(File:Codepage:ObjectFlag:ModeFlag);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_create export;
         dcl-pi SIISF_create like(tSIISF) extproc(*dclcase);
           SIISF like(tSIISF) value;
           Codepage like(tSINL);
           ObjectFlag like(tSIIOF);
           ModeFlag like(tSIIMF) options(*omit);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);

         pSIISF = %addr(SIISF);

         if %addr(ModeFlag) = *null;
           return doCreate(dsSIISF.Name:Codepage:ObjectFlag:*omit);
         else;
           return doCreate(dsSIISF.Name:Codepage:ObjectFlag:ModeFlag);
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc doCreate export;
         dcl-pi doCreate like(tSIISF) extproc(*dclcase);
           File like(tSIISF_Name) value;
           Codepage like(tSINL);
           ObjectFlag like(tSIIOF);
           ModeFlag like(tSIIMF) options(*omit);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) inz;
         dcl-s flags like(tSIIOF_Object_Flag);
         dcl-s mode like(tSIIMF_Mode_Flag);
         dcl-s cp like(tSINL_ASCII);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);

         flags = SIIOF_getFlags(ObjectFlag);
         if %addr(ModeFlag) = *null;
           mode = 0;
         else;
           mode = SIIMF_getFlags(ModeFlag);
         endif;
         cp = SINL_getASCII(Codepage);
         dsSIISF.Name = File;
         dsSIISF.fd = open(File
                          :flags
                          :mode
                          :cp
                          :0
                          );
         if dsSIISF.fd < *zeros;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
         endif;

         return dsSIISF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_close export;
         dcl-pi SIISF_close extproc(*dclcase);
           SIISF like(tSIISF);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);

         pSIISF = %addr(SIISF);
         dsSIISF.fd = close(dsSIISF.fd);

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_writeText export;
         dcl-pi SIISF_writeText like(tSIISF_Bytes) extproc(*dclcase);
           SIISF like(tSIISF);
           TextToWrite pointer value options(*string);
         end-pi;

         return doWrite(SIISF:TextToWrite);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_writeLine export;
         dcl-pi SIISF_writeLine like(tSIISF_Bytes) extproc(*dclcase);
           SIISF like(tSIISF);
           TextToWrite pointer value options(*string);
           EndLine like(tSIISF_EndLine) value options(*nopass);
         end-pi;

         if %parms >= %parmnum(EndLine);
           return doWrite(SIISF:%str(TextToWrite) + %trim(EndLine));
         endif;

         return doWrite(SIISF:%str(TextToWrite) + STREAM_CARRIAGE_RETURN
                                                + STREAM_LINE_FEED);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_open export;
         dcl-pi SIISF_open extproc(*dclcase);
           SIISF like(tSIISF);
           ObjectFlag like(tSIIOF);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);
         dcl-s flags like(tSIIOF_Object_Flag);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);

         pSIISF = %addr(SIISF);

         flags = SIIOF_getFlags(ObjectFlag);
         dsSIISF.fd = open(dsSIISF.Name
                          :flags
                          );
         if dsSIISF.fd < *zeros;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
         endif;

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_openFile export;
         dcl-pi SIISF_openFile like(tSIISF) extproc(*dclcase);
           File like(tSIISF_Name) value;
           ObjectFlag like(tSIIOF);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def);
         dcl-s flags like(tSIIOF_Object_Flag);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);

         flags = SIIOF_getFlags(ObjectFlag);
         dsSIISF.Name = File;
         dsSIISF.fd = open(dsSIISF.Name
                          :flags
                          );
         if dsSIISF.fd < *zeros;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
         endif;

         return dsSIISF;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc doWrite;
         dcl-pi doWrite like(tSIISF_Bytes) extproc(*dclcase);
           SIISF like(tSIISF);
           TextToWrite pointer value options(*string);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);
         dcl-s writedBytes like(tSIISF_Bytes);
         dcl-s toWriteBytes like(tSIISF_Bytes);

         pSIISF = %addr(SIISF);
         toWriteBytes = %len(%str(TextToWrite));
         if toWriteBytes = *zeros
         or toWriteBytes < *zeros;
           return *zeros;
         endif;

         writedBytes = write(dsSIISF.fd
                            :TextToWrite
                            :toWriteBytes
                            );
         if writedBytes <> toWriteBytes;
           // throw()
         endif;

         return writedBytes;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_delete export;
         dcl-pi SIISF_delete extproc(*dclcase);
           SIISF like(tSIISF);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);

         pSIISF = %addr(SIISF);

         select;
         when unlink(dsSIISF.Name) < 0;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
         endsl;

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_getName export;
         dcl-pi SIISF_getName like(tSIISF_Name) extproc(*dclcase);
           SIISF like(tSIISF);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);

         pSIISF = %addr(SIISF);

         if %len(dsSIISF.Name) = 0;
           return '';
         else;
           return dsSIISF.Name;
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_exist export;
         dcl-pi SIISF_exist ind extproc(*dclcase);
           SIISF like(tSIISF);
         end-pi;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);

         pSIISF = %addr(SIISF);

         if access(dsSIISF.Name:F_OK) < 0;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
           return *off;
         else;
           return *on;
         endif;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_read export;
         dcl-pi SIISF_read like(tSIISF_BufferSize) extproc(*dclcase);
           SIISF like(tSIISF);
           Buffer like(tSIISF_Buffer) const;
           Size like(tSIISF_BufferSize) const;
         end-pi;
         dcl-s bytes like(tSIISF_BufferSize);
         dcl-ds dsStat likeds(stat_t) based(pStat);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);

         pSIISF = %addr(SIISF);

         bytes = read(dsSIISF.fd:Buffer:Size);

         if SIDBGA_isInDebugMode();
           SIJL_write('SIISF Readed bytes %s'
                      :%char(bytes)
                      );
         endif;

         select;
         when bytes < 0;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
           SIJL_write('SIISF-Error: %s'
                      :errStr
                      );
         endsl;

         return bytes;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_getSize export;
         dcl-pi SIISF_getSize like(tSIISF_Size) extproc(*dclcase);
           SIISF like(tSIISF);
         end-pi;
         dcl-ds dsStat likeds(stat_t) inz;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);

         pSIISF = %addr(SIISF);

         dsStat = getStat(SIISF);

         if SIDBGA_isInDebugMode();
           SIJL_write('SIISF File size %s'
                      :%char(dsStat.st_size)
                      );
         endif;

         return dsStat.st_size;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIISF_isDirectory export;
         dcl-pi SIISF_isDirectory ind extproc(*dclcase);
           SIISF like(tSIISF);
         end-pi;
         dcl-s output ind inz(*off);
         dcl-ds dsStat likeds(stat_t) inz;
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);

         pSIISF = %addr(SIISF);

         dsStat = getStat(SIISF);

         if %bitand(dsStat.st_mode: cMODE_MASK_Directory) =  cMODE_VALUE_Directory;
           output = *on;
         else;
           output = *off;
         endif;

         if SIDBGA_isInDebugMode();
           SIJL_write('SIISF Object is directory %s'
                      :output
                      );
         endif;

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getStat;
         dcl-pi getStat likeds(stat_t);
           SIISF like(tSIISF);
         end-pi;
         dcl-s statRet int(10);
         dcl-ds dsStat likeds(stat_t) inz;
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);
         dcl-ds dsSIISF likeds(tSIISF_Def) based(pSIISF);

         pSIISF = %addr(SIISF);

         statRet = stat(dsSIISF.Name:dsStat);

         select;
         //when statRet = cSTAT_NOT_SUCCESSFUL;
         when statRet = -1;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
           SIJL_write('SIISF-Error: %s'
                      :errStr
                      );
           return *allx'00';
         endsl;

         return dsStat;
         end-proc;

