         /if not defined(SIDTP)
         /define SIDTP
         /else
         /eof
         /endif

         /include qcpylesrc/siitrp

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIDT_Date date template;
         dcl-s tSIDT_DayOfWeek packed(1:0) template;
         dcl-s tSIDT_WeekNumber packed(2:0) template;
         dcl-s tSIDT_Year packed(4:0) template;
         dcl-s tSIDT_Month packed(2:0) template;
         dcl-s tSIDT_Day packed(2:0) template;
         dcl-s tSIDT_MonthName varchar(100) template;
         dcl-s tSIDT_List like(tSIITR) template;
         dcl-s tSIDT_Century packed(2:0) template;
         dcl-s tSIDT_Year2 packed(2:0) template;
         dcl-s tSIDT_Hour packed(2:0) template;
         dcl-s tSIDT_Minutes packed(2:0) template;
         dcl-s tSIDT_Seconds packed(2:0) template;

         /if defined(SIDT)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIDT_getFirstDayOfWeekByWeekAndYear like(tSIDT_Date)
                                                 extproc(*dclcase);
           WeekNumber like(tSIDT_WeekNumber) const;
           Year like(tSIDT_Year) const;
         end-pr;

         dcl-pr SIDT_getLastDayOfWeekByWeekAndYear like(tSIDT_Date)
                                                 extproc(*dclcase);
           WeekNumber like(tSIDT_WeekNumber) const;
           Year like(tSIDT_Year) const;
         end-pr;

         dcl-pr SIDT_listAllMonths like(tSIDT_List) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentYear like(tSIDT_Year) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentMonth like(tSIDT_Month) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentDay like(tSIDT_Day) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentCentury like(tSIDT_Century) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentYear2 like(tSIDT_Year2) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentHour like(tSIDT_Hour) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentMinutes like(tSIDT_Minutes) extproc(*dclcase);
         end-pr;

         dcl-pr SIDT_getCurrentSeconds like(tSIDT_Seconds) extproc(*dclcase);
         end-pr;
