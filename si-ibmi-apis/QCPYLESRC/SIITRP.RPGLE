         /if not defined(SIITRP)
         /define SIITRP
         /else
         /eof
         /endif

        //==========================================================================================
        //             Konstanten
        //==========================================================================================

         dcl-c cDefault_Data_Size const(32767);

        //==========================================================================================
        //             Templates
        //==========================================================================================

         dcl-s tSIITR pointer template;
         dcl-s tSIITR_Entry pointer template;
         dcl-s tSIITR_EntrySize uns(10) template;

         dcl-ds tSIITR_Def qualified template;
           this pointer;
           countEntrys uns(10);
           entrySize uns(10);
           nextEntry uns(10);
           allocatedSize uns(10);
           data char(1);
         end-ds;

         /if defined(SIITR)
         /eof
         /endif

        //==========================================================================================
        //             Prototypes
        //==========================================================================================

         dcl-pr SIITR_ForEach ind extproc(*dclcase);
           SIITR like(tSIITR);
         end-pr;

         dcl-pr SIITR_addEntry extproc(*dclcase);
           SIITR like(tSIITR);
           Entry like(tSIITR_Entry) const;
           EntrySize like(tSIITR_EntrySize) const;
         end-pr;

         dcl-pr SIITR_setValue extproc(*dclcase);
           SIITR like(tSIITR);
           Destination like(tSIITR_Entry) const;
         end-pr;

         dcl-pr SIITR_setToFirst ind extproc(*dclcase);
           SIITR like(tSIITR);
         end-pr;

         dcl-pr SIITR_isEmpty ind extproc(*dclcase);
           SIITR like(tSIITR);
         end-pr;

         dcl-pr SIITR_duplicate like(tSIITR) extproc(*dclcase);
           SIITR like(tSIITR);
         end-pr;

         dcl-pr SIITR_close extproc(*dclcase);
           SIITR like(tSIITR);
         end-pr;
