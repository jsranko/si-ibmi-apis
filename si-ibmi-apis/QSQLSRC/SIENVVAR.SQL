Create or Replace Function $(LIBRARY)/SIENVVAR_get
(
   in_varName Varchar(128)
)
Returns Varchar(1024)
Language RPGLE
Parameter Style General
Returns Null On Null Input
External Name '$(LIBRARY)/SIENVVAR(SIENVVAR_get)'
Program Type Sub
Not Fenced
;
Label On Function $(LIBRARY)/SIENVVAR_get Is 'UDF: Get Enviroment Variable'
;

Create or Replace Function $(LIBRARY)/SIENVVAR_set
(
   in_varName Varchar(128),
   in_varValue Varchar(1024)
)
Returns Char(1)
Language RPGLE
Parameter Style General
Returns Null On Null Input
External Name '$(LIBRARY)/SIENVVAR(SIENVVAR_set)'
Program Type Sub
Not Fenced
;
Label On Function $(LIBRARY)/SIENVVAR_set Is 'UDF: Set/Create Enviroment Variable'
;
