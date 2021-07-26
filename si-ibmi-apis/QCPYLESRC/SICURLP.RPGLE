         /if not defined(SICURLP)
         /define SICURLP
         /else
         /eof
         /endif

         /include qcpylesrc/siulcp
         /include qcpylesrc/siitrp
         /include qcpylesrc/siqshp
         /include qcpylesrc/siqshlogp

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSICURL like(tSICURL_Def) template;
         dcl-s tSICURL_Server varchar(256) template;
         dcl-s tSICURL_Port int(5) template;
         dcl-s tSICURL_DebugMode ind template;
         dcl-s tSICURL_File varchar(256) template;
         dcl-s tSICURL_Directory varchar(256) template;
         dcl-s tSICURL_List like(tSIITR) template;
         dcl-s tSICURL_ConnectionType char(1) template;
         dcl-s tSICURL_Command varchar(1024) template;
         dcl-s tSICURL_Protocol varchar(7) template;

         dcl-ds tSICURL_Def qualified;
           QShell like(tSIQSH);
           QShellLog like(tSIQSHLOG);
           UserLoginCredentials like(tSIULC);
           Server like(tSICURL_Server);
           Port like(tSICURL_Port);
           DebugMode like(tSICURL_DebugMode);
           RemoteDirecotry like(tSICURL_Directory);
           LocalDirecotry like(tSICURL_Directory);
           ConnectionType like(tSICURL_Directory);
           Protocol like(tSICURL_Protocol);
           AsciiMode ind;
         end-ds;

         /if defined(SICURL)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SICURL_new like(tSICURL) extproc(*dclcase);
           QShell like(tSIQSH);
           UserLoginCredentials like(tSIULC);
           Server like(tSICURL_Server) const;
           Port like(tSICURL_Port) options(*nopass) const;
         end-pr;

         dcl-pr SICURL_actDebugMode extproc(*dclcase);
           SICURL like(tSICURL);
           Value like(tSICURL_DebugMode) const;
         end-pr;

         dcl-pr SICURL_isConnectionValid ind extproc(*dclcase);
           SICURL like(tSICURL);
         end-pr;

         dcl-pr SICURL_setCD ind extproc(*dclcase);
           SICURL like(tSICURL);
           Direcotry like(tSICURL_Directory) const;
         end-pr;

         dcl-pr SICURL_setLCD ind extproc(*dclcase);
           SICURL like(tSICURL);
           Direcotry like(tSICURL_Directory) const;
         end-pr;

         dcl-pr SICURL_listFiles like(tSICURL_List) extproc(*dclcase);
           SICURL like(tSICURL);
           Path like(tSICURL_Directory) options(*nopass) value;
         end-pr;

         dcl-pr SICURL_close ind extproc(*dclcase);
           SICURL like(tSICURL);
         end-pr;

         dcl-pr SICURL_setActiveConnection extproc(*dclcase);
           SICURL like(tSICURL);
         end-pr;

         dcl-pr SICURL_setPassiveConnection extproc(*dclcase);
           SICURL like(tSICURL);
         end-pr;

         dcl-pr SICURL_runCmd ind extproc(*dclcase);
           SICURL like(tSICURL);
           Command like(tSICURL_Command) value;
         end-pr;

         dcl-pr SICURL_getFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           File like(tSICURL_File) options(*varsize);
         end-pr;

         dcl-pr SICURL_putFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           File like(tSICURL_File) options(*varsize);
         end-pr;

         dcl-pr SICURL_renameFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           OldFile like(tSICURL_File) options(*varsize);
           NewFile like(tSICURL_File) options(*varsize);
         end-pr;

         dcl-pr SICURL_setAsciiMode extproc(*dclcase);
           SICURL like(tSICURL);
         end-pr;

         dcl-pr SICURL_createDirectory ind extproc(*dclcase);
           SICURL like(tSICURL);
           Directory like(tSICURL_Directory) options(*varsize);
         end-pr;

         dcl-pr SICURL_removeFile ind extproc(*dclcase);
           SICURL like(tSICURL);
           File like(tSICURL_File) options(*varsize);
         end-pr;

         dcl-pr SICURL_removeDirectory ind extproc(*dclcase);
           SICURL like(tSICURL);
           Directory like(tSICURL_Directory) options(*varsize);
         end-pr;
