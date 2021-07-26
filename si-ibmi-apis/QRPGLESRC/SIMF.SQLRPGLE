**FREE

//******************************************************************************************
//
//
// Programname    : SIMF
// Programautor   : Sranko Informatik
// Created on     : 20.01.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt NoMain;

 /include qcpylesrc/sictlopt

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

/define SIMF
/include qcpylesrc/simfp

/include qcpylesrc/systemp

exec sql set option commit = *chg;

//==========================================================================================
// Procedures
//==========================================================================================

 dcl-proc SIMF_new export;
 dcl-pi SIMF_new like(tSIMF) extproc(*dclcase);
   File like(tSIMF_File) const;
   Library like(tSIMF_Library) const;
   Description likeds(tSIMF_Description) options(*nopass);
 end-pi;
 dcl-ds dsSIMF likeds(tSIMF_Def) inz;

   if %parms >= %parmnum(Description);
     dsSIMF.Description = Description;
   endif;
   dsSIMF.File = File;
   dsSIMF.Library = Library;

   return dsSIMF;

 end-proc;

//------------------------------------------------------------------------------------------

 dcl-proc SIMF_createFromFile export;
 dcl-pi SIMF_createFromFile like(tSIMF) extproc(*dclcase);
   SIMF like(tSIMF);
   Streamfile like(tSIMF_Streamfile) const;
 end-pi;
 dcl-ds dsSIMF likeds(tSIMF_Def) based(pSIMF);

   pSIMF = %addr(SIMF);
   dsSIMF.Streamfile = Streamfile;

   monitor;
     dsSIMF.Description = getDescription(Streamfile);
   on-error;
   endmon;

   monitor;
     createMessageFile(dsSIMF);
   on-error;
   endmon;

   return dsSIMF;

 end-proc;

//------------------------------------------------------------------------------------------
// getDescription
//------------------------------------------------------------------------------------------

dcl-proc getDescription;
dcl-pi getDescription like(tSIMF_Description);
  Streamfile like(tSIMF_Streamfile) value;
end-pi;
dcl-ds Desc likeds(tSIMF_Description);

  exec sql select *
             Into :Desc
             from json_table(GET_CLOB_FROM_FILE(Trim(:streamfile)) Format JSON,
                            'lax $'
                            Columns ("text" Char(50),
                                     "initialStorageSize" Integer Path 'lax $.size.initialStorageSize',
                                     "incrementStorageSize" Integer Path 'lax $.size.incrementStorageSize',
                                     "maximumIncrements" Char(6) Path 'lax $.size.maximumIncrements',
                                     "aut" Char(10),
                                     "ccsid" Char(11)
                            ) Error On Error
                  ) as jsontbl
  ;
  if sqlcode < *zeros;
    dsply ('canot read msgf head.');
  endif;

  return Desc;
end-proc;

//------------------------------------------------------------------------------------------
// createMessageFile
//------------------------------------------------------------------------------------------

dcl-proc createMessageFile;
dcl-pi createMessageFile;
  dsSIMF likeds(tSIMF_Def);
end-pi;
dcl-s Command varchar(256);

   Command = 'CRTMSGF MSGF(' + %trim(dsSIMF.Library) + '/' + %trim(dsSIMF.File) + ') ' +
                     'TEXT(' + %trim(dsSIMF.Description.text) + ') ' +
                     'SIZE(' + %char(dsSIMF.Description.sizeInitialStorageSize) + ' ' +
                               %char(dsSIMF.Description.sizeIncrementStorageSize) + ' ' +
                               %trim(dsSIMF.Description.sizeMaximumIncrements) + ') ' +
                     'AUT(' + %trim(dsSIMF.Description.aut) + ') ' +
                     'CCSID(' + %trim(dsSIMF.Description.ccsid) + ')';
   if system(Command) <> cSystem_Return_Succesful;
   endif;

  return;
end-proc;

