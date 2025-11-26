unit gestionIHM;

{$mode delphi}{$H+}

interface
procedure EcranTitre();
procedure MainMenu();
procedure Scenario();

implementation


uses
  SysUtils, Classes,gestionEcran,constantUnit;


{Affichage du menu ECRAN TITRE}
procedure EcranTitre();
const 
  B = 35;
begin
  dessinerCadreXY(5,2,153,38,double,white,black); // TAILLE DE BASE

  // ART ASCII
  deplacerCurseurXY(23,10);
  writeln('  /$$$$$$              /$$     /$$            /$$$$$$                      /$$   /$$ /$$$$$$ /$$   /$$ /$$$$$$$$      ');
  deplacerCurseurXY(23,11);
  writeln(' /$$__  $$            | $$    |__/           /$$__  $$                    | $$  | $/|_  $$_/| $$  | $$|__  $$__/      ');
  deplacerCurseurXY(23,12);
  writeln('| $$  \__/  /$$$$$$  /$$$$$$   /$$  /$$$$$$$| $$  \__//$$$$$$   /$$$$$$$ /$$$$$$|_/   | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY(23,13);
  writeln('|  $$$$$$  |____  $$|_  $$_/  | $$ /$$_____/| $$$$   |____  $$ /$$_____/|_  $$_/      | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY(23,14);
  writeln(' \____  $$  /$$$$$$$  | $$    | $$|  $$$$$$ | $$_/    /$$$$$$$| $$        | $$        | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY(23,15);
  writeln(' /$$  \ $$ /$$__  $$  | $$ /$$| $$ \____  $$| $$     /$$__  $$| $$        | $$ /$$    | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY(23,16);
  writeln('|  $$$$$$/|  $$$$$$$  |  $$$$/| $$ /$$$$$$$/| $$    |  $$$$$$$|  $$$$$$$  |  $$$$/   /$$$$$$|  $$$$$$/   | $$         ');
  deplacerCurseurXY(23,17);
  writeln(' \______/  \_______/   \___/  |__/|_______/ |__/     \_______/ \_______/   \___/    |______/ \______/    |__/    ');

  couleurTexte(Yellow);
  deplacerCurseurXY(B,19);
  writeln(' /$$                        /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$ ');
  deplacerCurseurXY(B,20);
  writeln('| $$                       /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$| $$  /$$/ /$$__  $$');
  deplacerCurseurXY(B,21);
  writeln('| $$$$$$$  /$$   /$$      | $$  \__/| $$  \ $$| $$  \__/| $$  \ $$| $$ /$$/ | $$  \ $$');
  deplacerCurseurXY(B,22);
  writeln('| $$__  $$| $$  | $$      | $$      | $$  | $$|  $$$$$$ | $$$$$$$$| $$$$$/  | $$$$$$$$');
  deplacerCurseurXY(B,23);
  writeln('| $$  \ $$| $$  | $$      | $$      | $$  | $$ \____  $$| $$__  $$| $$  $$  | $$__  $$');
  deplacerCurseurXY(B,24);
  writeln('| $$  | $$| $$  | $$      | $$    $$| $$  | $$ /$$  \ $$| $$  | $$| $$\  $$ | $$  | $$');
  deplacerCurseurXY(B,25);
  writeln('| $$$$$$$/|  $$$$$$$      |  $$$$$$/|  $$$$$$/|  $$$$$$/| $$  | $$| $$ \  $$| $$  | $$');
  deplacerCurseurXY(B,26);
  writeln('|_______/  \____  $$       \______/  \______/  \______/ |__/  |__/|__/  \__/|__/  |__/');
  deplacerCurseurXY(B,27);
  writeln('           /$$  | $$                                                                  ');
  deplacerCurseurXY(B,28);
  writeln('          |  $$$$$$/                                                                  ');
  deplacerCurseurXY(B,29);
  writeln('           \______/                                                                   ');

  couleurTexte(White);
  deplacerCurseurXY(58,28);
  writeln('DUPUIS Gabin | NAVELOT-GENET Anatole | SUCCAR Eric | WAGNER Tom');

  deplacerCurseurXY(63,35);
  writeln('Appuyez sur ENTRER pour commencer');
end;

{Affichage du menu principale}
procedure MainMenu();
begin
  dessinerCadreXY(5,2,153,38,double,white,black); // TAILLE DE BASE

    // ART ASCII
  deplacerCurseurXY(56,10);
  writeln(' /$$      /$$ /$$$$$$$$ /$$   /$$ /$$   /$$');
  deplacerCurseurXY(56,11);
  writeln('| $$$    /$$$| $$_____/| $$$ | $$| $$  | $$');
  deplacerCurseurXY(56,12);
  writeln('| $$$$  /$$$$| $$      | $$$$| $$| $$  | $$');
  deplacerCurseurXY(56,13);
  writeln('| $$ $$/$$ $$| $$$$$   | $$ $$ $$| $$  | $$');
  deplacerCurseurXY(56,14);
  writeln('| $$  $$$| $$| $$__/   | $$  $$$$| $$  | $$');
  deplacerCurseurXY(56,15);
  writeln('| $$\  $ | $$| $$      | $$\  $$$| $$  | $$');
  deplacerCurseurXY(56,16);
  writeln('| $$ \/  | $$| $$$$$$$$| $$ \  $$|  $$$$$$/');
  deplacerCurseurXY(56,17);
  writeln('|__/     |__/|________/|__/  \__/ \______/ ');

  deplacerCurseurXY(70,25);
  writeln('[1] Commencer');

  deplacerCurseurXY(70,28);
  writeln('[2] Quitter');

end;

procedure Scenario();
begin
  
end;

end.