**FREE
         /if not defined(QMHSNDPMP)
         /define QMHSNDPMP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        //             Konstanten
        //==========================================================================================

        dcl-c cQMHSNDPM_MessageType_Escape const('*ESCAPE');

        //==========================================================================================
        //             Templates
        //==========================================================================================

        dcl-s tQMHSNDPM_MessageIdentifier char(7) template;
        dcl-s tQMHSNDPM_QualifiedMessageFileName char(20) template;
        dcl-s tQMHSNDPM_MessageData char(6000) template;
        dcl-s tQMHSNDPM_LengthOfMessageData int(10) template;
        dcl-s tQMHSNDPM_MessageType char(10) template;
        dcl-s tQMHSNDPM_MessageQueueName char(20) template;
        dcl-s tQMHSNDPM_NumberOfMessageQueues int(10) template;
        dcl-s tQMHSNDPM_MessageKey char(4) template;

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

        dcl-pr SendNonprogramMessage extpgm('QMHSNDPM');
           MessageIdentifier like(tQMHSNDPM_MessageIdentifier) const;
           QualifiedMessageFileName like(tQMHSNDPM_QualifiedMessageFileName) const;
           MessageData like(tQMHSNDPM_MessageData) const;
           LengthOfMessageData like(tQMHSNDPM_LengthOfMessageData) const;
           MessageType like(tQMHSNDPM_MessageType) const;
           ListOfQualifiedMessageQueueNames like(tQMHSNDPM_MessageQueueName) dim(50) const;
           NumberOfMessageQueues like(tQMHSNDPM_NumberOfMessageQueues) const;
           QualifiedNameOfTheReplyMessageQueue like(tQMHSNDPM_MessageQueueName) const;
           MessageKey like(tQMHSNDPM_MessageKey);
           ErrorCode likeds(tQUSEC);
        end-pr;
