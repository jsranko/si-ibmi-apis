**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SIDBGA
        // Programautor   : Sranko Informatik
        // Created on     : 08.02.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain;
         ctl-opt bnddir('$(LIBRARY)/SIIIA');

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIDBGA
         /include qcpylesrc/sidbgap

         /include qcpylesrc/sijlp
         /include qcpylesrc/systemp
         /include qcpylesrc/sixcpp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIDBGA_isUpdProd export;
         dcl-pi SIDBGA_isUpdProd ind extproc(*dclcase);
         end-pi;
         dcl-s AttrVal like(tSIDBGA_AttributeValue);
         dcl-ds ErrorCode likeds(tQUSEC) inz(*likeds);

         QteRetrieveDebugAttribute(cQtedbgs_DebugAttribute_UPDPROD
                                  :AttrVal
                                  :ErrorCode);
         if ErrorCOde.ExceptionId = 'CPF9541'; // not in debug mode
           return *off;
         endif;
         if ErrorCode.ExceptionId <> *blanks;
           return *off;
         endif;

         select;
         when AttrVal = cQtedbgs_AttributeValue_YES;
           return *on;
         when AttrVal = cQtedbgs_AttributeValue_NO;
           return *off;
         other;
           return *off;
         endsl;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDBGA_getDebugJob export;
         dcl-pi SIDBGA_getDebugJob like(tSIDBGA_DebugJob) extproc(*dclcase);
         end-pi;
         dcl-s AttrVal like(tSIDBGA_AttributeValue);
         dcl-ds ErrorCode likeds(tQUSEC) inz(*likeds);

         QteRetrieveDebugAttribute(cQtedbgs_DebugAttribute_DEBUGJOB
                                  :AttrVal
                                  :ErrorCode);
         if ErrorCOde.ExceptionId = 'CPF9541'; // not in debug mode
           return *off;
         endif;
         if ErrorCode.ExceptionId <> *blanks;
           return *off;
         endif;

         return AttrVal;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDBGA_isOpmSrc export;
         dcl-pi SIDBGA_isOpmSrc ind extproc(*dclcase);
         end-pi;
         dcl-s AttrVal like(tSIDBGA_AttributeValue);
         dcl-ds ErrorCode likeds(tQUSEC) inz(*likeds);

         QteRetrieveDebugAttribute(cQtedbgs_DebugAttribute_OPMSRC
                                  :AttrVal
                                  :ErrorCode);
         if ErrorCOde.ExceptionId = 'CPF9541'; // not in debug mode
           return *off;
         endif;
         if ErrorCode.ExceptionId <> *blanks;
           return *off;
         endif;

         select;
         when AttrVal = cQtedbgs_AttributeValue_YES;
           return *on;
         when AttrVal = cQtedbgs_AttributeValue_NO;
           return *off;
         other;
           return *off;
         endsl;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDBGA_isInDebugMode export;
         dcl-pi SIDBGA_isInDebugMode ind extproc(*dclcase);
         end-pi;
         dcl-s AttrVal like(tSIDBGA_AttributeValue);
         dcl-ds ErrorCode likeds(tQUSEC) inz(*likeds);

         AttrVal = SIDBGA_getDebugJob();
         select;
         when AttrVal = cQtedbgs_AttributeValue_LOCAL
           or AttrVal = cQtedbgs_AttributeValue_REMOTE;
           return *on;
         other;
           return *off;
         endsl;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDBGA_startDebugMode export;
         dcl-pi SIDBGA_startDebugMode extproc(*dclcase);
           UpdProdData ind const options(*nopass:*omit);
           OpmSrc ind const options(*nopass);
         end-pi;
         dcl-s RetVal like(tSystem_Return);
         dcl-s Command varchar(100) inz('STRDBG');

         // test if UpdProdData was passed
         if %parms() >= %parmnum(UpdProdData);
           // Parameter UpdProdData was passed
           if %addr(UpdProdData) <> *null;
             // Parameter UpdProdData was not omitted
             if UpdProdData;
               Command += ' UPDPROD(*YES)';
             else;
               Command += ' UPDPROD(*NO)';
             endif;
           endif;
         endif;

         // test if OpmSrc was passed
         if %parms() >= %parmnum(OpmSrc);
           // Parameter OpmSrc was passed
           if OpmSrc;
             Command += ' OPMSRC(*YES)';
           else;
             Command += ' OPMSRC(*NO)';
           endif;
         endif;

         RetVal = system(Command);
         if RetVal = cSystem_Return_Null_Pointer_Passed
         or RetVal = cSystem_Return_Fails;
           SIXCP_throwWithMessage('Start Debug Mode fails.');
         endif;

         if RetVal = cSystem_Return_Succesful;
           return;
         endif;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDBGA_endDebugMode export;
         dcl-pi SIDBGA_endDebugMode extproc(*dclcase);
         end-pi;
         dcl-s RetVal like(tSystem_Return);
         dcl-s Command varchar(1024);

         RetVal = system('ENDDBG');
         if RetVal = cSystem_Return_Null_Pointer_Passed
         or RetVal = cSystem_Return_Fails;
           SIXCP_throwWithMessage('End Debug Mode fails.');
         endif;

         if RetVal = cSystem_Return_Succesful;
           return;
         endif;

         end-proc;

