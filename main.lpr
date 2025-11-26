program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit;

begin 
  EcranTitre();
  readln();
  MainMenu();
  readln();
  Scenario();
  readln();
  AfficherJeu();
  readln();
end.