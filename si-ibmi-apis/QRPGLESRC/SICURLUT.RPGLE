**FREE
//******************************************************************************************
//
//
// Programname    : SICURLUT
// Programautor   : Sranko Informatik
// Created on     : 01.03.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt main(SICURLUT) dftactgrp(*no) actgrp(*new) bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

 /include qcpylesrc/sicurlp
 /include qcpylesrc/siulcp
 /include qcpylesrc/siqshp

//==========================================================================================
// Procedures
//==========================================================================================

 dcl-proc SICURLUT;
 dcl-pi SICURLUT;
 end-pi;
 dcl-s Credentials like(tSIULC);
 dcl-s StratoFtp like(tSICURL);
 dcl-s FileList like(tSICURL_List);
 dcl-s QShell like(tSIQSH);
 dcl-s File like(tSICURL_File);
 dcl-s FileKurz char(52);

 Credentials = SIULC_new('ftpx@sranko-informatik.de'
                        :'1Sranko-Informatik'
                        );

 QShell = SIQSH_init('sicurlut.stdin'
                    :'sicurlut.stdout'
                    :'sicurlut.stderr');

 StratoFtp = SICURL_new(QShell:Credentials:'ftp://ftp.strato.de');
 FileList = SICURL_listFiles(StratoFtp);
 dow SIITR_ForEach(FileList);
   SIITR_setValue(FileList:%addr(File));
   FileKurz = File;
   dsply FileKurz;
 enddo;

 SIQSH_close(QShell);

 return;
 end-proc;
