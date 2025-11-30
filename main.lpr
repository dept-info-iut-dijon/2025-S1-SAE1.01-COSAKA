program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit,windows,Sound;

begin
  Randomize;
  EcranTitre();
    // Sons mécaniques/industriels
  readln();
  SonInteraction();
  MainMenu();
end.