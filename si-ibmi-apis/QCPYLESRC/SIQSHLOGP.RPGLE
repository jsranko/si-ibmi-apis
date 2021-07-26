         /if not defined(SIQSHLOGP)
         /define SIQSHLOGP
         /else
         /eof
         /endif

         /include qcpylesrc/siuuidp
         /include qcpylesrc/siqshp
         /include qcpylesrc/siitrp

        //==========================================================================================
        // Constant
        //==========================================================================================

         dcl-c cSIQSHLOG_LOGTYPE_COMMAND const('COMMAND');
         dcl-c cSIQSHLOG_LOGTYPE_INPUT const('INPUT');
         dcl-c cSIQSHLOG_LOGTYPE_OUTPUT const('OUTPUT');
         dcl-c cSIQSHLOG_LOGTYPE_ERROR const('ERROR');

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIQSHLOG like(tSIQSHLOG_Def) template;
         dcl-s tSIQSHLOG_Id like(tSIUUID_uuid) template;
         dcl-s tSIQSHLOG_Logname varchar(10) template;
         dcl-s tSIQSHLOG_LogId int(10) template;
         dcl-s tSIQSHLOG_LineNbr  int(10) template;
         dcl-s tSIQSHLOG_LineType varchar(10) template;
         dcl-s tSIQSHLOG_LineText varchar(1000) template;
         dcl-s tSIQSHLOG_List like(tSIITR) template;
         dcl-ds tSIQSHLOG_Entry qualified template;
           Id   like(tSIQSHLOG_LogId);
           Type like(tSIQSHLOG_LineType);
           Nbr  like(tSIQSHLOG_LineNbr);
           Text like(tSIQSHLOG_LineText);
         end-ds;

         dcl-ds tSIQSHLOG_Def qualified;
            Id like(tSIQSHLOG_Id);
            LogName like(tSIQSHLOG_Logname);
            LogId like(tSIQSHLOG_LogId);
         end-ds;

         /if defined(SIQSHLOG)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIQSHLOG_create like(tSIQSHLOG) extproc(*dclcase);
           Id like(tSIQSHLOG_Id) options(*nopass) const;
         end-pr;

         dcl-pr SIQSHLOG_delete ind extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
         end-pr;

         dcl-pr SIQSHLOG_write ind extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSHLOG_listLastEntry like(tSIQSHLOG_List) extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
         end-pr;

         dcl-pr SIQSHLOG_listById like(tSIQSHLOG_List) extproc(*dclcase);
           SIQSHLOG like(tSIQSHLOG);
           Id like(tSIQSHLOG_Id);
         end-pr;
