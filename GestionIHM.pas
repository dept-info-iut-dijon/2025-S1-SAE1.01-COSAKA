unit gestionIHM;

{$mode delphi}{$H+}

interface
procedure EcranTitre();
procedure MainMenu();

implementation


uses
  SysUtils, Classes,gestionEcran,constantUnit;


{Affichage du menu ECRAN TITRE}
procedure EcranTitre();
begin
    writeln('ECRANTITRE');
    dessinerCadreXY(10,5,180,30,simple,white,black); // c'est un test me tape pas stp
end;

{Affichage du menu principale}
procedure MainMenu();
begin

end;

end.