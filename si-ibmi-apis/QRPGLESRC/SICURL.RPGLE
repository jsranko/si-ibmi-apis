        //******************************************************************************************
        //
        //
        // Programname    : SICURL
        // Programautor   : Sranko Informatik
        // Created on     : 01.03.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cCURL_CMD const('curl');
         dcl-c cCURL_CMD_CD const('cd');
         dcl-c cCURL_CMD_RM const('rm');
         dcl-c cCURL_CMD_DIR const('dir');
         dcl-c cCURL_CMD_MKDIR const('mkdir');
         dcl-c cCURL_CMD_LS const('ls');
         dcl-c cCURL_CMD_PWD const('pwd');
         dcl-c cCURL_CMD_QUIT const('quit');
         dcl-c cCURL_CMD_PUT const('put');
         dcl-c cCURL_CMD_GET const('get');
         dcl-c cCURL_CMD_RMDIR const('rmdir');
         dcl-c cCURL_CMD_RENAME const('rename');
         dcl-c cCURL_CMD_CONCAT const('&&');
         dcl-c cCURL_VERBOSE const('--verbose');
         dcl-c cCURL_USER const('--user');
         dcl-c cCURL_OUTPUT const('--output');
         dcl-c cCURL_PUT const('-T');
         dcl-c cCURL_USE_ASCII const('--use-ascii');
         dcl-c cCURL_REQ_MLSD const('--request MLSD');
         dcl-c cCURL_LIST_FILE_ENDE const('::sranko::informatik::ende::');
         dcl-c cCURL_CONN_ACTIVE const('A');
         dcl-c cCURL_CONN_PASSIVE const('P');
         dcl-c cCURL_QUOTE const('-Q');
         dcl-c cCURL_PROTOCOL_DELIMITER const('://');

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tRunID varchar(256) template;

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SICURL
         /include qcpylesrc/sicurlp

         /include qcpylesrc/sipathp
         /include qcpylesrc/siqshlogp
         /include qcpylesrc/sidbgap
         /include qcpylesrc/sijlp
         /include qcpylesrc/sistrp
         /include qcpylesrc/sixcpp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_new export;
         dcl-pi SICURL_new like(tSICURL) extproc(*dclcase);
           QShell like(tSIQSH);
           UserLoginCredentials like(tSIULC);
           Server like(tSICURL_Server) const;
           Port like(tSICURL_Port) options(*nopass) const;
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) inz;

         dsSICURL.UserLoginCredentials = UserLoginCredentials;
         dsSICURL.Server = Server;
         dsSICURL.QShell = QShell;
         dsSICURL.QShellLog = SIQSHLOG_create();
         dsSICURL.Protocol = getProtocol(dsSICURL.Server);

         if %parms >= %parmnum(Port);
           dsSICURL.Port = Port;
         else;
           dsSICURL.Port = *zeros;
         endif;

         if SIDBGA_isInDebugMode();
           SICURL_actDebugMode(dsSICURL:*on);
         endif;

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection with %s:%s'
                      :dsSICURL.Server
                      :%char(dsSICURL.Port)
                      );
         endif;

         return dsSICURL;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_actDebugMode export;
         dcl-pi SICURL_actDebugMode extproc(*dclcase);
           SICURL like(tSICURL);
           Value like(tSICURL_DebugMode) const;
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         dsSICURL.DebugMode = Value;

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection Verbose %s'
                      :dsSICURL.DebugMode
                      );
         endif;

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_isConnectionValid export;
         dcl-pi SICURL_isConnectionValid ind extproc(*dclcase);
           SICURL like(tSICURL);
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);


         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_setCD export;
         dcl-pi SICURL_setCD ind extproc(*dclcase);
           SICURL like(tSICURL);
           Direcotry like(tSICURL_Directory) const;
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         dsSICURL.RemoteDirecotry = Direcotry;

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection current directory %s'
                      :dsSICURL.RemoteDirecotry
                      );
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_setLCD export;
         dcl-pi SICURL_setLCD ind extproc(*dclcase);
           SICURL like(tSICURL);
           Direcotry like(tSICURL_Directory) const;
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         dsSICURL.LocalDirecotry = Direcotry;

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection local directory %s'
                      :dsSICURL.LocalDirecotry
                      );
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_listFiles export;
         dcl-pi SICURL_listFiles like(tSICURL_List) extproc(*dclcase);
           SICURL like(tSICURL);
           Directory like(tSICURL_Directory) options(*nopass) value;
         end-pi;
         dcl-s cmd like(tSICURL_Command);
         dcl-s LogEntrys like(tSIQSHLOG_List);
         dcl-ds LogEntry likeds(tSIQSHLOG_Entry);
         dcl-s File like(tSICURL_File);
         dcl-s output like(tSICURL_List);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         cmd = getCURL(SICURL) +
               getUser(SICURL);

         if %parms >= %parmnum(Directory);
           cmd = cmd + getServer(SICURL:Directory);
         else;
           cmd = cmd + getServer(SICURL);
         endif;
         cmd = cmd + ' ' + cCURL_REQ_MLSD;
         cmd = cmd + ' ' + getWriteOut(cCURL_LIST_FILE_ENDE);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection getting file list');
           SIJL_write('%s':cmd);
         endif;

         if not run(SICURL:cmd);
           SIJL_write('CURL-Connection qshell error');
         endif;

       //  if SIDBGA_isInDebugMode();
       //    SIJL_write('CURL-Connection list entrys:');
       //  endif;
       //
       //  LogEntrys = SIQSHLOG_listLastEntry(dsSICURL.QShellLog);
       //  dow SIITR_ForEach(LogEntrys);
       //    SIITR_setValue(LogEntrys:%addr(LogEntry));
       //
       //
       //    if SIDBGA_isInDebugMode();
       //      SIJL_write('%s: %s'
       //                :LogEntry.Type
       //                :LogEntry.Text
       //                );
       //    endif;
       //
       //    select;
       //    when LogEntry.Type = cSIQSHLOG_LOGTYPE_COMMAND;
       //      iter;
       //    when %scan(cCURL_LIST_FILE_ENDE:LogEntry.Text) > 0;
       //      leave;
       //    when LogEntry.Type = cSIQSHLOG_LOGTYPE_OUTPUT;
       //      File = *blanks;
       //      File = LogEntry.Text;
       //      SIITR_addEntry(output:%addr(File):%size(File));
       //    when LogEntry.Type = cSIQSHLOG_LOGTYPE_ERROR;
       //      return *null;
       //    endsl;
       //
       //  enddo;

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getCURL;
         dcl-pi getCURL like(tSICURL_Command);
           SICURL like(tSICURL);
         end-pi;
         dcl-s output like(tSICURL_Command);
         dcl-s verbose like(tSICURL_Command);
         dcl-s mode like(tSICURL_Command);
         dcl-s lcd like(tSICURL_Command);
         dcl-s insecure like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if dsSICURL.DebugMode;
           verbose = cCURL_VERBOSE;
         endif;

         if dsSICURL.LocalDirecotry <> *blanks;
           lcd = 'cd ' + dsSICURL.LocalDirecotry + cCURL_CMD_CONCAT;
         else;
           lcd = ' ';
         endif;

         select;
         when dsSICURL.ConnectionType = cCURL_CONN_ACTIVE;
           mode = '-P -';
         when dsSICURL.ConnectionType = cCURL_CONN_PASSIVE;
           mode = '--ftp-pasv';
         other;
           mode = ' ';
         endsl;

         if dsSICURL.Protocol = 'ftps';
           insecure = '--insecure';
         endif;

         output = %trim(lcd + ' ' + cCURL_CMD + ' ' +
                                    verbose + ' ' +
                                    insecure + ' ' +
                                    mode + ' ');

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getServer;
         dcl-pi getServer like(tSICURL_Command);
           SICURL like(tSICURL);
           Directory like(tSICURL_Directory) options(*nopass) value;
         end-pi;
         dcl-s pth like(tSICURL_Directory);
         dcl-s output like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if %parms >= %parmnum(Directory);
           if SIPATH_isQualified(Directory);
             pth = Directory;
           else;
             if dsSICURL.RemoteDirecotry = *blanks;
               pth = Directory + cSIPATH_SLASH_URL ;
             else;
               pth = dsSICURL.RemoteDirecotry + cSIPATH_SLASH_URL +
                     Directory + cSIPATH_SLASH_URL ;
             endif;
           endif;
         else;
           pth = dsSICURL.RemoteDirecotry + cSIPATH_SLASH_URL;
         endif;

         output = ' ' + dsSICURL.Server +
                        getPort(SICURL) +
                        cSIPATH_SLASH_URL +
                        pth;

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getUser;
         dcl-pi getUser like(tSICURL_Command);
           SICURL like(tSICURL);
         end-pi;
         dcl-s output like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         select;
         when SIULC_isWithUsernamePassword(dsSICURL.UserLoginCredentials);
           output = ' ' + cCURL_USER + ' ' +
                    SIULC_getUsername(dsSICURL.UserLoginCredentials) + ':' +
                    SIULC_getPassword(dsSICURL.UserLoginCredentials);

         when SIULC_isWithKey(dsSICURL.UserLoginCredentials);
           output = ' ' + cCURL_USER + ' ' +
                    SIULC_getUsername(dsSICURL.UserLoginCredentials);
         other;
           output = '';
         endsl;

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getWriteOut;
         dcl-pi getWriteOut like(tSICURL_Command);
           Text pointer options(*string) value;
         end-pi;

         return '--write-out "' + %str(Text) + '"';
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc run;
         dcl-pi run ind;
           SICURL like(tSICURL);
           Command like(tSICURL_Command) options(*varsize);
         end-pi;
         dcl-s output ind;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         SIQSH_clearStdFiles(dsSICURL.QShell);
         output = SIQSH_runCommand(dsSICURL.QShell:Command);
         SIQSHLOG_write(dsSICURL.QShellLog:dsSICURL.QShell);

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_close export;
         dcl-pi SICURL_close ind extproc(*dclcase);
           SICURL like(tSICURL);
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection with %:%s is closed'
                      :dsSICURL.Server
                      :%char(dsSICURL.Port)
                      );
         endif;

         if SIQSH_close(dsSICURL.QShell)
         and SIQSH_deleteStdFiles(dsSICURL.QShell);
           clear dsSICURL;
           return *on;
         else;
           clear dsSICURL;
           return *off;
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_setActiveConnection export;
         dcl-pi SICURL_setActiveConnection extproc(*dclcase);
           SICURL like(tSICURL);
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         dsSICURL.ConnectionType = cCURL_CONN_ACTIVE;

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection active connection is on');
         endif;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_setPassiveConnection export;
         dcl-pi SICURL_setPassiveConnection extproc(*dclcase);
           SICURL like(tSICURL);
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         dsSICURL.ConnectionType = cCURL_CONN_PASSIVE;

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection passive connection is on');
         endif;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_runCmd export;
         dcl-pi SICURL_runCmd ind extproc(*dclcase);
           SICURL like(tSICURL);
           Command like(tSICURL_Command) value;
         end-pi;
         dcl-c delimiter const(x'01');
         dcl-s cmd like(tSISTR_String);
         dcl-s cmdList like(tSISTR_List);
         dcl-s instruction varchar(6);
         dcl-s instructionParam1 like(tSICURL_Command);
         dcl-s instructionParam2 like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('SFTP-Connection run command %s'
                      :Command
                      );
         endif;

         cmd = %scanrpl(cCURL_CMD_CONCAT:delimiter:Command);
         cmdList = SISTR_tokenize(%char(cmd):delimiter);
         dow SIITR_ForEach(cmdList);
           SIITR_setValue(cmdList:%addr(cmd));

           if SIDBGA_isInDebugMode();
             SIJL_write('Command: %s':cmd);
           endif;

           instruction = SIQSH_getInstruction(cmd);
           select;
           when instruction = cCURL_CMD_CD;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             if not SICURL_setCD(SICURL:instructionParam1);
               SIXCP_throwWithMessage('Current Directory is invalid.');
             endif;
           when instruction = cCURL_CMD_RM;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             SICURL_removeFile(SICURL:instructionParam1);
           when instruction = cCURL_CMD_MKDIR;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             SICURL_createDirectory(SICURL:instructionParam1);
           when instruction = cCURL_CMD_LS
             or instruction = cCURL_CMD_DIR;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             if instructionParam1 = *blanks;
               SICURL_listFiles(SICURL);
             else;
               SICURL_listFiles(SICURL:instructionParam1);
             endif;
           when instruction = cCURL_CMD_PWD;
             SIXCP_throwWithMessageId('SIEAA00':instruction:cSIIIA_MSGF);
           when instruction = cCURL_CMD_QUIT;
             SIXCP_throwWithMessageId('SIEAA00':instruction:cSIIIA_MSGF);
           when instruction = cCURL_CMD_PUT;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             if instructionParam1 = *blanks;
               SIXCP_throwWithMessage('File not defined');
             else;
               SICURL_putFile(SICURL:instructionParam1);
             endif;
           when instruction = cCURL_CMD_GET;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             if instructionParam1 = *blanks;
               SIXCP_throwWithMessage('File not defined');
             else;
               SICURL_getFile(SICURL:instructionParam1);
             endif;
           when instruction = cCURL_CMD_RMDIR;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             SICURL_removeDirectory(SICURL:instructionParam1);
           when instruction = cCURL_CMD_RENAME;
             instructionParam1 = SIQSH_getinstructionParam(cmd:1);
             instructionParam2 = SIQSH_getinstructionParam(cmd:2);
             if instructionParam1 = *blanks
             or instructionParam2 = *blanks;
               SIXCP_throwWithMessage('File not defined');
             else;
               SICURL_renameFile(SICURL:instructionParam1:instructionParam2);
             endif;
           other;
             SIXCP_throwWithMessageId('SIEAA00':instruction:cSIIIA_MSGF);
           endsl;

         enddo;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getPort;
         dcl-pi getPort like(tSICURL_Command);
           SICURL like(tSICURL);
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if dsSICURL.Port <> *zeros;
           return ':' + %char(dsSICURL.Port);
         else;
           return '';
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getProtocol;
         dcl-pi getProtocol like(tSICURL_Protocol);
           Server like(tSICURL_Server);
         end-pi;
         dcl-s pos int(5);
         dcl-s output like(tSICURL_Protocol);

         pos = %scan(cCURL_PROTOCOL_DELIMITER:Server) - 1;
         if pos > *zeros;
           output = %subst(Server:1:pos);
           return SISTR_toLower(output);
         else;
           return '';
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_getFile export;
         dcl-pi SICURL_getFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           File like(tSICURL_File) options(*varsize);
         end-pi;
         dcl-s cmd like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection GET %s':File);
         endif;

         cmd = getCURL(SICURL) +
               getUser(SICURL) +
               getServer(SICURL) +
               File + ' ' +
               cCURL_OUTPUT + ' ' +
               File + ' ' +
               getTransferMode(SICURL) + ' ' +
               getWriteOut(cCURL_LIST_FILE_ENDE);

         if not run(SICURL:cmd);
           SIJL_write('CURL-Connection qshell error');
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_putFile export;
         dcl-pi SICURL_putFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           File like(tSICURL_File) options(*varsize);
         end-pi;
         dcl-s cmd like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection GET %s':File);
         endif;

         cmd = getCURL(SICURL) +
               getUser(SICURL) +
               getServer(SICURL) + ' ' +
               getWriteOut(cCURL_LIST_FILE_ENDE) + ' ' +
               cCURL_PUT + ' ' +
               File;

         if not run(SICURL:cmd);
           SIJL_write('CURL-Connection qshell error');
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_renameFile export;
         dcl-pi SICURL_renameFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           OldFile like(tSICURL_File) options(*varsize);
           NewFile like(tSICURL_File) options(*varsize);
         end-pi;
         dcl-s cmd like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection rename %s to %s':OldFile:NewFile);
         endif;

         cmd = getCURL(SICURL) +
               getUser(SICURL) +
               getServer(SICURL) + ' ' +
               cCURL_QUOTE + '"-RNFR ' +
               OldFile + '" ' +
               cCURL_QUOTE + '"-RNTO ' +
               NewFile + '" ' +
               cCURL_REQ_MLSD + ' ' +
               getWriteOut(cCURL_LIST_FILE_ENDE);

         if not run(SICURL:cmd);
           SIJL_write('CURL-Connection qshell error');
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getTransferMode;
         dcl-pi getTransferMode like(tSICURL_Command);
           SICURL like(tSICURL);
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);


         if dsSICURL.AsciiMode;
           return cCURL_USE_ASCII;
         else;
           return '';
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_setAsciiMode export;
         dcl-pi SICURL_setAsciiMode extproc(*dclcase);
           SICURL like(tSICURL);
         end-pi;
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection ASCII mode activated');
         endif;

         dsSICURL.AsciiMode = *on;

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_createDirectory export;
         dcl-pi SICURL_createDirectory ind extproc(*dclcase);
           SICURL like(tSICURL);
           Directory like(tSICURL_Directory) options(*varsize);
         end-pi;
         dcl-s cmd like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection mkdir %s':Directory);
         endif;

         cmd = getCURL(SICURL) +
               getUser(SICURL) +
               getServer(SICURL) + ' ' +
               cCURL_QUOTE + '"-MKD ' +
               Directory + '" ' +
               cCURL_REQ_MLSD + ' ' +
               getWriteOut(cCURL_LIST_FILE_ENDE);

         if not run(SICURL:cmd);
           SIJL_write('CURL-Connection mkdir error');
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_removeFile export;
         dcl-pi SICURL_removeFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           File like(tSICURL_File) options(*varsize);
         end-pi;
         dcl-s cmd like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection rm %s':File);
         endif;

         cmd = getCURL(SICURL) +
               getUser(SICURL) +
               getServer(SICURL) + ' ' +
               cCURL_QUOTE + '"-DELE ' +
               File + '" ' +
               cCURL_REQ_MLSD + ' ' +
               getWriteOut(cCURL_LIST_FILE_ENDE);

         if not run(SICURL:cmd);
           SIJL_write('CURL-Connection rm error');
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICURL_removeDirectory export;
         dcl-pi SICURL_removeDirectory ind extproc(*dclcase);
           SICURL like(tSICURL);
           Directory like(tSICURL_Directory) options(*varsize);
         end-pi;
         dcl-s cmd like(tSICURL_Command);
         dcl-ds dsSICURL likeds(tSICURL_Def) based(pSICURL);

         pSICURL = %addr(SICURL);

         if SIDBGA_isInDebugMode();
           SIJL_write('CURL-Connection rmdir %s':Directory);
         endif;

         cmd = getCURL(SICURL) +
               getUser(SICURL) +
               getServer(SICURL) + ' ' +
               cCURL_QUOTE + '"-RMD ' +
               Directory + '" ' +
               cCURL_REQ_MLSD + ' ' +
               getWriteOut(cCURL_LIST_FILE_ENDE);

         if not run(SICURL:cmd);
           SIJL_write('CURL-Connection rmdir error');
         endif;

         return *on;
         end-proc;
