         /if not defined(SIJLP)
         /define SIJLP
         /else
         /eof
         /endif


        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cSIJL_NOT_SUCCESSFUL const('-1');


        //==========================================================================================
        // Templates
        //==========================================================================================

         /if defined(SIJL)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIJL_write int(10) extproc(*dclcase);
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
         end-pr;
