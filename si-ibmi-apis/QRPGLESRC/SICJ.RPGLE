**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SICJ
        // Programautor   : Sranko Informatik
        // Created on     : 20.01.2020
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

         /define SICJ
         /include qcpylesrc/sicjp
         /include qcpylesrc/qwtchgjbp
         /include qcpylesrc/memcpyp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc changeData0100;
         dcl-pi changeData0100 ind;
           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
           VariableLengthRecord likeds(tQWTCHGJB_VariableLengthRecord1);
         end-pi;
         dcl-ds ErrorCode likeds(tQUSEC);

         ChangeJob(%trim(QualifiedJobName)
                  :*blanks
                  :cQWTCHGJB_Format_JOBC0100
                  :VariableLengthRecord
                  :ErrorCode);
         if ErrorCode.ExceptionId <> *blanks;
           return *off;
         endif;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICJ_setCCSID export;
         dcl-pi SICJ_setCCSID ind extproc(*dclcase);
           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
           CCSID like(tSICJ_CCSID) const;
         end-pi;

         return SICJ_setCodedCharacterSetID(QualifiedJobName:CCSID);

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SICJ_setCodedCharacterSetID export;
         dcl-pi SICJ_setCodedCharacterSetID ind extproc(*dclcase);
           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
           CodedCharacterSetID like(tSICJ_CodedCharacterSetID) value;
         end-pi;
         dcl-ds VariableLengthRecord likeds(tQWTCHGJB_VariableLengthRecord1) inz;

         VariableLengthRecord.NumberOfVariableLengthRecords = 1;
         VariableLengthRecord.Key = cQWTCHGJB_Key_CodedCharacterSetID;
         VariableLengthRecord.LengthOfAttributeInformation = %size(VariableLengthRecord) -
                              %size(VariableLengthRecord.NumberOfVariableLengthRecords);
         VariableLengthRecord.TypeOfData = cQWTCHGJB_TypeOfData_Binary;
         VariableLengthRecord.LengthOfData = %size(CodedCharacterSetID);
         memcpy(%addr(VariableLengthRecord.Data):%addr(CodedCharacterSetID):%size(CodedCharacterSetID));
         return changeData0100(QualifiedJobName:VariableLengthRecord);

         end-proc;


