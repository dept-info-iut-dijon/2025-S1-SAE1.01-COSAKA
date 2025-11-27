program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit,windows;

var
  choix:String;

begin 
  SetConsoleOutputCP(65001); // Pour les accents dans la console
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