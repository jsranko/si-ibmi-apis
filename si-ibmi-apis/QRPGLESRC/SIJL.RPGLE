        //******************************************************************************************
        //
        //
        // Programname    : SIJL
        // Programautor   : Sranko Informatik
        // Created on     : 06.03.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain;

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

         /define SIJL
         /include qcpylesrc/sijlp

         /include qcpylesrc/qp0zcpap

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIJL_write export;
         dcl-pi SIJL_write int(10) extproc(*dclcase);
           FormatedString pointer options(*string) value;
           Value02 pointer options(*string:*nopass) value;
           Value03 pointer options(*string:*nopass) value;
           Value04 pointer options(*string:*nopass) value;
           Value05 pointer options(*string:*nopass) value;
           Value06 pointer options(*string:*nopass) value;
           Value07 pointer options(*string:*nopass) value;
           Value08 pointer options(*string:*nopass) value;
           Value09 pointer options(*string:*nopass) value;
           Value10 pointer options(*string:*nopass) value;
           Value11 pointer options(*string:*nopass) value;
           Value12 pointer options(*string:*nopass) value;
           Value13 pointer options(*string:*nopass) value;
           Value14 pointer options(*string:*nopass) value;
           Value15 pointer options(*string:*nopass) value;
           Value16 pointer options(*string:*nopass) value;
           Value17 pointer options(*string:*nopass) value;
           Value18 pointer options(*string:*nopass) value;
           Value19 pointer options(*string:*nopass) value;
           Value20 pointer options(*string:*nopass) value;
         end-pi;


         return Qp0zLprintf(%str(FormatedString) + x'25'
                           :Value02
                           :Value03
                           :Value04
                           :Value05
                           :Value06
                           :Value07
                           :Value08
                           :Value09
                           :Value10
                           :Value11
                           :Value12
                           :Value13
                           :Value14
                           :Value15
                           :Value16
                           :Value17
                           :Value18
                           :Value19
                           :Value20
                           );
         end-proc;

