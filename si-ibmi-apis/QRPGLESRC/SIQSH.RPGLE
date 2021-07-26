        //******************************************************************************************
        //
        //
        // Programname   : SIQSH
        // Programauthor : Sranko Informatik
        // Created on    : 14.08.2018
        //
        //==========================================================================================
        //             Programm-Kompilierung                                           ?
        //==========================================================================================
        //
        // See QCLLESRC,MAKESIIIA
        //
        //==========================================================================================

         ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

         /define SIQSH
         /include qcpylesrc/siqshp

         /include qsysinc/qrpglesrc,ifs
         /include qcpylesrc/systemp
         /include qcpylesrc/strtokp

        //==========================================================================================
        //             Konstanten
        //==========================================================================================


        //==========================================================================================
        //             Templates
        //==========================================================================================

        //==========================================================================================
        //             Globale-Definitionen
        //==========================================================================================

        //==========================================================================================
        //             Prototypen
        //==========================================================================================

         dcl-pr QzshSystem int(10) ExtProc('QzshSystem');
           Command pointer value Options(*String);
         end-pr;

         dcl-pr QzshCheckShellCommand int(10) extproc('QzshCheckShellCommand');
           Command pointer value options(*String);
           Path pointer value options(*String:*nopass);
         end-pr;

         dcl-pr strerror pointer ExtProc('strerror');
           errnum int(10) value;
         end-pr;

        //==========================================================================================
        //  SIQSH_init
        //==========================================================================================

         dcl-proc SIQSH_init export;
         dcl-pi SIQSH_init like(tSIQSH) extproc(*dclcase);
          PathForStdin  like(tSIQSH_Path) const options(*nopass:*omit:*varsize);
          PathForStdout like(tSIQSH_Path) const options(*nopass:*omit:*varsize);
          PathForStderr like(tSIQSH_Path) const options(*nopass:*omit:*varsize);
         end-pi;
         dcl-c cDefaultPathForStd CONST('/dev/null');
         dcl-s ok ind inz(*on);
         dcl-s CWD char(256);

         dcl-ds dsSIQSH likeds(tSIQSH_Def) inz;

         if %parms() = 0;
           dsSIQSH.Stdin  = cDefaultPathForStd;
           dsSIQSH.Stdout = cDefaultPathForStd;
           dsSIQSH.Stderr = cDefaultPathForStd;
         endif;
         if %parms() > 0;
           if %addr( PathForStdin ) = *NULL;
             dsSIQSH.Stdin = cDefaultPathForStd;
           else ;
             dsSIQSH.Stdin = PathForStdin;
           endif;
         endif;
         if %parms() > 1;
           if %addr( PathForStdout ) = *NULL;
             dsSIQSH.Stdout = cDefaultPathForStd;
           else ;
             dsSIQSH.Stdout = PathForStdout;
           endif;
         endif;
         if %parms() > 2;
           if %addr( PathForStderr ) = *NULL;
             dsSIQSH.Stderr = cDefaultPathForStd;
           else ;
             dsSIQSH.Stderr = PathForStderr;
           endif;
         endif;

         if getcwd(%addr(CWD):%size(CWD)) = *null;
           dsply ('CWD nicht ermittelt.');
           return *off;
         endif;
         CWD = %str(%addr(cwd));
         if %subst(%triml(dsSIQSH.Stdin):1:1) = '.';
           dsSIQSH.StdIn = %trim(CWD) + %subst(%triml(dsSIQSH.Stdin):2);
         endif;
         if %subst(%triml(dsSIQSH.Stdout):1:1) = '.';
           dsSIQSH.Stdout = %trim(CWD) + %subst(%triml(dsSIQSH.Stdout):2);
         endif;
         if %subst(%triml(dsSIQSH.Stderr):1:1) = '.';
           dsSIQSH.Stderr = %trim(CWD) + %subst(%triml(dsSIQSH.Stderr):2);
         endif;

         ok = checkDescriptor (dsSIQSH.Stdin
               : STDIN_FILENO
               : 0 + O_CREAT + O_TRUNC + O_RDWR
               : 0 + S_IRWXU
               : 0 + O_RDONLY)
         and  checkDescriptor (dsSIQSH.Stdout
               : STDOUT_FILENO
               : 0 + O_CREAT + O_TRUNC + O_WRONLY
               : 0 + S_IRWXU
               : 0 + O_RDWR)
         and  checkDescriptor (dsSIQSH.Stderr
               : STDERR_FILENO
               : 0 + O_CREAT + O_TRUNC + O_WRONLY
               : 0 + S_IRWXU
               : 0 + O_RDWR);

         if not ok;
           dsply ('Descriptors 0, 1 and 2 not opened successfully.');
         endif;

         return dsSIQSH;
         end-proc;

        //==========================================================================================
        // checkDescriptor
        //==========================================================================================
         dcl-proc checkDescriptor;
         dcl-pi checkDescriptor Ind extproc(*dclcase);
           StdOutput  like(tSIQSH_Path);
           descriptor int(10) value;
           mode       int(10) value;
           auth       int(10) value;
           other_valid_mode int(10) value;
         end-pi;

         dcl-pr fcntl int(10) extproc('fcntl');
           descriptor int(10) value;
           action     int(10) value;
           arg        int(10) value options(*nopass);
         end-pr;

         dcl-c cGetFlags const(x'06');

         dcl-s flags int(10);
         dcl-s new_desc int(10);
         dcl-s actual_acc int(10);
         dcl-s required_acc int(10);
         dcl-s allowed_acc int(10);

         new_desc = close(descriptor);

         flags = fcntl (descriptor : cGetFlags);
         if flags < 0;
             // no flags returned, attempt to open this descriptor
             new_desc = open (%trim(StdOutput) : mode : auth);
             if new_desc <> descriptor;
                // we didn't get the right descriptor number, so
                // close the one we got and return '0'
                if new_desc >= 0;
                   new_desc = close(new_desc);
                endif;
                return '0';
             endif;
          else;
             // check if the file was opened with the correct
             // access mode
             actual_acc = %bitand (flags : O_ACCMODE);
             required_acc = %bitand (mode : O_ACCMODE);
             allowed_acc = %bitand (other_valid_mode : O_ACCMODE);
             if  actual_acc <> required_acc
             and actual_acc <> allowed_acc;
                return '0';
             endif;
          endif;

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_close
        //==========================================================================================

         dcl-proc SIQSH_close export;
         dcl-pi SIQSH_close Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;
         dcl-s desc int(10);

         desc = close(STDIN_FILENO);
         desc = close(STDOUT_FILENO);
         desc = close(STDERR_FILENO);

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_runCommand
        //==========================================================================================

         dcl-proc SIQSH_runCommand export;
         dcl-pi SIQSH_runCommand Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
           Command like(tSIQSH_Command) const options(*varsize);
         end-pi;
         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         dsSIQSH.Command = Command;
         if QzshSystem(Command) = -1 ;
           return *off;
         else;
           return *on;
         endif;

         end-proc;

        //==========================================================================================
        // SIQSH_checkCommand
        //==========================================================================================

         dcl-proc SIQSH_checkCommand export;
         dcl-pi SIQSH_checkCommand Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
           Command like(tSIQSH_Command) const options(*varsize);
           Path pointer value Options(*String:*nopass);
         end-pi;

         select;
         when %parms() > 2;
           if QzshCheckShellCommand(%trim(Command):Path) = 0;
             return *on;
           else;
             return *off;
           endif;
         when %parms() > 1;
           if QzshCheckShellCommand(%trim(Command)) = 0;
             return *on;
           else;
             return *off;
           endif;
         endsl;

         end-proc;

        //==========================================================================================
        // SIQSH_clearStdIn
        //==========================================================================================

         dcl-proc SIQSH_clearStdIn export;
         dcl-pi SIQSH_clearStdIn Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         if not checkDescriptor (dsSIQSH.Stdin
               : STDIN_FILENO
               : 0 + O_CREAT + O_TRUNC + O_WRONLY
               : 0 + S_IWUSR + S_IWOTH
               : 0 + O_RDWR);
           dsply ('StdOut könnte nicht wiederhergestellt werden.');
           return *off;
         endif;

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_clearStdOut
        //==========================================================================================

         dcl-proc SIQSH_clearStdOut export;
         dcl-pi SIQSH_clearStdOut Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-s fd int(10);

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         if not checkDescriptor (dsSIQSH.Stdout
               : STDOUT_FILENO
               : 0 + O_CREAT + O_TRUNC + O_WRONLY
               : 0 + S_IWUSR + S_IWOTH
               : 0 + O_RDWR);
           dsply ('StdOut könnte nicht wiederhergestellt werden.');
           return *off;
         endif;

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_clearStdErr
        //==========================================================================================

         dcl-proc SIQSH_clearStdErr export;
         dcl-pi SIQSH_clearStdErr Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         if not checkDescriptor (dsSIQSH.Stderr
               : STDERR_FILENO
               : 0 + O_CREAT + O_TRUNC + O_WRONLY
               : 0 + S_IWUSR + S_IWOTH
               : 0 + O_RDWR);
           dsply ('StdOut könnte nicht wiederhergestellt werden.');
           return *off;
         endif;

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_clearStdFiles
        //==========================================================================================

         dcl-proc SIQSH_clearStdFiles export;
         dcl-pi SIQSH_clearStdFiles Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         if  SIQSH_clearStdIn(SIQSH)
         and SIQSH_clearStdOut(SIQSH)
         and SIQSH_clearStdErr(SIQSH);
           return *on;
         else;
           return *off;
         endif;

         end-proc;

        //==========================================================================================
        // SIQSH_getStdIn
        //==========================================================================================

         dcl-proc SIQSH_getStdIn export;
         dcl-pi SIQSH_getStdIn like(tSIQSH_StdOutput) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-s StdOutput like(tSIQSH_StdOutput);

         dcl-s fd int(10);
         dcl-s displayError char(52);
         dcl-s errno int(10) BASED(pErrno);

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         fd = open(%trim(dsSIQSH.Stdin):O_RDONLY);
         if fd = -1;
           pErrno = getErrnoPtr();
           displayError = %str(strerror(errno));
           dsply (displayError);
         endif;

         if read(fd:%addr(StdOutput):%size(StdOutput)) = -1;
           pErrno = getErrnoPtr();
           displayError = %str(strerror(errno));
           dsply (displayError);
           return *blanks;
         endif;
         fd = close(fd);

         return StdOutput;
         end-proc;

        //==========================================================================================
        // SIQSH_getStdOut
        //==========================================================================================

         dcl-proc SIQSH_getStdOut export;
         dcl-pi SIQSH_getStdOut like(tSIQSH_StdOutput) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-s StdOutput like(tSIQSH_StdOutput);

         dcl-s fd int(10);
         dcl-s displayError char(52);
         dcl-s errno int(10) BASED(pErrno);

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         fd = open(%trim(dsSIQSH.Stdout):O_RDONLY);
         if fd = -1;
           pErrno = getErrnoPtr();
           displayError = %str(strerror(errno));
           dsply (displayError);
         endif;

         if read(fd:%addr(StdOutput):%size(StdOutput)) = -1;
           pErrno = getErrnoPtr();
           displayError = %str(strerror(errno));
           dsply (displayError);
           return *blanks;
         endif;
         fd = close(fd);

         return StdOutput;
         end-proc;

        //==========================================================================================
        // SIQSH_getStdErr
        //==========================================================================================

         dcl-proc SIQSH_getStdErr export;
         dcl-pi SIQSH_getStdErr like(tSIQSH_StdOutput) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-s StdOutput like(tSIQSH_StdOutput);

         dcl-s fd int(10);
         dcl-s displayError char(52);
         dcl-s errno int(10) BASED(pErrno);

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         fd = open(%trim(dsSIQSH.Stderr):O_RDONLY);
         if fd = -1;
           pErrno = getErrnoPtr();
           displayError = %str(strerror(errno));
           dsply (displayError);
         endif;

         if read(fd:%addr(StdOutput):%size(StdOutput)) = -1;
           pErrno = getErrnoPtr();
           displayError = %str(strerror(errno));
           dsply (displayError);
           return *blanks;
         endif;
         fd = close(fd);

         return StdOutput;
         end-proc;

        //==========================================================================================
        // SIQSH_deleteStdInFile
        //==========================================================================================

         dcl-proc SIQSH_deleteStdInFile export;
         dcl-pi SIQSH_deleteStdInFile Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         if unlink(%trim(dsSIQSH.Stdin)) < 0;
           return *off;
         endif;

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_deleteStdOutFile
        //==========================================================================================

         dcl-proc SIQSH_deleteStdOutFile export;
         dcl-pi SIQSH_deleteStdOutFile Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         if unlink(%trim(dsSIQSH.Stdout)) < 0;
           return *off;
         endif;

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_deleteStdErrFile
        //==========================================================================================

         dcl-proc SIQSH_deleteStdErrFile export;
         dcl-pi SIQSH_deleteStdErrFile Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         if unlink(%trim(dsSIQSH.Stderr)) < 0;
           return *off;
         endif;

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_deleteStdFiles
        //==========================================================================================

         dcl-proc SIQSH_deleteStdFiles export;
         dcl-pi SIQSH_deleteStdFiles Ind extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         SIQSH_deleteStdInFile(SIQSH);
         SIQSH_deleteStdOutFile(SIQSH);
         SIQSH_deleteStdErrFile(SIQSH);

         return *on;
         end-proc;

        //==========================================================================================
        // SIQSH_getCWD
        //==========================================================================================

         dcl-proc SIQSH_getCWD export;
         dcl-pi SIQSH_getCWD like(tSIQSH_Path) extproc(*dclcase);
         end-pi;
         dcl-s sCWD char(512);

         if getcwd(%addr(sCWD):%size(sCWD)) = *null;
           dsply ('CWD nicht ermittelt.');
           return '';
         endif;

         return %str(%addr(sCWD));
         end-proc;

        //==========================================================================================
        // SIQSH_deleteStdErrFile
        //==========================================================================================

         dcl-proc SIQSH_getCommand export;
         dcl-pi SIQSH_getCommand like(tSIQSH_Command) extproc(*dclcase);
           SIQSH like(tSIQSH);
         end-pi;

         dcl-ds dsSIQSH likeds(tSIQSH_Def) based(pSIQSH);
         pSIQSH = %addr(SIQSH);

         return %trim(dsSIQSH.Command);
         end-proc;

        //==========================================================================================
        // SIQSH_deleteStdErrFile
        //==========================================================================================

         dcl-proc SIQSH_getInstruction export;
         dcl-pi SIQSH_getInstruction like(tSIQSH_Command) extproc(*dclcase);
           Command like(tSIQSH_Command) const options(*varsize);
         end-pi;
         dcl-s token like(tSTRTOK_Token);

         token = strtok(Command:' ');

         monitor;
           return %str(token);
         on-error;
           return Command;
         endmon;
         end-proc;

        //==========================================================================================
        // SIQSH_deleteStdErrFile
        //==========================================================================================

         dcl-proc SIQSH_getInstructionParam export;
         dcl-pi SIQSH_getInstructionParam like(tSIQSH_Command)
                                          extproc(*dclcase);
           Command like(tSIQSH_Command) const options(*varsize);
           ParameterNumber like(tSIQSH_ParameterNumber) const;
         end-pi;
         dcl-c delimiter const(' ');
         dcl-s counter int(5);
         dcl-s token like(tSTRTOK_Token);

         // erster Token wird ignoriert, es ist der Befehl
         token = strtok(Command:delimiter);
         if token = *null;
           return '';
         endif;

         counter = 0;

         dow not %shtdn(); // endlose Schleife
           token = strtok(*null: delimiter);
           if token = *null;
             leave;
           endif;

           counter = counter + 1;
           if counter = ParameterNumber;
             return %str(token);
           endif;
         enddo;
         return '';
         end-proc;

