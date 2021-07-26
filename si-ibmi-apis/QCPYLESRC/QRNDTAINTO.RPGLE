     /*  begin_generated_IBM_copyright_prolog                             */
     /* This is an automatically generated copyright prolog.              */
     /* After initializing,  DO NOT MODIFY OR MOVE                        */
     /* ----------------------------------------------------------------- */
     /*                                                                   */
     /* Product(s):                                                       */
     /*     5770-WDS                                                      */
     /*                                                                   */
     /* (C)Copyright IBM Corp.  2010, 2018                                */
     /*                                                                   */
     /* All rights reserved.                                              */
     /* US Government Users Restricted Rights -                           */
     /* Use, duplication or disclosure restricted                         */
     /* by GSA ADP Schedule Contract with IBM Corp.                       */
     /*                                                                   */
     /* Licensed Materials-Property of IBM                                */
     /*                                                                   */
     /*  ---------------------------------------------------------------  */
     /*                                                                   */
     /* end_generated_IBM_copyright_prolog                                */
     /*** START HEADER FILE SPECIFICATIONS ***********************        */
     /*                                                                   */
     /*Header File Name: QRNOPENACC                                       */
     /*                                                                   */
     /*Descriptive Name: API error numbers.                               */
     /*                                                                   */
     /*Change Activity:                                                   */
     /*                                                                   */
     /*CFD List:                                                          */
     /*                                                                   */
     /*FLAG REASON       LEVEL YYMMDD PGMR      CHANGE DESCRIPTION        */
     /*---- ------------ ----- ------ --------- ----------------------    */
     /*$A0=                    170215 BLM       New Include               */
     /*                                                                   */
     /*End CFD List.                                                      */
     /*                                                                   */
     /*Additional notes about the Change Activity                         */
     /*End Change Activity.                                               */
     /*** END HEADER FILE SPECIFICATIONS ******************************   */
      /IF DEFINED(QrnDataInto_Included)
      /EOF
      /ENDIF
      /DEFINE QrnDataInto_Included

       DCL-C QrnDi_JOB_CCSID 0;

       // Structure passed to a data-into handler
       DCL-DS QrnDiParm_T QUALIFIED TEMPLATE;
          data POINTER;
          env POINTER;
          handle POINTER;
          userParm POINTER;
          dataLen UNS(10);
          dataCcsid UNS(10);
          userParmIsNullTermString IND;
          *N CHAR(7);
          *N POINTER DIM(4);
       END-DS;

       // pQrnDiEnv must be set from the env subfield of the
       // parameter passed to the parser to enable access
       // to the callback procedures
       DCL-DS QrnDiEnv QUALIFIED BASED(pQrnDiEnv);
          start POINTER(*PROC);
          finish POINTER(*PROC);
          reportError POINTER(*PROC);
          reportName POINTER(*PROC);
          reportValue POINTER(*PROC);
          startStruct POINTER(*PROC);
          endStruct POINTER(*PROC);
          startArray POINTER(*PROC);
          endArray POINTER(*PROC);
          reportNameCcsid POINTER(*PROC);
          reportValueCcsid POINTER(*PROC);
          trace POINTER(*PROC);
          reportAttr POINTER(*PROC);
          reportAttrCcsid POINTER(*PROC);
          *N POINTER(*PROC) DIM(17);
       END-DS;

       // Prototypes for the callback procedures

       DCL-PR QrnDiStart EXTPROC(*CWIDEN:QrnDiEnv.start);
          handle POINTER VALUE;
       END-PR;

       DCL-PR QrnDiFinish EXTPROC(*CWIDEN:QrnDiEnv.finish);
          handle POINTER VALUE;
       END-PR;

       DCL-PR QrnDiReportError EXTPROC(*CWIDEN:QrnDiEnv.reportError);
          handle POINTER VALUE;
          returnCode INT(10) VALUE;
          bytesParsed UNS(10) VALUE;
       END-PR;

       DCL-PR QrnDiReportName EXTPROC(*CWIDEN:QrnDiEnv.reportName);
          handle POINTER VALUE;
          name POINTER VALUE;
          nameLength UNS(10) VALUE;
       END-PR;

       DCL-PR QrnDiReportNameCcsid
                         EXTPROC(*CWIDEN:QrnDiEnv.reportNameCcsid);
          handle POINTER VALUE;
          name POINTER VALUE;
          nameLength UNS(10) VALUE;
          ccsid UNS(10) VALUE;
       END-PR;

       DCL-PR QrnDiReportValue EXTPROC(*CWIDEN:QrnDiEnv.reportValue);
          handle POINTER VALUE;
          val POINTER VALUE;
          valLength UNS(10) VALUE;
       END-PR;

       DCL-PR QrnDiReportValueCcsid
                         EXTPROC(*CWIDEN:QrnDiEnv.reportValueCcsid);
          handle POINTER VALUE;
          val POINTER VALUE;
          valLength UNS(10) VALUE;
          ccsid UNS(10) VALUE;
       END-PR;

       DCL-PR QrnDiStartStruct EXTPROC(*CWIDEN:QrnDiEnv.startStruct);
          handle POINTER VALUE;
       END-PR;

       DCL-PR QrnDiEndStruct EXTPROC(*CWIDEN:QrnDiEnv.endStruct);
          handle POINTER VALUE;
       END-PR;

       DCL-PR QrnDiStartArray EXTPROC(*CWIDEN:QrnDiEnv.startArray);
          handle POINTER VALUE;
       END-PR;

       DCL-PR QrnDiEndArray EXTPROC(*CWIDEN:QrnDiEnv.endArray);
          handle POINTER VALUE;
       END-PR;

       DCL-PR QrnDiTrace EXTPROC(*CWIDEN:QrnDiEnv.trace);
          handle POINTER VALUE;
          msg POINTER VALUE OPTIONS(*STRING);
          nested IND VALUE;
       END-PR;

       DCL-PR QrnDiReportAttr
                         EXTPROC(*CWIDEN:QrnDiEnv.reportAttr);
          handle POINTER VALUE;
          name POINTER VALUE;
          nameLength UNS(10) VALUE;
          value POINTER VALUE;
          valueLength UNS(10) VALUE;
       END-PR;

       DCL-PR QrnDiReportAttrCcsid
                         EXTPROC(*CWIDEN:QrnDiEnv.reportAttrCcsid);
          handle POINTER VALUE;
          name POINTER VALUE;
          nameLength UNS(10) VALUE;
          nameCcsid UNS(10) VALUE;
          value POINTER VALUE;
          valueLength UNS(10) VALUE;
          valueCcsid UNS(10) VALUE;
       END-PR;

