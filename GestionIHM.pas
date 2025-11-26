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
  effacerEcran();
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
  effacerEcran();
  dessinerCadreXY(5,2,153,38,double,white,black); // TAILLE DE BASE

  // SCENARIO - - - 
  deplacerCurseurXY(20,10);
  writeln('Dans une réalité. Pas si alternative que ça.');
  deplacerCurseurXY(20,11);
  writeln('2024 : une année particulièrement compliquée. ');
  deplacerCurseurXY(20,12);
  writeln('Suite à un mouvement de grève encore jamais vu (les Gilets Verts) pas moins de douze gouvernements');
  deplacerCurseurXY(20,13);
  writeln('se sont succédé entre janvier et mars. Oui, douze. En trois mois');
  deplacerCurseurXY(20,14);
  writeln('L instabilité économique provoquée par ces changements politiques incessants a plongé le pays dans');
  deplacerCurseurXY(20,15);
  writeln('une ère de chaos. Et ce qui devait arriver... arriva. Privée de toute subvention de l État, la direc-');
  deplacerCurseurXY(20,16);
  writeln('-tion de l IUT de Dijon a dû se rendre à l évidence : à défaut d avoir un budget, il allait falloir');
  deplacerCurseurXY(20,17);
  writeln('utiliser la seule ressource encore abondante et peu coûteuse... vous, les étudiant(e)s.');
  deplacerCurseurXY(20,18);
  writeln('Le 30 avril 2024, la direction dévoile alors une stratégie de redressement financier pour le moins');
  deplacerCurseurXY(20,19);
  writeln('novatrice : Envoyer les étudiant(e)s coloniser d autres planètes et y construire des usines de pro');
  deplacerCurseurXY(20,20);
  writeln('production automatisées. Un moyen simple (et étonnamment peu onéreux) d obtenir rapidement les ressour');
  deplacerCurseurXY(20,21);
  writeln('ces nécessaires à la survie de l établissement.');
  deplacerCurseurXY(20,22);
  writeln('C est ainsi que, le 15 septembre 2024, vous embarquez pour un voyage à destination de Mars, à bord');
  deplacerCurseurXY(20,23);
  writeln('d une fusée baptisée "Maëlle", fièrement assemblée lors d une SAE du département GMP. Avec pour');
  deplacerCurseurXY(20,24);
  writeln('seul(e)s compagnons la Lune, le ciel, et une check-list de sécurité rédigée par Franck Deher,');
  deplacerCurseurXY(20,25);
  writeln('vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.');
  deplacerCurseurXY(20,28);
  attendre(10000);
  couleurTexte(Yellow);
  write('Maintenant, il est temps de vous mettre au travail. L IUT a besoin de vous !');
  
  deplacerCurseurXY(63,35);
  attendre(1000);
  couleurTexte(white);
  writeln('Appuyez sur ENTRER pour continuer');
  readln()
end;

end.