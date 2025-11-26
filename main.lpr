program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit;

var
  zones:Array[0..2] of Zone;

begin 
   EcranTitre();
   readln();
   MainMenu();
   readln();
   Scenario();
end.