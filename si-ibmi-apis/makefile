LIBRARY:=$(shell jq '.library' -r ./config.json)
DBGVIEW=*SOURCE
STGMDL=*INHERIT
BUILDFILE=SIIIA.build
SHELL_CCSID:=$(shell jq '.pase_ccsid' -r ./config.json)
JOB_CCSID:=$(shell jq '.job_ccsid' -r ./config.json)
COMPILE_OUTPUT=*NONE


# Jetzt kann LIBLIST verwendet werden
SHELL=/QOpenSys/usr/bin/qsh

OBJECT_DESC='SI: IBM i Apis Framework'
MAKELOG=makefile.output
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SIIIA_CTLOPT=$(DIR_CPY)/SICTLOPT.RPGLE
DIR_CL=QCLLESRC
DIR_CMD=QCMDSRC
DIR_CPY=QCPYLESRC
DIR_RPG=QRPGLESRC
DIR_SQL=QSQLSRC
DIR_SRV=QSRVSRC
DIR_MSGF=QMSGFSRC
DIR_JAVA=src/java
DIR_SHELL=QSHSRC
DIR_IWSS=QIWSSSRC
DIR_C=QCSRC
EXT_MSGF=MSGF
EXT_CMD=CMD
EXT_CL=CLLE
EXT_SQL=SQL
EXT_JAVA=java
EXT_PGM=RPGLE
EXT_IWSS=iwss
EXT_IWSSCONF=iwssconf
EXT_UDF_JAVA=UDFJ
EXT_UDF_JAVA_OBJ=query_java
EXT_TABLE=TABLE

SIAPIS=\
	$(DIR_RPG)/SIUI.srvpgm \
	$(DIR_RPG)/SIXCP.srvpgm \
	$(DIR_RPG)/SIHASH.srvpgm \
	$(DIR_RPG)/SIOD.srvpgm \
	$(DIR_RPG)/SIITR.srvpgm \
	$(DIR_RPG)/SIJL.srvpgm \
	$(DIR_RPG)/SIDT.srvpgm \
	$(DIR_RPG)/SISQL.srvpgm \
	$(DIR_RPG)/SIULC.srvpgm \
	$(DIR_RPG)/SIPATH.srvpgm \
	$(DIR_RPG)/SIDBGA.srvpgm \
	$(DIR_RPG)/SIUUID.srvpgm \
	$(DIR_RPG)/SISTR.srvpgm \
	$(DIR_RPG)/SIQSH.srvpgm \
	$(DIR_RPG)/SIQSHLOG.srvpgm \
	$(DIR_RPG)/SICURL.srvpgm \
	$(DIR_RPG)/SIIMF.srvpgm \
	$(DIR_RPG)/SIIOF.srvpgm \
	$(DIR_RPG)/SINL.srvpgm \
	$(DIR_RPG)/SIISF.srvpgm \
	$(DIR_RPG)/SIDIR.srvpgm \
	$(DIR_RPG)/SIJI.srvpgm \
	$(DIR_RPG)/SICJ.srvpgm \
	# $(DIR_RPG)/SIMF.srvpgm \
	$(DIR_RPG)/SISRVPGM.srvpgm \
	$(DIR_RPG)/SIRE.srvpgm \
	$(DIR_RPG)/SIPFM.srvpgm \
	$(DIR_RPG)/SIEMAIL.srvpgm \
	$(DIR_RPG)/SIRIO.srvpgm \
	$(DIR_RPG)/SIENVVAR.srvpgm \
	$(DIR_RPG)/SISCLI.srvpgm