//------------------------------------------------------------------------------------------

 dcl-proc SIMF_addMessagesFromFile export;
 dcl-pi SIMF_addMessagesFromFile like(tSIMF) extproc(*dclcase);
   SIMF like(tSIMF);
   Streamfile like(tSIMF_Streamfile) const;
 end-pi;
 dcl-ds dsSIMF likeds(tSIMF_Def) based(pSIMF);
 dcl-ds Message likeds(tSIMF_Message);
 dcl-s Messages like(tSIMF_List);

   pSIMF = %addr(SIMF);
   dsSIMF.Streamfile = Streamfile;

   monitor;
     Messages = listMessages(Streamfile);
   on-error;
   endmon;

   dow SIITR_ForEach(Messages);
     SIITR_setValue(Messages:%addr(Message));

     monitor;
       addMessageDesc(dsSIMF:Message);
     on-error;
     endmon;

   enddo;

   return dsSIMF;

 end-proc;


//------------------------------------------------------------------------------------------
// listMessages
//------------------------------------------------------------------------------------------

dcl-proc listMessages;
dcl-pi listMessages like(tSIMF_List);
  Streamfile like(tSIMF_Streamfile) value;
end-pi;
dcl-ds Message likeds(tSIMF_Message);
dcl-s Liste like(tSIMF_List);
dcl-s aNull int(5) dim(50);

  exec sql declare crsListMessages cursor for
           select *
             from json_table(GET_CLOB_FROM_FILE(Trim(:streamfile)) Format JSON,
                            'lax $.messages'
                            Columns ("msgid" Char(7),
                                     "msg" Varchar(132),
                                     "seclvl" Varchar(3000),
                                     "sev" Integer,
                                     "fmtDataType" Char(8) Path 'lax $.fmt.dataType',
                                     "fmtLength" Integer Path 'lax $.fmt.length',
                                     "fmtDecimalPositions" Integer Path 'lax $.fmt.decimalPositions',
                                     "type" Char(7),
                                     "lenLength" Char(8) Path 'lax $.len.length',
                                     "lenDecimalPositions" Integer Path 'lax $.len.decimalPositions',
                                     "values" Varchar(33),
                                     "spcvalOriginalFromValue" Varchar(33) Path 'lax $.spcval.originalFromValue',
                                     "spcvalReplacementToValue" Varchar(33) Path 'lax $.spcval.replacementToValue',
                                     "rangeLowerValue" Varchar(33) Path 'lax $.range.lowerValue',
                                     "rangeUpperValue" Varchar(33) Path 'lax $.range.upperValue',
                                     "relRelationOperator" Varchar(5) Path 'lax $.rel.relationOperator',
                                     "relValue" Varchar(33) Path 'lax $.rel.value',
                                     "dft" Varchar(132),
                                     "dftpgmObject" Varchar(10) Path 'lax $.dftpgm.object',
                                     "dftpgmLibrary" Varchar(10) Path 'lax $.dftpgm.library',
                                     "dmplst" Char(7),
                                     "alroptAlertArt" Char(9) Path 'lax $.alropt.alertType',
                                     "alroptressourceNameVariable" Char(6) Path 'lax $.alropt.ressourceNameVariable',
                                     "logprb" Char(4),
                                     "ccsid" Char(11)
                            ) Error On Error
                  ) as jsontbl
  ;
  exec sql open crsListMessages;
  dow not %shtdn();
    exec sql fetch crsListMessages into :Message :aNull;
    if sqlcode < *zeros;
      leave;
    endif;
    if sqlcode = 100;
      exec sql close crsListMessages;
      leave;
    endif;

    SIITR_addEntry(Liste:%addr(Message):%size(Message));
  enddo;

  return Liste;
end-proc;


//------------------------------------------------------------------------------------------
// addMessageDesc
//------------------------------------------------------------------------------------------

dcl-proc addMessageDesc;
dcl-pi addMessageDesc;
  dsSIMF likeds(tSIMF_Def);
  Message likeds(tSIMF_Message);
end-pi;
dcl-s Command varchar(256);

   Command = 'ADDMSGD MSGID(' + Message.msgid + ') ' +
                     'MSGF(' + %trim(dsSIMF.Library) + '/' + %trim(dsSIMF.File) + ') ' +
                     'MSG(' + %trim(dsSIMF.Description.text) + ') ' +
                     'SECLVL(' + %trim(dsSIMF.Description.sizeMaximumIncrements) + ') ' +
                     'SEV(' + %trim(dsSIMF.Description.aut) + ') ' +
                     'xxx(' + %trim(dsSIMF.Description.ccsid) + ')';
   if system(Command) <> cSystem_Return_Succesful;
   endif;

  return;
end-proc;
