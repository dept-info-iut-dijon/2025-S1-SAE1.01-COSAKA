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
    dessinerCadreXY(5,5,195,35,simple,white,black); // c'est un test me tape pas stp
    writeln('JAJAOFIEKJIOF');
end;

{Affichage du menu principale}
procedure MainMenu();
begin

end;

end.