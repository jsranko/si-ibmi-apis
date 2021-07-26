        //******************************************************************************************
        //
        //
        // Programname    : SIQSHLOG
        // Programautor   : Sranko Informatik
        // Created on     : 06.03.2019
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

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIQSHLOG
         /include qcpylesrc/siqshlogp

         /include qcpylesrc/sisqlp
         /include qsysinc/qrpglesrc,ifs
         /include qcpylesrc/strtokp

         exec sql set option commit = *none;

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIQSHLOG_create export;
         dcl-pi SIQSHLOG_create like(tSIQSHLOG) extproc(*dclcase);
           Id like(tSIQSHLOG_Id) options(*nopass) const;
         end-pi;
         dcl-s SIUUID like(tSIUUID);
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) inz;

         if %parms >= %parmnum(Id);
           dsSIQSHLOG.Id = Id;
         else;
           SIUUID = SIUUID_new();
           dsSIQSHLOG.Id = SIUUID_get(SIUUID);
         endif;

         dsSIQSHLOG.LogName = createLog();

         return dsSIQSHLOG;
         end-proc;
        //------------------------------------------------------------------------------------------

         dcl-proc SIQSHLOG_delete export;
         dcl-pi SIQSHLOG_delete ind extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
         end-pi;
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) based(pSIQSHLOG);

         pSIQSHLOG = %addr(SIQSHLOG);

         exec sql drop table session.siqshlog;

         if SISQL_isError(sqlca);
           dsply ('SESSION.siqshlog könnte nicht gelöscht werden.');
         endif;


         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc createLog;
         dcl-pi createLog like(tSIQSHLOG_Logname);
         end-pi;

         exec sql declare global temporary table session.siqshlog (
           Id varchar(36) not null,
           LogId integer not null,
           LogLineType varchar(10),
           LogLineNbr integer,
           LogLineText varchar(1000)
         ) not logged;

         if SISQL_isError(sqlca);

         endif;

         return 'SIQSHLOG';
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc writeCommand;
         dcl-pi writeCommand ind;
           SIQSHLOG like(tSIQSHLOG);
           SIQSH like(tSIQSH);
         end-pi;
         dcl-s LogType like(tSIQSHLOG_LineType);
         dcl-s LogId like(tSIQSHLOG_LogId);
         dcl-s Cmd like(tSIQSH_Command);
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) based(pSIQSHLOG);

         pSIQSHLOG = %addr(SIQSHLOG);

         Cmd = SIQSH_getCommand(SIQSH);
         LogType = cSIQSHLOG_LOGTYPE_COMMAND;

         exec sql select LogId
                    into :LogId
                    from final table(
                         insert into session.siqshlog (id,
                                               logid,
                                               loglinetype,
                                               loglinenbr,
                                               loglinetext)
                              values (:dsSIQSHLOG.Id,
                                      (select ifnull(max(logid), 0) + 1
                                        from session.siqshlog
                                       where id = :dsSIQSHLOG.Id),
                                      :LogType,
                                      1,
                                      :Cmd)
                                    ) as a;
         if SISQL_isError(sqlca);
           return *off;
         endif;

         dsSIQSHLOG.LogId = LogId;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIQSHLOG_write export;
         dcl-pi SIQSHLOG_write ind extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
           SIQSH like(tSIQSH);
         end-pi;
         dcl-s Cmd like(tSIQSH_Command);
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) based(pSIQSHLOG);

         pSIQSHLOG = %addr(SIQSHLOG);

         if not writeCommand(SIQSHLOG:SIQSH);
           return *off;
         endif;

         if not writeResponse(SIQSHLOG:SIQSH);
           return *off;
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc writeResponse;
         dcl-pi writeResponse ind;
           SIQSHLOG like(tSIQSHLOG);
           SIQSH like(tSIQSH);
         end-pi;
         dcl-s Cmd like(tSIQSH_Command);
         dcl-s StdOutput like(tSIQSH_StdOutput);
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) based(pSIQSHLOG);

         pSIQSHLOG = %addr(SIQSHLOG);

         StdOutput = SIQSH_getStdIn(SIQSH);
         writeLines(SIQSHLOG:StdOutput:cSIQSHLOG_LOGTYPE_INPUT);

         StdOutput = SIQSH_getStdOut(SIQSH);
         writeLines(SIQSHLOG:StdOutput:cSIQSHLOG_LOGTYPE_OUTPUT);

         StdOutput = SIQSH_getStdErr(SIQSH);
         writeLines(SIQSHLOG:StdOutput:cSIQSHLOG_LOGTYPE_ERROR);

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc writeLines;
         dcl-pi writeLines ind;
           SIQSHLOG like(tSIQSHLOG);
           StdOutput like(tSIQSH_StdOutput);
           LineType like(tSIQSHLOG_LineType) value;
         end-pi;
         dcl-s token pointer;
         dcl-s LineText like(tSIQSHLOG_LineText);
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) based(pSIQSHLOG);

         pSIQSHLOG = %addr(SIQSHLOG);

         if StdOutput = *blanks;
           return *on;
         endif;

         token = strtok(StdOutput:STREAM_LINE_FEED);
         if token = *null;
           return *off;
         endif;

         dow not %shtdn(); // endlose Schleife
           LineText = %str(token);
           exec sql insert into session.siqshlog (id,
                                                 logid,
                                                 loglinetype,
                                                 loglinenbr,
                                                 loglinetext)
                         values (:dsSIQSHLOG.Id,
                                 :dsSIQSHLOG.LogId,
                                 :LineType,
                                 (select ifnull(max(loglinenbr), 0) + 1
                                    from session.siqshlog
                                   where id = :dsSIQSHLOG.Id
                                     and logid = :dsSIQSHLOG.LogId),
                                 :LineText)
           ;

           if SISQL_isError(sqlca);
           endif;

           token = strtok(*null: STREAM_LINE_FEED);
           if token = *null;
             leave;
           endif;
         enddo;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIQSHLOG_listLastEntry export;
         dcl-pi SIQSHLOG_listLastEntry like(tSIQSHLOG_List) extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
         end-pi;
         dcl-ds Entry likeds(tSIQSHLOG_Entry);
         dcl-s output like(tSIQSHLOG_List);
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) based(pSIQSHLOG);

         pSIQSHLOG = %addr(SIQSHLOG);

         exec sql declare csrSIQSHLOG cursor for
                          select LogLineType,
                                 loglinetext
                            from session.siqshlog
                           where id = :dsSIQSHLOG.Id
                             and logid = :dsSIQSHLOG.LogId
         ;

         exec sql open csrSIQSHLOG;

         if SISQL_isError(sqlca);
           return *null;
         endif;

         dow not %shtdn();
           exec sql fetch csrSIQSHLOG into :Entry.Type, :Entry.Text;
           if SISQL_isError(sqlca)
           or SISQL_noData(sqlca);
             leave;
           endif;

           SIITR_addEntry(output:%addr(Entry):%size(Entry));
         enddo;

         exec sql close csrSIQSHLOG;
         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIQSHLOG_listById export;
         dcl-pi SIQSHLOG_listById like(tSIQSHLOG_List) extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
           Id like(tSIQSHLOG_Id);
         end-pi;
         dcl-ds Entry likeds(tSIQSHLOG_Entry);
         dcl-s output like(tSIQSHLOG_List);
         dcl-ds dsSIQSHLOG likeds(tSIQSHLOG_Def) based(pSIQSHLOG);

         pSIQSHLOG = %addr(SIQSHLOG);

         exec sql declare csrSIQSHLOGLBI cursor for
                          select LogId,
                                 LogLineType,
                                 LogLineNbr,
                                 LogLineText
                            from session.siqshlog
                           where id = :Id
         ;

         exec sql open csrSIQSHLOGLBI;

         if SISQL_isError(sqlca);
           return *null;
         endif;

         dow not %shtdn();
           exec sql fetch csrSIQSHLOGLBI into :Entry;
           if SISQL_isError(sqlca)
           or SISQL_noData(sqlca);
             leave;
           endif;

           SIITR_addEntry(output:%addr(Entry):%size(Entry));
         enddo;

         exec sql close csrSIQSHLOGLBI;
         return output;
         end-proc;

