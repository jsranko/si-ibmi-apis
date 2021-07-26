Create or Replace Function $(LIBRARY)/SIPFM_ListData
(
   in_Libraryname Varchar(10),
   in_Filename Varchar(10),
   in_Membername Varchar(10)
)
Returns Table(
   RecordData Varchar(4000)
)
Language RPGLE
Parameter Style Sql
Specific $(LIBRARY)/SIPFMLRS
Statement Deterministic
Returns Null On Null Input
External Name '$(LIBRARY)/SIPFMLR'
Program Type Main
Not Fenced
;
Label On Function $(LIBRARY)/SIPFM_ListData Is 'UDF: List Member Data'
;
