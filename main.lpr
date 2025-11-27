program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit,windows;

var
  choix:String;

begin 
  EcranTitre();
  readln();
  choix:=MainMenu();
  if choix <>'0' then
    begin
    Scenario();
    readln();
    AfficherJeu();
    AfficherEmplacements(ZoneTest);
    readln();
    end
  else;
end.