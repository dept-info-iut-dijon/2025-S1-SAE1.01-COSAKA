program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit;

var
  msg:string;

begin 
  EcranTitre();
  readln();
  MainMenu();
  readln();
  Scenario();
  AfficherJeu();
  readln();
end.