PGMS:=\
	$(patsubst %.RPGLE,%.pgm,$(shell grep -il " main" $(DIR_RPG)/*.RPGLE)) \
	$(patsubst %.SQLRPGLE,%.pgm,$(shell grep -il " main" $(DIR_RPG)/*.SQLRPGLE))

SRVPGMS_ALL:=\
	$(patsubst %.RPGLE,%.srvpgm,$(shell grep -il " NoMain" $(DIR_RPG)/*.RPGLE)) \
	$(patsubst %.SQLRPGLE,%.srvpgm,$(shell grep -il " NoMain" $(DIR_RPG)/*.SQLRPGLE))

SRVPGMS:=\
	$(filter-out $(SIAPIS), $(SRVPGMS_ALL))

MSGFS=\
	$(patsubst %.$(EXT_MSGF),%.messagefile,$(notdir $(wildcard $(DIR_MSGF)/*.$(EXT_MSGF))))

CMDS=\
	$(patsubst %.$(EXT_CMD),%.command,$(wildcard $(DIR_CMD)/*.$(EXT_CMD)))

EXITPGMS=\
	SIEPCSQ01.exitprogram

SQLS=\
	$(patsubst %.$(EXT_SQL),%.query,$(wildcard $(DIR_SQL)/*.$(EXT_SQL)))

TABLES=\
	$(patsubst %.$(EXT_TABLE),%.query,$(wildcard $(DIR_SQL)/*.$(EXT_TABLE)))

CLS:=\
	$(patsubst %.$(EXT_CL),%.clpgm,$(wildcard $(DIR_CL)/*.$(EXT_CL)))

SRCFILES_0=\
	$(DIR_CL) \
	$(DIR_CMD) \
	$(DIR_CPY) \
	$(DIR_RPG) \
	$(DIR_SQL) \
	$(DIR_SRV) \
	$(DIR_IWSS) \
	$(DIR_C) \
	$(DIR_MSGF)	

SRCFILES=\
	$(SRCFILES_0:=.srcpf)

CPYSRCS:=\
	$(patsubst %.rpgle,%.cpysrc,$(wildcard $(DIR_CPY)/*.rpgle)) 

CSRCS:=\
	$(patsubst %.c,%.cpyc,$(wildcard $(DIR_C)/*.c)) \

JAVAS=\
	$(patsubst %.$(EXT_JAVA),%.jar,$(wildcard $(DIR_JAVA)/*.$(EXT_JAVA)))

UDF_JAVA=\
	$(patsubst %.$(EXT_UDF_JAVA),%.query,$(wildcard $(DIR_SQL)/*.$(EXT_UDF_JAVA)))

IWSS=\
	$(patsubst %.$(EXT_IWSS),%.iwssconf,$(wildcard $(DIR_IWSS)/*.$(EXT_IWSS)))

IWSSCONF=\
	$(patsubst %.$(EXT_IWSSCONF),%.iwssdelete,$(wildcard $(DIR_IWSS)/*.$(EXT_IWSSCONF)))
	
# Ensure that intermediate files created by rules chains don't get
# automatically deleted
.PRECIOUS: %.srvpgm %.lib %.command %.messagefile %.pgm %.query %.srcpf %.clpgm %.jar %.module

all: build-core \
	 install-iwss \
	 build-java \
	 build-msgfs \
	 build-udf

build-core: $(LIBRARY).lib \
		create-srcfiles \
	    $(LIBRARY).bnddir \
	    build-exitprograms \
	    RPGINCDIR.envvar \
	    build-tables \
	    build-siapis \
	    build-srvpgms \
	    build-pgms \
	    build-cls \
	    build-commands \
	    copy-cpyfiles \
	    copy-cfiles

build-core-2: $(LIBRARY).lib \
		create-srcfiles \
	    $(LIBRARY).bnddir \
	    build-siapis \
	    build-srvpgms \
	    build-pgms \
	    build-cls \
	    build-commands \
	    copy-cpyfiles \
	    copy-cfiles

build-udf: build-sqls  \
	 build-udf-java

build-msgfs: $(MSGFS)

build-siapis: $(SIAPIS)

build-srvpgms: $(SRVPGMS)

build-commands: $(CMDS)

build-exitprograms: $(EXITPGMS)

build-sqls: $(SQLS)

build-tables: $(TABLES)

build-pgms: $(PGMS)

create-srcfiles: $(SRCFILES)

build-cls: $(CLS)

copy-cpyfiles: $(LIBRARY).lib \
           $(CPYSRCS)

copy-cfiles: $(LIBRARY).lib \
           $(CSRCS)

build-java: $(JAVAS)

build-udf-java: $(UDF_JAVA)

install-iwss: $(IWSS)

display-vars: 
	$(info    MSGFS is $(MSGFS)) 
	$(info    SIAPIS is $(SIAPIS)) 
	$(info    SRVPGMS is $(SRVPGMS)) 
	$(info    CMDS is $(CMDS)) 
	$(info    EXITPGMS is $(EXITPGMS)) 
	$(info    SQLS is $(SQLS)) 
	$(info    PGMS is $(PGMS))
	$(info    SRCFILES is $(SRCFILES)) 
	$(info    CLS is $(CLS)) 
	$(info    CPYSRCS is $(CPYSRCS)) 
	$(info    JAVAS is $(JAVAS)) 
	$(info    UDF_JAVA is $(UDF_JAVA)) 
	$(info    IWSS is $(IWSS)) 
	$(info    IWSSCONF is $(IWSSCONF))
	$(info    Library is $(LIBRARY))
	$(info    C-Sources is $(CSRCS))
	$(info    Tables is $(TABLES))
	
setup:
	bash ./$(DIR_SHELL)/setup.sh && \
	echo "Setup wurde erfolgreich durchgef??."

update:
	$(shell git pull) && \
	build

update-cpyfiles: clean-cpyfiles \
	copy-cpyfiles

%.envvar: 
	system -Kp "ADDENVVAR ENVVAR(RPGINCDIR) VALUE('$(ROOT_DIR)') CCSID(*JOB) LEVEL(*SYS) REPLACE(*YES)" && \
	touch $@

%.srvpgm: %.module
	$(call copy_to_srcpf,$(ROOT_DIR)/$(DIR_SRV)/$(notdir $*).BND,$(LIBRARY),$(DIR_SRV),$(notdir $*))
	liblist -a $(LIBRARY);\
	system -Kp "CRTSRVPGM SRVPGM($(LIBRARY)/$(notdir $*)) MODULE($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$(DIR_SRV)/$(notdir $*).BND') ACTGRP(*CALLER) OPTION(*DUPPROC) STGMDL($(STGMDL))" && \
	system -Kp "ADDBNDDIRE BNDDIR($(LIBRARY)/$(LIBRARY)) OBJ(($(LIBRARY)/$(notdir $*) *SRVPGM *IMMED))" && \
	touch $@ 
	system -Kp "DLTMOD MODULE($(LIBRARY)/$(notdir $*))"

%.lib: 
	(system -Kp "CHKOBJ $* *LIB" || system -Kp "CRTLIB $* TEXT($(OBJECT_DESC))") && \
	touch $@
	touch $(SIIIA_CTLOPT) && \
	printf "**FREE\n\n/if not defined(SICTLOPTP)\n  /define SICTLOPTP\n/else\n  /eof\n/endif\n\nctl-opt bnddir('$(LIBRARY)/SIIIA');" > $(SIIIA_CTLOPT)
	
%.module: %.RPGLE
	# @echo "$$@=$@ $$%=$% $$<=$< $$?=$? $$^=$^ $$+=$+ $$|=$| $$*=$*"
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.module,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	liblist -a $(LIBRARY);\
	system -Kp "CRTRPGMOD MODULE($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$@') DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') STGMDL($(STGMDL)) TGTCCSID(*JOB) OUTPUT($(COMPILE_OUTPUT))"	 || rm $@
	
%.module: %.SQLRPGLE
	# @echo "$$@=$@ $$%=$% $$<=$< $$?=$? $$^=$^ $$+=$+ $$|=$| $$*=$*"
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.module,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	liblist -a $(LIBRARY);\
	system -Kp "CRTSQLRPGI OBJ($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$@') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) DBGVIEW($(DBGVIEW)) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') OUTPUT($(COMPILE_OUTPUT)) TGTCCSID(*JOB) STGMDL($(STGMDL))')" || rm $@
	
%.bnddir: $(LIBRARY).lib 
	(system -Kp "CHKOBJ OBJ($(LIBRARY)/$*) OBJTYPE(*BNDDIR)" || system -iKp "CRTBNDDIR BNDDIR($(LIBRARY)/$*) TEXT($(OBJECT_DESC))") && touch $@	
	
%.pgm: %.SQLRPGLE
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.pgm,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	liblist -a $(LIBRARY);\
	system "CRTSQLRPGI OBJ($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$@') OBJTYPE(*PGM) DBGVIEW($(DBGVIEW)) RPGPPOPT(*LVL2) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') TGTCCSID(*JOB) DFTACTGRP(*NO) ACTGRP(*NEW) OUTPUT($(COMPILE_OUTPUT))')" || rm $@

%.pgm: %.RPGLE
	# @echo "$$@=$@ $$%=$% $$<=$< $$?=$? $$^=$^ $$+=$+ $$|=$| $$*=$*"
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.pgm,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	liblist -a $(LIBRARY);\
	system -Kp "CRTBNDRPG PGM($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$@') DFTACTGRP(*NO) ACTGRP(*NEW) DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') TGTCCSID(*JOB) OUTPUT($(COMPILE_OUTPUT))" || rm $@
		
%.messagefile: $(DIR_MSGF)/%.$(EXT_MSGF)
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.messagefile,$(LIBRARY),$(DIR_MSGF),$*)
	liblist -a $(LIBRARY);\
	system -Kp "$(LIBRARY)/SICRTMSGF SRCSTMF('$(ROOT_DIR)/$<')" 
	
%.command: %.$(EXT_CMD)
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.command,$(LIBRARY),$(DIR_CMD),$(notdir $*))
	liblist -a $(LIBRARY);\
	system -Kp "CRTCMD CMD($(LIBRARY)/$(notdir $*)) PGM($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') REPLACE(*YES)" || rm $@
	
%.exitprogram: $(DIR_RPG)/%.pgm
	# system -Kp "ADDEXITPGM EXITPNT(QIBM_QCA_RTV_COMMAND) FORMAT(RTVC0100) PGMNBR(19820622) PGM($(LIBRARY)/$*) PGMDTA(*JOB 30 'CRTSQLRPGIQSYS      *BEFORE   ') REPLACE(*YES)" && \
	touch $@

%.query: %.$(EXT_UDF_JAVA)
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.query,$(LIBRARY),$(DIR_SQL),$(notdir $*)) && \
	liblist -a $(LIBRARY);\
	system -iKp "CHGJOB CCSID($(JOB_CCSID))";\
	system -iKp "RUNSQLSTM SRCSTMF('$(ROOT_DIR)/$@') COMMIT(*NONE)" || rm $@ 

%.query: %.$(EXT_TABLE)
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.query,$(LIBRARY),$(DIR_SQL),$(notdir $*)) && \
	liblist -a $(LIBRARY);\
	system -iKp "CHGJOB CCSID($(JOB_CCSID))";\
	system -iKp "RUNSQLSTM SRCSTMF('$(ROOT_DIR)/$@') COMMIT(*NONE)" || rm $@ 
	
%.query: %.$(EXT_SQL) 
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.query,$(LIBRARY),$(DIR_SQL),$(notdir $*)) && \
	liblist -a $(LIBRARY);\
	system -iKp "CHGJOB CCSID($(JOB_CCSID))";\
	system -iKp "RUNSQLSTM SRCSTMF('$(ROOT_DIR)/$@') COMMIT(*NONE)"	|| rm $@ 

%.srcpf: $(LIBRARY).lib
	system -Kp "CRTSRCPF FILE($(LIBRARY)/$*) RCDLEN(240) MBR(*NONE) TEXT('just for read-only')" && \
	touch $@
	
%.clpgm: %.$(EXT_CL)
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.clpgm,$(LIBRARY),$(DIR_CL),$(notdir $*))
	liblist -a $(LIBRARY);\
	system -kp "CRTBNDCL PGM($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') DFTACTGRP(*NO) ACTGRP(*STGMDL) STGMDL(*SNGLVL) OUTPUT($(COMPILE_OUTPUT)) REPLACE(*YES) DBGVIEW($(DBGVIEW))" || rm $@    

%.cpysrc: %.rpgle $(DIR_CPY).srcpf
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.cpysrc,$(LIBRARY),$(DIR_CPY),$(notdir $*)) && \
	touch $@

%.cpyc: %.c $(DIR_C).srcpf
	$(call substitute,$<,$@) && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.cpyc,$(LIBRARY),$(DIR_C),$(notdir $*))

%.jar: %.$(EXT_JAVA)
	javac $< && \
	jar -cvf $*.jar $*.class && \
	rm $*.class

%.shell: %.$(EXT_SHELL)
	# @echo "$$@=$@ $$%=$% $$<=$< $$?=$? $$^=$^ $$+=$+ $$|=$| $$*=$*"
	bash ./$< && touch $@	

%.iwssconf: %.$(EXT_IWSS)
	# @echo "$$@=$@ $$%=$% $$<=$< $$?=$? $$^=$^ $$+=$+ $$|=$| $$*=$*"
	$(call substitute,$<,$@) && \
	bash ./$(DIR_SHELL)/iws_install.sh ./$@ && \
	$(call copy_to_srcpf,$(ROOT_DIR)/$@,$(LIBRARY),$(DIR_IWSS),$(notdir $*))

%.$(EXT_UDF_JAVA_OBJ): %.$(EXT_UDF_JAVA)
	$(call substitute,$<,$@)
	system -iKp "RUNSQLSTM SRCSTMF('$(ROOT_DIR)/$@') COMMIT(*NONE)"	|| \
	-rm $@

clean-lib:
	rm -f $(LIBRARY).lib &&\
	system -Kp 'DLTLIB $(LIBRARY)' || :	

clean-srcfiles:
	rm -f *.srcpf

clean-cpyfiles:
	rm -f $(DIR_CPY).srcpf
	rm -f $(DIR_CPY)/*.cpysrc 
	system -Kp 'DLTF FILE($(LIBRARY)/$(DIR_CPY))'

clean-bnddir:
	rm -f *.bnddir

clean-exitprograms:
	rm -f *.exitprogram

clean-envvar:
	rm -f *.envvar

clean-srvpgms:
	rm -f $(DIR_RPG)/*.srvpgm \
	      $(DIR_RPG)/*.module

clean-pgms:
	rm -f $(DIR_RPG)/*.pgm

clean-cls:
	rm -f $(DIR_CL)/*.clpgm

clean-commands:
	rm -f $(DIR_CMD)/*.command

clean-java:
	rm -f *.jar

clean-msgfs:
	rm -f $(DIR_MSGF)/*.messagefile

clean-cpysrc:
	rm -f $(DIR_CPY)/*.cpysrc

clean-sqls:
	rm -f $(DIR_SQL)/*.query
 
clean-iwss: $(IWSSCONF)
	
%.iwssdelete: %.$(EXT_IWSSCONF)
	-bash ./$(DIR_SHELL)/iws_remove.sh ./$<
	rm ./$<

clean: clean-cpysrc \
		clean-msgfs \
		clean-sqls \
		clean-java \
		clean-commands \
		clean-cls \
		clean-pgms \
		clean-srvpgms \
		clean-envvar \
		clean-exitprograms \
		clean-bnddir \
		clean-srcfiles \
		clean-cpyfiles \
		clean-iwss \
		clean-lib
		

define copy_to_srcpf
	system -Kp "CPYFRMSTMF FROMSTMF('$(subst _,,$(1))') TOMBR('/QSYS.LIB/$(2).LIB/$(3).FILE/$(subst _,,$(4)).MBR') MBROPT(*REPLACE) STMFCCSID(*STMF) DBFCCSID(*FILE) ENDLINFMT(*ALL)" && \
	system -Kp "CHGPFM FILE($(2)/$(3)) MBR($(subst _,,$(4))) SRCTYPE($(subst .,,$(suffix $(1)))) TEXT('just for read-only')"
endef	

define log_and_run	
	$(if ifeq "$(build)" "yes", $(call log,$(1)), $(call run,$(1)))	
endef

define run	
	(set -x; $(1))
endef

define log	
	(set -x; $(1)) >>$(BUILDFILE) 2>&1
endef

define setJobCCSID
	(system -Kp "QSYS/DSPSYSVAL SYSVAL(QCCSID)" | grep -i 65535 1>&2) || system -Kp "QSYS/CHGJOB CCSID($(JOB_CCSID))"
endef

define substitute
	-rm $(subst _,,$(2))
	export QIBM_CCSID=$(SHELL_CCSID) && touch $(subst _,,$(2)) && \
	sed 's/$$(LIBRARY)/$(LIBRARY)/g; s/$$(ROOT_DIR)/$(subst /,\/,$(ROOT_DIR))/g; s/$$(DIR_JAVA)/$(subst /,\/,$(DIR_JAVA))/g' $(1) >> $(subst _,,$(2))
endef
