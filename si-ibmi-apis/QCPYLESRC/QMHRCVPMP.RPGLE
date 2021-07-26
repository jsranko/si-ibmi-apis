**FREE
         /if not defined(QMHRCVPMP)
         /define QMHRCVPMP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Templates
        //==========================================================================================


        dcl-s tQMHRCVPM_MessageInformation varchar(32756) template;
        dcl-s tQMHRCVPM_LengthOfMessageInformation int(10) template;
        dcl-s tQMHRCVPM_FormatName char(8) template;
        dcl-s tQMHRCVPM_CallStackEntry char(10) template;
        dcl-s tQMHRCVPM_CallStackCounter int(10) template;
        dcl-s tQMHRCVPM_MessageType char(10) template;
        dcl-s tQMHRCVPM_MessageKey char(4) template;
        dcl-s tQMHRCVPM_WaitTime int(10) template;
        dcl-s tQMHRCVPM_MessageAction char(10) template;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

        dcl-pr ReceiveProgramMessage extpgm('QMHRCVPM');
           MessageInformation like(tQMHRCVPM_MessageInformation) options(*varsize);
           LengthOfMessageInformation like(tQMHRCVPM_LengthOfMessageInformation) const;
           FormatName like(tQMHRCVPM_FormatName) const;
           CallStackEntry like(tQMHRCVPM_CallStackEntry) const;
           CallStackCounter like(tQMHRCVPM_CallStackCounter) const;
           MessageType like(tQMHRCVPM_MessageType) const;
           MessageKey like(tQMHRCVPM_MessageKey) const;
           WaitTime like(tQMHRCVPM_WaitTime) const;
           MessageAction like(tQMHRCVPM_MessageAction) const;
           ErrorCode likeds(tQUSEC);
        end-pr;
