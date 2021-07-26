--Call SQLJ.REMOVE_JAR('SIJRegex', 0)
--;
Set Current Schema $(LIBRARY)
;

Call SQLJ.INSTALL_JAR('file:$(ROOT_DIR)/$(DIR_JAVA)/SIJR.jar', 'SIJRegex', 0)
;

Create or Replace Function $(LIBRARY)/SIJR_matches
(
   in_pattern Varchar(512),
   in_string Varchar(1024)
)
Returns Integer
Language Java
Parameter Style Java
Specific $(LIBRARY)/SIJRM
Not Deterministic
No Sql
Called On Null Input
No External Action
Disallow Parallel
External Name 'SIJRegex:src.java.SIJR.matches'
Not Fenced
;
Label On Function $(LIBRARY)/SIJR_matches Is 'UDF: Regular Expresion match'
;
