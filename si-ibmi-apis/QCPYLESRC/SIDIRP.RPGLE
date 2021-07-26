         /if not defined(SIDIRP)
         /define SIDIRP
         /else
         /eof
         /endif

         /include qcpylesrc/siimfp

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIDIR like(tSIDIR_Def) template;
         dcl-s tSIDIR_Name varchar(256) template;

         dcl-ds tSIDIR_Def qualified;
           Name like(tSIDIR_Name);
         end-ds;

         /if defined(SIDIR)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIDIR_ like(tSIDIR) extproc(*dclcase);
           Directory like(tSIDIR_Name) value;
         end-pr;

         dcl-pr SIDIR_create ind extproc(*dclcase);
           SIDIR like(tSIDIR) value;
           ModeFlag like(tSIIMF);
         end-pr;

         dcl-pr SIDIR_exist ind extproc(*dclcase);
           SIDIR like(tSIDIR) value;
         end-pr;

         dcl-pr SIDIR_getName like(tSIDIR_Name) extproc(*dclcase);
           SIDIR like(tSIDIR) value;
         end-pr;

         dcl-pr SIDIR_setCurrentDirectory extproc(*dclcase);
           SIDIR like(tSIDIR) value;
         end-pr;

         dcl-pr SIDIR_getCurrentDirectory like(tSIDIR_Name) extproc(*dclcase);
         end-pr;

         dcl-pr SIDIR_setCurrentDirectoryByPath extproc(*dclcase);
           Path like(tSIDIR_Name) value;
         end-pr;
