program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit,windows;

var
  choix:String;

begin
  EcranTitre();
  readln();
  MainMenu();
end.