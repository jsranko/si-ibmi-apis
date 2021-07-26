Create or Replace Function $(LIBRARY)/SIRE_like
(
   in_pattern Varchar(512),
   in_string Varchar(1024)
)
Returns Char(1)
Language RPGLE
Parameter Style General
Statement Deterministic
Returns Null On Null Input
External Name '$(LIBRARY)/SIRE(SIRE_like)'
Program Type Sub
Not Fenced
;
Label On Function $(LIBRARY)/SIRE_like Is 'UDF: Search for a regular exp. patern in a string'
;
