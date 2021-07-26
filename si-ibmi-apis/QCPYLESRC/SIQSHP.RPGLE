         /if not defined(SIQSHP)
         /define SIQSHP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-s tSIQSH like(tSIQSH_Def) template;
         dcl-s tSIQSH_Path varchar(512) template;
         dcl-s tSIQSH_Command varchar(1024) template;
         dcl-s tSIQSH_StdOutput char(65534) template;
         dcl-s tSIQSH_ParameterNumber int(5) template;

         dcl-ds tSIQSH_Def qualified template;
           Stdin  like(tSIQSH_Path);
           Stdout like(tSIQSH_Path);
           Stderr like(tSIQSH_Path);
           Command like(tSIQSH_Command);
         end-ds;

         /if defined(SIQSH)
         /eof
         /endif

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr SIQSH_init like(tSIQSH) extproc(*dclcase);
          PathForStdin  like(tSIQSH_Path) const options(*nopass:*omit:*varsize);
          PathForStdout like(tSIQSH_Path) const options(*nopass:*omit:*varsize);
          PathForStderr like(tSIQSH_Path) const options(*nopass:*omit:*varsize);
         end-pr;

         dcl-pr SIQSH_close Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_runCommand Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
           Command like(tSIQSH_Command) const options(*varsize);
         end-pr;

         dcl-pr SIQSH_checkCommand Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
           Command like(tSIQSH_Command) const options(*varsize);
           Path pointer value Options(*String:*nopass);
         end-pr;

         dcl-pr SIQSH_clearStdIn Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_clearStdOut Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_clearStdErr Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_clearStdFiles Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_getStdIn like(tSIQSH_StdOutput) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_getStdOut like(tSIQSH_StdOutput) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_getStdErr like(tSIQSH_StdOutput) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_deleteStdInFile Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_deleteStdOutFile Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_deleteStdErrFile Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_deleteStdFiles Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_getCWD like(tSIQSH_Path) extproc(*dclcase);
         end-pr;

         dcl-pr SIQSH_getCommand like(tSIQSH_Command) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pr;

         dcl-pr SIQSH_getInstruction like(tSIQSH_Command) extproc(*dclcase);
           Command like(tSIQSH_Command) const options(*varsize);
         end-pr;

         dcl-pr SIQSH_getInstructionParam like(tSIQSH_Command)
                                          extproc(*dclcase);
           Command like(tSIQSH_Command) const options(*varsize);
           ParameterNumber like(tSIQSH_ParameterNumber) const;
         end-pr;

