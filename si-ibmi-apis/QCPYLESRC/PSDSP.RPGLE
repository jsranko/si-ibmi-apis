         /if not defined(PSDSP)
         /define PSDSP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-ds tPSDS qualified template;
           ProcedureName char(10);
           StatusCode zoned(5:0);
           PreviousStatus zoned(5:0);
           SourceListLineNumber char(8);
           RoutineName char(8);
           NumberPassedParms zoned(3:0);
           ExceptionType char(3);
           ExceptionNumber char(4);
           Reserved char(4);
           WorkAreaForMessages char(30);
           ProgramLibrary char(10);
           ExceptionData char(80);
           ExceptionId char(4);
           LastOperationOnFile char(10);
           Unused char(4);
           DateJobEnteredSystem date;
           Century zoned(2:0);
           LastFileUsed char(8);
           FileErrorInfo char(35);
           JobName char(10);
           UserName char(10);
           JobNumber zoned(6:0);
           JobDate zoned(6:0);
           ProgramRunDate zoned(6:0);
           ProgramRunTime zoned(6:0);
           ProgramCreateDate char(6);
           ProgramCreateTime char(6);
           CompilerLevel char(4);
           SourceFileName char(10);
           SourceFileLibrary char(10);
           SourceFileMember char(10);
           ProgramContainingProcedure char(10);
           ModuleContainingProcedure char(10);
           SourceId21_28 char(2);
           SourceId228_235 char(2);
           CurrentUserProfile char(10);
           ExternalErrorCode int(10:0);
           ElementsSetByInto int(20:0);
           Unused2 char(50);
         end-ds;
