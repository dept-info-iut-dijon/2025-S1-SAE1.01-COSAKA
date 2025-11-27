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
  if choix<>'2' then
    begin
    Scenario();
    readln();
    AfficherJeu();
    readln();
    end
  else;
end.