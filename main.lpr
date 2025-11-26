program main;
{$mode objfpc}{$H+}
uses
  classes,sysutils,constantunit,gestionIHM,LogiqueUnit;

<<<<<<< HEAD
=======
var
  zones:Array[0..2] of Zone;
  msg:string;

>>>>>>> 3c1b320f3eaf42c03061c0f20e78491164d7d4bb
begin 

EcranTitre();
   readln();
   MainMenu();
   readln();
   Scenario();
end.