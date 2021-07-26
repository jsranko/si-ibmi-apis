**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SIUIC
        // Programautor   : Sranko Informatik
        // Created on     : 09.08.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain;

        //==========================================================================================
        // Constants
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

         dcl-ds pgmDS psds likeds(tPSDS);

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIUI
         /include qcpylesrc/siuip

         /include qcpylesrc/psdsp
         /include qcpylesrc/memcpyp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIUI_new export;
         dcl-pi SIUI_new like(tSIUI) extproc(*dclcase);
           Userprofile like(tSIUI_Userprofile) const options(*nopass);
         end-pi;
         dcl-ds dsSIUI likeds(tSIUI_Def) inz;

         if %parms >= %parmnum(Userprofile);
           dsSIUI.Userprofile = Userprofile;
         else;
           dsSIUI.Userprofile = pgmDS.UserName;
         endif;

         getData(dsSIUI:'USRI0100');
         getData(dsSIUI:'USRI0200');
         getData(dsSIUI:'USRI0300');

         return dsSIUI;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIUI_getUserProfileName export;
         dcl-pi SIUI_getUserProfileName like(tSIUI_UserProfileName) extproc(*dclcase);
           SIUI like(tSIUI);
         end-pi;
         dcl-ds dsSIUI likeds(tSIUI_Def) based(pDSSIUI);

         pDSSIUI = %addr(SIUI);

         if not isSet(dsSIUI);
           return '';
         endif;

         return dsSIUI.USRI0300.UserProfileName;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIUI_getHomeDirectory export;
         dcl-pi SIUI_getHomeDirectory like(tSIUI_HomeDirectory) extproc(*dclcase);
           SIUI like(tSIUI);
         end-pi;
         dcl-ds dsSIUI likeds(tSIUI_Def) based(pDSSIUI);
         dcl-s HomeDirectoryUtf16 ucs2(cSIUI_HomeDirectoryLength) ;
         dcl-s HomeDirectory like(tSIUI_HomeDirectory);
         dcl-ds HomeDirStr likeds(tQSYRUSRI_HomeDirectory) based(pHomeDirStr);

         pDSSIUI = %addr(SIUI);

         if not isSet(dsSIUI);
           return '';
         endif;

         pHomeDirStr = %addr(dsSIUI.USRI0300) + dsSIUI.USRI0300.OffsetToHomeDirectory;
         MemCpy(%addr(HomeDirectoryUtf16)
               :%addr(HomeDirStr.HomeDirectoryNameValue)
               :HomeDirStr.NumberOfBytesInTheHomeDirectoryName);
         HomeDirectory = HomeDirectoryUtf16;

         return %trim(HomeDirectory);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getData;
         dcl-pi getData ind;
           dsSIUI likeds(tSIUI_Def);
           FormantName like(tQSYRUSRI_FormatName) const;
         end-pi;
         dcl-s ReceiverVariable like(tQSYRUSRI_ReceiverVariable);
         dcl-ds USRI0100 likeds(tQSYRUSRI_USRI0100) based(pUSRI0100);
         dcl-ds ErrorCode likeds(tQUSEC);

         RetrieveUserInformation(ReceiverVariable
                                :%size(ReceiverVariable)
                                :FormantName
                                :dsSIUI.Userprofile
                                :ErrorCode
                                );
         if ErrorCode.ExceptionId <> *blanks;
           //SIXCP_throwWithMessage('Retrieve Object Error. See previous messages');
           return *off;
         endif;

         pUSRI0100 = %addr(ReceiverVariable);
         select;
         when FormantName = 'USRI0100';
           MemCpy(%addr(dsSIUI.USRI0100)
                 :%addr(ReceiverVariable)
                 :USRI0100.BytesReturned);
           //dsSIUI.USRI0100 = ReceiverVariable;
         when FormantName = 'USRI0200';
           MemCpy(%addr(dsSIUI.USRI0200)
                 :%addr(ReceiverVariable)
                 :USRI0100.BytesReturned);
           //dsSIUI.USRI0200 = ReceiverVariable;
         when FormantName = 'USRI0300';
           MemCpy(%addr(dsSIUI.USRI0300)
                 :%addr(ReceiverVariable)
                 :USRI0100.BytesReturned);
           //dsSIUI.USRI0300 = ReceiverVariable;
         endsl;

         return *on;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc isSet;
         dcl-pi isSet ind;
           dsSIUI likeds(tSIUI_Def);
         end-pi;

         if dsSIUI.Userprofile = *blanks;
           return *off;
         endif;

         return *on;

         end-proc;

        //------------------------------------------------------------------------------------------
