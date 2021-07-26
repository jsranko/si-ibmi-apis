        //******************************************************************************************
        //
        //
        // Programname    : SIDT
        // Programautor   : Sranko Informatik
        // Created on     : 20.03.2019
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
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIDT
         /include qcpylesrc/sidtp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getFirstDayOfWeekByWeekAndYear export;
         dcl-pi SIDT_getFirstDayOfWeekByWeekAndYear like(tSIDT_Date)
                                                 extproc(*dclcase);
           WeekNumber like(tSIDT_WeekNumber) const;
           Year like(tSIDT_Year) const;
         end-pi;
         dcl-c cWeekDays const(7);
         dcl-s firstDayOfYear date;
         dcl-s dateInCW like(tSIDT_Date);
         dcl-s daysToCW int(5); // Calendar Week
         dcl-s dayOfWeek like(tSIDT_DayOfWeek);

         firstDayOfYear = %date(%char(Year) + '-01-01');
         if WeekNumber > 1;
           daysToCW = (WeekNumber-1) * cWeekDays;
         else;
           daysToCW = cWeekDays;
         endif;

         exec sql set :dateInCW = :firstDayOfYear + :daysToCW days;

         exec sql set :dayOfWeek = dayofweek_iso(:dateInCW);

         if dayOfWeek > 1;
           dateInCW = dateInCW - %days(dayOfWeek - 1);
         endif;

         return dateInCW;
         end-proc;

        //------------------------------------------------------------------------------------------

        dcl-proc SIDT_getLastDayOfWeekByWeekAndYear export;
         dcl-pi SIDT_getLastDayOfWeekByWeekAndYear like(tSIDT_Date)
                                                 extproc(*dclcase);
           WeekNumber like(tSIDT_WeekNumber) const;
           Year like(tSIDT_Year) const;
         end-pi;
         dcl-c cWeekDays const(7);
         dcl-s firstDayOfYear date;
         dcl-s dateInCW like(tSIDT_Date);
         dcl-s daysToCW int(5); // Calendar Week
         dcl-s dayOfWeek like(tSIDT_DayOfWeek);

         firstDayOfYear = %date(%char(Year) + '-01-01');
         if WeekNumber > 1;
           daysToCW = (WeekNumber-1) * cWeekDays;
         else;
           daysToCW = cWeekDays;
         endif;

         exec sql set :dateInCW = :firstDayOfYear + :daysToCW days;

         exec sql set :dayOfWeek = dayofweek_iso(:dateInCW);

         select;
         when dayOfWeek = 5;
         when dayOfWeek < 5;
           dateInCW = dateInCW + %days(5 -dayOfWeek);
         when dayOfWeek > 5;
           dateInCW = dateInCW - %days(dayOfWeek - 5);
         endsl;

         return dateInCW;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_listAllMonths export;
         dcl-pi SIDT_listAllMonths like(tSIDT_List) extproc(*dclcase);
         end-pi;
         dcl-s i int(5);
         dcl-s Month date inz(d'2019-01-01');
         dcl-s MonthName like(tSIDT_MonthName);
         dcl-s Months like(tSIDT_List);

         for i=1 to 12;

           exec sql set :MonthName = monthname(:Month);

           SIITR_addEntry(Months:%addr(MonthName):%size(MonthName));
           Month = Month + %months(1);

         endfor;

         return Months;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentYear export;
         dcl-pi SIDT_getCurrentYear like(tSIDT_Year) extproc(*dclcase);
         end-pi;

         return %subdt(%timestamp():*years);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentMonth export;
         dcl-pi SIDT_getCurrentMonth like(tSIDT_Month) extproc(*dclcase);
         end-pi;

         return %subdt(%timestamp():*months);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentDay export;
         dcl-pi SIDT_getCurrentDay like(tSIDT_Day) extproc(*dclcase);
         end-pi;

         return %subdt(%timestamp():*days);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentCentury export;
         dcl-pi SIDT_getCurrentCentury like(tSIDT_Century) extproc(*dclcase);
         end-pi;

         return %dec(%subst(%char(%subdt(%timestamp():*years)):1:2):2:0);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentYear2 export;
         dcl-pi SIDT_getCurrentYear2 like(tSIDT_Year2) extproc(*dclcase);
         end-pi;

         return %dec(%subst(%char(%subdt(%timestamp():*years)):3:2):2:0);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentHour export;
         dcl-pi SIDT_getCurrentHour like(tSIDT_Hour) extproc(*dclcase);
         end-pi;

         return %subdt(%timestamp():*hours);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentMinutes export;
         dcl-pi SIDT_getCurrentMinutes like(tSIDT_Minutes) extproc(*dclcase);
         end-pi;

         return %subdt(%timestamp():*minutes);
         end-proc;
        //------------------------------------------------------------------------------------------

         dcl-proc SIDT_getCurrentSeconds export;
         dcl-pi SIDT_getCurrentSeconds like(tSIDT_Seconds) extproc(*dclcase);
         end-pi;

         return %subdt(%timestamp():*seconds);
         end-proc;
