Create or Replace Function $(LIBRARY)/SI_VIEW_DEPENDENCIES(File Varchar(10), 
                                                           Library Varchar(10))
Returns Table (Level Integer, 
               File Varchar(10),
               Library Varchar(10))
Language Sql
Specific $(LIBRARY)/SIVWDEPS
Not Deterministic
No External Action
Returns Null On Null Input
Set Option Dbgview = *Source
Begin Atomic

Return 
With base As (
          Select dbffil , dbflib , dbffdp , dbfldp , dbftdp
            From qadbfdep 
        Group By dbffil , dbflib , dbffdp , dbfldp , dbftdp
), Dependents (calllevel, dbffil, dbflib, dbffdp, dbfldp) As (
          Select 1 As calllevel , dbffil , dbflib , dbffdp , dbfldp 
            From base 
           Where dbffil = File And dbflib = Library 
           Union All 
          Select calllevel + 1 As calllevel, b.dbffil, b.dbflib, b.dbffdp, b.dbfldp 
            From Dependents a 
            Join base b 
              On (a.dbffdp, a.dbfldp) = (b.dbffil, b.dbflib) 
), dependencies As (
          Select calllevel, dbffdp, dbfldp 
            From Dependents
        Group By calllevel, dbffdp, dbfldp 
)
          Select *
            From dependencies 
        Order By calllevel, dbffdp Asc
;
End
;
