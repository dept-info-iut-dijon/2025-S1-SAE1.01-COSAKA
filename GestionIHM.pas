unit gestionIHM;

{$mode delphi}{$H+}

interface
procedure EcranTitre();
procedure MainMenu();

implementation


uses
  SysUtils, Classes,gestionEcran;


{Affichage du menu ECRAN TITRE}
procedure EcranTitre();
begin
    writeln('ECRANTITRE');
    dessinerCadreXY(5,5,10,10,simple,white,black); // c'est un test me tape pas stp
end;

{Affichage du menu principale}
procedure MainMenu();
begin

end;

end.