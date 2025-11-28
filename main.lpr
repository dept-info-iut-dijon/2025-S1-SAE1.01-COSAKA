program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit,windows;

begin
  Randomize;
  EcranTitre();
  readln();
  MainMenu();
end.