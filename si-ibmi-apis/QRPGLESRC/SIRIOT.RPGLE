**FREE
//******************************************************************************************
//
//
// Programname    : SIRIOT
// Programautor   : Sranko Informatik
// Created on     : 22.02.2021
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
//
//==========================================================================================

ctl-opt main(SIRIOT) dftactgrp(*no) actgrp(*new) bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/siriop

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIRIOT;
dcl-pi SIRIOT;
end-pi;
dcl-s disp varchar(52);
dcl-s myEmp like(tSIRIO);
dcl-s myTest like(tSIRIO);
dcl-s myText char(20);
dcl-ds inMyEmp extname('$(LIBRARY)/MY_EMP':*input) qualified inz;
end-ds;
dcl-ds keyMyEmp extname('$(LIBRARY)/MY_EMP':*key) qualified inz;
end-ds;
dcl-ds outMyEmp extname('$(LIBRARY)/MY_EMP':*output) qualified inz;
end-ds;

  exsr testWrite2;

  myEmp = SIRIO_open('MY_EMP':'$(LIBRARY)');
  SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  SIRIO_readPreviousWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  //SIRIO_setEOF( myEmp );
  //SIRIO_readPreviousWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  keyMyEmp.EmpId = 10;
  SIRIO_setLL(myEmp:%addr(keyMyEmp):%size(keyMyEmp));
  SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));

  SIRIO_setBOF(myEmp);
  dou SIRIO_isEOF(myEmp);
    SIRIO_readNextNoLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  enddo;
  SIRIO_close(myEmp);

  exsr testWrite;
  //exsr testUpdate;
  //exsr testDelete;

  return;

  // -------------------------------------------------------
  begsr testWrite;

    myEmp = SIRIO_open('MY_EMP':'$(LIBRARY)':*omit:cRECIO_READ_WRITE_AND_APPEND);
    //myEmp = SIRIO_open('MY_EMP':'$(LIBRARY)':*omit:cRECIO_READ_WRITE_AND_UPDATE);
    outMyEmp.EmpID = 22;
    outMyEmp.Name = 'J Sranko';
    outMyEmp.Salary = 450;
    outMyEmp.Mgrid = 17;
    if not SIRIO_write(myEmp:%addr(outMyEmp):%size(outMyEmp));
      disp = SIRIO_getErrorAsText(myEmp);
      dsply (disp);
      SIRIO_close(myEmp);
      leavesr;
    endif;
     SIRIO_close(myEmp);
  endsr;

    // -------------------------------------------------------
  begsr testWrite2;

    myTest = SIRIO_open('MY_TEST2':'$(LIBRARY)':*omit:cRECIO_READ_WRITE_AND_APPEND);
    myText = 'Hallo ich bin test';
    if not SIRIO_write(myTest:%addr(myText):%size(myText));
      disp = SIRIO_getErrorAsText(myTest);
      dsply (disp);
      SIRIO_close(myTest);
      leavesr;
    endif;
     SIRIO_close(myTest);
  endsr;

  // -------------------------------------------------------
  begsr testDelete;

    myEmp = SIRIO_open('MY_EMP':'$(LIBRARY)':*omit:cRECIO_READ_WRITE_AND_UPDATE);
    keyMyEmp.EmpId = 13;
    SIRIO_setLL(myEmp:%addr(keyMyEmp):%size(keyMyEmp));
    if not SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
      disp = SIRIO_getErrorAsText(myEmp);
      dsply (disp);
      SIRIO_close(myEmp);
      leavesr;
    endif;
    if not SIRIO_delete(myEmp);
      disp = SIRIO_getErrorAsText(myEmp);
      dsply (disp);
      SIRIO_close(myEmp);
      leavesr;
    endif;
    SIRIO_close(myEmp);

  endsr;

  // -------------------------------------------------------
  begsr testUpdate;

    myEmp = SIRIO_open('MY_EMP':'$(LIBRARY)':*omit:cRECIO_READ_WRITE_AND_UPDATE);
    keyMyEmp.EmpId = 11;
    SIRIO_setLL(myEmp:%addr(keyMyEmp):%size(keyMyEmp));
    if not SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
      disp = SIRIO_getErrorAsText(myEmp);
      dsply (disp);
      SIRIO_close(myEmp);
      leavesr;
    endif;
    outMyEmp = inMyEmp;
    outMyEmp.Name = 'P Sranko';
    if not SIRIO_update(myEmp:%addr(outMyEmp):%size(outMyEmp));
      disp = SIRIO_getErrorAsText(myEmp);
      dsply (disp);
      SIRIO_close(myEmp);
      leavesr;
    endif;
    SIRIO_close(myEmp);

  endsr;
end-proc;

//------------------------------------------------------------------------------------------


