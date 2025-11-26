program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM;
begin 
   EcranTitre();
   readln();
   MainMenu();
   readln();
   Scenario();
end.