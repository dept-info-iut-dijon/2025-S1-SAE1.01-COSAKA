unit Sound;

{$mode objfpc}{$H+}

interface
procedure StartSound();
procedure SonErreur();
procedure SonBilan();
procedure SonInteraction();



implementation


uses
  SysUtils, Classes,windows;
  
  
procedure StartSound();
begin
  {Beep(200, 80);   // Son grave mécanique
  Beep(250, 80);   
  Beep(200, 80);   
  Beep(300, 120);  // Montée
  
  Beep(400, 60);   // Sons rapides type machine
  Beep(450, 60);
  Beep(500, 60);
  
  Beep(350, 150);  // Son de validation
  Beep(400, 150);
  Beep(450, 200);  // Fin satisfaisante}
end;

procedure SonErreur();
begin
  {Beep(400, 200);  // Son grave
  Beep(300, 300);  // Descente
  Beep(200, 400);  // Encore plus grave et long}
end;

procedure SonBilan();
begin
{  Beep(659, 150);  // Mi
  Beep(784, 150);  // Sol
  Beep(880, 150);  // La
  Beep(1047, 400); // Do aigu final}
end;

procedure SonInteraction();
begin
  {Beep(250, 60); } // Son grave et très court
end;

end.