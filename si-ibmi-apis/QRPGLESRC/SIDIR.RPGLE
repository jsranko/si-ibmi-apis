**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SIDIR
        // Programautor   : Sranko Informatik
        // Created on     : 20.03.2019
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
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIDIR
         /include qcpylesrc/sidirp

         /include qcpylesrc/errnop
         /include qcpylesrc/strerrorp
         /include qcpylesrc/sidbgap
         /include qcpylesrc/sijlp
         /include qcpylesrc/mkdirp
         /include qcpylesrc/accessp
         /include qcpylesrc/chdirp
         /include qcpylesrc/sixcpp
         /include qcpylesrc/getcwdp

        //==========================================================================================
        // Procedures
        //==========================================================================================

         dcl-proc SIDIR_ export;
         dcl-pi SIDIR_ like(tSIDIR) extproc(*dclcase);
           Directory like(tSIDIR_Name) value;
         end-pi;
         dcl-ds dsSIDIR likeds(tSIDIR_Def) inz;

         dsSIDIR.Name = Directory;

         if SIDBGA_isInDebugMode();
           SIJL_write('SIDIR Directory set to %s'
                      :Directory
                      );
         endif;

         return dsSIDIR;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDIR_create export;
         dcl-pi SIDIR_create ind extproc(*dclcase);
           SIDIR like(tSIDIR) value;
           ModeFlag like(tSIIMF);
         end-pi;
         dcl-ds dsSIDIR likeds(tSIDIR_Def) based(pSIDIR);
         dcl-s mode like(tSIIMF_Mode_Flag);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);

         pSIDIR = %addr(SIDIR);

         if SIDBGA_isInDebugMode();
           SIJL_write('SIDIR Creating directory %s '
                      :dsSIDIR.Name
                      );
         endif;

         mode = SIIMF_getFlags(ModeFlag);
         if mkdir(dsSIDIR.Name:mode) = cMKDIR_NOT_SUCCESSFUL;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
           SIJL_write('SIDIR %s'
                      :errStr
                      );
           return *off;
         else;
           return *on;
         endif;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDIR_exist export;
         dcl-pi SIDIR_exist ind extproc(*dclcase);
           SIDIR like(tSIDIR) value;
         end-pi;
         dcl-ds dsSIDIR likeds(tSIDIR_Def) based(pSIDIR);
         dcl-s errNbr like(tERRNO_errno) based(pErrNbr);
         dcl-s errStr varchar(256);

         pSIDIR = %addr(SIDIR);

         if SIDBGA_isInDebugMode();
           SIJL_write('SIDIR Check if directory %s exist'
                      :dsSIDIR.Name
                      );
         endif;

         if access(dsSIDIR.Name:cACCESS_F_OK) = cACCESS_NOT_SUCCESSFUL;
           pErrNbr = errno();
           errStr = %str(strerror(errNbr));
           SIJL_write('SIDIR %s'
                      :errStr
                      );
           return *off;
         else;
           return *on;
         endif;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDIR_getName export;
         dcl-pi SIDIR_getName like(tSIDIR_Name) extproc(*dclcase);
           SIDIR like(tSIDIR) value;
         end-pi;
         dcl-ds dsSIDIR likeds(tSIDIR_Def) based(pSIDIR);

         pSIDIR = %addr(SIDIR);

         if SIDBGA_isInDebugMode();
           SIJL_write('SIDIR Directory name is %s.'
                      :dsSIDIR.Name
                      );
         endif;

         return dsSIDIR.Name;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDIR_setCurrentDirectory export;
         dcl-pi SIDIR_setCurrentDirectory extproc(*dclcase);
           SIDIR like(tSIDIR) value;
         end-pi;
         dcl-s ApiReturn like(tCHDIR_Return);
         dcl-ds dsSIDIR likeds(tSIDIR_Def) based(pSIDIR);

         pSIDIR = %addr(SIDIR);

         if SIDBGA_isInDebugMode();
           SIJL_write('SIDIR Change current dirctory to %s.'
                      :dsSIDIR.Name
                      );
         endif;

         ApiReturn = chdir(dsSIDIR.Name);

         if ApiReturn = cCHDIR_Return_NotSuccessful;
           SIXCP_throwWithMessageId('SIE0001':*omit:cSIIIA_MSGF);
         endif;

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDIR_getCurrentDirectory export;
         dcl-pi SIDIR_getCurrentDirectory like(tSIDIR_Name) extproc(*dclcase);
         end-pi;
         dcl-s cwd char(512);

         if getcwd(%addr(cwd) : %size(cwd)) = cGETCWD_Return_NotSuccessful;
           SIXCP_throwWithMessageId('SIE0002':*omit:cSIIIA_MSGF);
         endif;

         if SIDBGA_isInDebugMode();
           SIJL_write('SIDIR get current dirctory %s.'
                      :cwd
                      );
         endif;

         return %trim(cwd);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDIR_setCurrentDirectoryByPath export;
         dcl-pi SIDIR_setCurrentDirectoryByPath extproc(*dclcase);
           Path like(tSIDIR_Name) value;
         end-pi;
         dcl-s ApiReturn like(tCHDIR_Return);

         if SIDBGA_isInDebugMode();
           SIJL_write('SIDIR Change current dirctory to %s.'
                      :Path
                      );
         endif;

         Path = %trim(Path) + x'00';

         ApiReturn = chdir(%addr(Path:*data));

         if ApiReturn = cCHDIR_Return_NotSuccessful;
           SIXCP_throwWithMessageId('SIE0001':*omit:cSIIIA_MSGF);
         endif;

         return;
         end-proc;

