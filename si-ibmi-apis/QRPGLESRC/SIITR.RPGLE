        //******************************************************************************************
        //
        //
        // Programname   : SIITR
        // Programautor  : Sranko Informatik
        // Created on    : 16.11.2018
        //
        //==========================================================================================
        //             Program-Cimpilierung                                           Â€
        //==========================================================================================
        //
        // See QCLLESRC,MAKESIIIA
        //
        //==========================================================================================

         ctl-opt NoMain;

         /define SIITR
         /include qcpylesrc/siitrp

         /include qcpylesrc/memcpyp

        //==========================================================================================
        //             Templates
        //==========================================================================================

        //==========================================================================================
        //             Globale-Definitionen
        //==========================================================================================


        //==========================================================================================
        //             Prototypen
        //==========================================================================================


        //==========================================================================================
        //             Prozeduren
        //==========================================================================================

         dcl-proc SIITR_ForEach export;
         dcl-pi SIITR_ForEach ind extproc(*dclcase);
           SIITR like(tSIITR);
         end-pi;
         dcl-ds Itr likeds(tSIITR_Def) based(pItr);
         pItr = SIITR;

         if SIITR = *Null;
           return *off;
         endif;

         if Itr.this = *Null;
           Itr.this = %addr(Itr.data);
           Itr.nextEntry = 1;
           return *on;
         endif;
         if ((Itr.nextEntry + 1) > Itr.countEntrys);
           Itr.this = *Null;
           Itr.nextEntry = 0;
           return *off;
         endif;
         monitor;
           Itr.this = %addr(Itr.data) + Itr.nextEntry * Itr.entrySize;
           Itr.nextEntry = Itr.nextEntry + 1;
         on-error;
           return *off;
         endmon;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIITR_addEntry export;
         dcl-pi SIITR_addEntry extproc(*dclcase);
           SIITR like(tSIITR);
           Entry like(tSIITR_Entry) const;
           EntrySize like(tSIITR_EntrySize) const;
         end-pi;
         dcl-ds Itr likeds(tSIITR_Def) based(pItr);

         monitor;
         if SIITR = *Null;
           SIITR = %alloc(cDefault_Data_Size);
           pItr = SIITR;
           clear Itr;
           Itr.entrySize = EntrySize;
           Itr.allocatedSize = %size(tSIITR_Def) + cDefault_Data_Size;
         endif;
         pItr = SIITR;
         if Itr.entrySize <> EntrySize;
           dsply ('EntrySize stimmt nicht vorheriger Entry.');
           return;
         endif;
         if ((Itr.countEntrys + 1) * Itr.entrySize) > Itr.allocatedSize;
           SIITR = %realloc(SIITR:Itr.allocatedSize + cDefault_Data_Size);

           pItr = SIITR;
           Itr.allocatedSize = Itr.allocatedSize + cDefault_Data_Size;
         endif;

         MemCpy(%addr(Itr.data) + Itr.countEntrys * entrySize :Entry:EntrySize);

         Itr.countEntrys = Itr.countEntrys + 1;

         on-error;
           dsply ('Irgendwas ging schief.');
         endmon;
         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIITR_setValue export;
         dcl-pi SIITR_setValue extproc(*dclcase);
           SIITR like(tSIITR);
           Destination like(tSIITR_Entry) const;
         end-pi;
         dcl-ds Itr likeds(tSIITR_Def) based(pItr);

         if SIITR_isEmpty(SIITR);
           return;
         endif;

         pItr = SIITR;

         MemCpy(Destination
               :Itr.this:Itr.EntrySize);

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIITR_setToFirst export;
         dcl-pi SIITR_setToFirst ind extproc(*dclcase);
           SIITR like(tSIITR);
         end-pi;
         dcl-ds Itr likeds(tSIITR_Def) based(pItr);

         if SIITR_isEmpty(SIITR);
           return *off;
         endif;

         pItr = SIITR;

         Itr.this = *Null;

         return *on;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIITR_isEmpty export;
         dcl-pi SIITR_isEmpty ind extproc(*dclcase);
           SIITR like(tSIITR);
         end-pi;

         if SIITR = *Null;
           return *on;
         else;
           return *off;
         endif;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIITR_duplicate export;
         dcl-pi SIITR_duplicate like(tSIITR) extproc(*dclcase);
           SIITR like(tSIITR);
         end-pi;
         dcl-s output like(tSIITR);
         dcl-ds Itr likeds(tSIITR_Def) based(pItr);

         if SIITR_isEmpty(SIITR);
           return output;
         endif;

         pItr = SIITR;

         output = %alloc(Itr.allocatedSize);
         MemCpy(output:SIITR:Itr.allocatedSize);

         return output;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIITR_close export;
         dcl-pi SIITR_close extproc(*dclcase);
           SIITR like(tSIITR);
         end-pi;

         monitor;
           dealloc(n) SIITR;
         on-error;
           dsply ('Irgendwas ging schief.');
         endmon;

         return;
         end-proc;
