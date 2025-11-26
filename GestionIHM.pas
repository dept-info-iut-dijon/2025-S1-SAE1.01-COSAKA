unit gestionIHM;

{$mode delphi}{$H+}

interface
procedure EcranTitre();
procedure MainMenu();
procedure Scenario();
procedure AfficherMessage(var msg:string);

implementation


uses
  SysUtils, Classes,gestionEcran,constantUnit;

procedure CadrePrincipale();
begin
  dessinerCadreXY(2,1,(SCREEN_WIDTH-1),(SCREEN_HEIGHT-2),double,white,black); // TAILLE DE BASE
end;


{Affichage de l'Ecran Titre}
procedure EcranTitre();
const 
  B = 35;
begin
  CadrePrincipale();
  // ART ASCII SATISFACT'IUT BY COSAKA | NAMES
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('  /$$$$$$              /$$     /$$            /$$$$$$                      /$$   /$$ /$$$$$$ /$$   /$$ /$$$$$$$$      ')div 2),10);
  writeln('  /$$$$$$              /$$     /$$            /$$$$$$                      /$$   /$$ /$$$$$$ /$$   /$$ /$$$$$$$$      ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(' /$$__  $$            | $$    |__/           /$$__  $$                    | $$  | $/|_  $$_/| $$  | $$|__  $$__/      ')div 2),11);
  writeln(' /$$__  $$            | $$    |__/           /$$__  $$                    | $$  | $/|_  $$_/| $$  | $$|__  $$__/      ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$  \__/  /$$$$$$  /$$$$$$   /$$  /$$$$$$$| $$  \__//$$$$$$   /$$$$$$$ /$$$$$$|_/   | $$  | $$  | $$   | $$         ')div 2),12);
  writeln('| $$  \__/  /$$$$$$  /$$$$$$   /$$  /$$$$$$$| $$  \__//$$$$$$   /$$$$$$$ /$$$$$$|_/   | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('|  $$$$$$  |____  $$|_  $$_/  | $$ /$$_____/| $$$$   |____  $$ /$$_____/|_  $$_/      | $$  | $$  | $$   | $$         ')div 2),13);
  writeln('|  $$$$$$  |____  $$|_  $$_/  | $$ /$$_____/| $$$$   |____  $$ /$$_____/|_  $$_/      | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('|  $$$$$$  |____  $$|_  $$_/  | $$ /$$_____/| $$$$   |____  $$ /$$_____/|_  $$_/      | $$  | $$  | $$   | $$         ')div 2),14);
  writeln(' \____  $$  /$$$$$$$  | $$    | $$|  $$$$$$ | $$_/    /$$$$$$$| $$        | $$        | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(' /$$  \ $$ /$$__  $$  | $$ /$$| $$ \____  $$| $$     /$$__  $$| $$        | $$ /$$    | $$  | $$  | $$   | $$         ')div 2),15);
  writeln(' /$$  \ $$ /$$__  $$  | $$ /$$| $$ \____  $$| $$     /$$__  $$| $$        | $$ /$$    | $$  | $$  | $$   | $$         ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('|  $$$$$$/|  $$$$$$$  |  $$$$/| $$ /$$$$$$$/| $$    |  $$$$$$$|  $$$$$$$  |  $$$$/   /$$$$$$|  $$$$$$/   | $$         ')div 2),16);
  writeln('|  $$$$$$/|  $$$$$$$  |  $$$$/| $$ /$$$$$$$/| $$    |  $$$$$$$|  $$$$$$$  |  $$$$/   /$$$$$$|  $$$$$$/   | $$         ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(' \______/  \_______/   \___/  |__/|_______/ |__/     \_______/ \_______/   \___/    |______/ \______/    |__/         ')div 2),17);
  writeln(' \______/  \_______/   \___/  |__/|_______/ |__/     \_______/ \_______/   \___/    |______/ \______/    |__/    ');

  couleurTexte(Yellow); // couleur du texte en jaune
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(' /$$                        /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$ ')div 2),19);
  writeln(' /$$                        /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$ ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$                       /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$| $$  /$$/ /$$__  $$')div 2),20);
  writeln('| $$                       /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$| $$  /$$/ /$$__  $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$$$$$$  /$$   /$$      | $$  \__/| $$  \ $$| $$  \__/| $$  \ $$| $$ /$$/ | $$  \ $$')div 2),21);
  writeln('| $$$$$$$  /$$   /$$      | $$  \__/| $$  \ $$| $$  \__/| $$  \ $$| $$ /$$/ | $$  \ $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$__  $$| $$  | $$      | $$      | $$  | $$|  $$$$$$ | $$$$$$$$| $$$$$/  | $$$$$$$$')div 2),22);
  writeln('| $$__  $$| $$  | $$      | $$      | $$  | $$|  $$$$$$ | $$$$$$$$| $$$$$/  | $$$$$$$$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$  \ $$| $$  | $$      | $$      | $$  | $$ \____  $$| $$__  $$| $$  $$  | $$__  $$')div 2),23);
  writeln('| $$  \ $$| $$  | $$      | $$      | $$  | $$ \____  $$| $$__  $$| $$  $$  | $$__  $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$  | $$| $$  | $$      | $$    $$| $$  | $$ /$$  \ $$| $$  | $$| $$\  $$ | $$  | $$')div 2),24);
  writeln('| $$  | $$| $$  | $$      | $$    $$| $$  | $$ /$$  \ $$| $$  | $$| $$\  $$ | $$  | $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$$$$$$/|  $$$$$$$      |  $$$$$$/|  $$$$$$/|  $$$$$$/| $$  | $$| $$ \  $$| $$  | $$')div 2),25);
  writeln('| $$$$$$$/|  $$$$$$$      |  $$$$$$/|  $$$$$$/|  $$$$$$/| $$  | $$| $$ \  $$| $$  | $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('|_______/  \____  $$       \______/  \______/  \______/ |__/  |__/|__/  \__/|__/  |__/')div 2),26);
  writeln('|_______/  \____  $$       \______/  \______/  \______/ |__/  |__/|__/  \__/|__/  |__/');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('           /$$  | $$                                                                  ')div 2),27);
  writeln('           /$$  | $$                                                                  ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('          |  $$$$$$/                                                                  ')div 2),28);
  writeln('          |  $$$$$$/                                                                  ');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('           \______/                                                                   ')div 2),29);
  writeln('           \______/                                                                   ');

  couleurTexte(White); // reset couleur texte
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('DUPUIS Gabin | NAVELOT-GENET Anatole | SUCCAR Eric | WAGNER Tom')div 2)+12,28);
  writeln('DUPUIS Gabin | NAVELOT-GENET Anatole | SUCCAR Eric | WAGNER Tom');

  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Appuyez sur ENTRER pour commencer')div 2),35);
  write('Appuyez sur ENTRER pour commencer');
end;

{Affichage du menu principale}
procedure MainMenu();
begin
  effacerEcran();
  CadrePrincipale();
    // ART ASCII MENU
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(' /$$      /$$ /$$$$$$$$ /$$   /$$ /$$   /$$')div 2),10);
  writeln(' /$$      /$$ /$$$$$$$$ /$$   /$$ /$$   /$$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$$    /$$$| $$_____/| $$$ | $$| $$  | $$')div 2),11);
  writeln('| $$$    /$$$| $$_____/| $$$ | $$| $$  | $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$$$  /$$$$| $$      | $$$$| $$| $$  | $$')div 2),12);
  writeln('| $$$$  /$$$$| $$      | $$$$| $$| $$  | $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$ $$/$$ $$| $$$$$   | $$ $$ $$| $$  | $$')div 2),13);
  writeln('| $$ $$/$$ $$| $$$$$   | $$ $$ $$| $$  | $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$  $$$| $$| $$__/   | $$  $$$$| $$  | $$')div 2),14);
  writeln('| $$  $$$| $$| $$__/   | $$  $$$$| $$  | $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$\  $ | $$| $$      | $$\  $$$| $$  | $$')div 2),15);
  writeln('| $$\  $ | $$| $$      | $$\  $$$| $$  | $$');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$ \/  | $$| $$$$$$$$| $$ \  $$|  $$$$$$/')div 2),16);
  writeln('| $$ \/  | $$| $$$$$$$$| $$ \  $$|  $$$$$$/');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('| $$ \/  | $$| $$$$$$$$| $$ \  $$|  $$$$$$/')div 2),17);
  writeln('|__/     |__/|________/|__/  \__/ \______/ ');
  // Affiche les choix possible
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('[1] Commencer')div 2),25);
  writeln('[1] Commencer');

  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('[2] Quitter')div 2),28);
  writeln('[2] Quitter');

end;

procedure Scenario();
begin
  effacerEcran();
  CadrePrincipale();

  // SCENARIO - - - 
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Dans une réalité. Pas si alternative que ça.')div 2),10);
  writeln('Dans une réalité. Pas si alternative que ça.');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('2024 : une année particulièrement compliquée.')div 2),11);
  writeln('2024 : une année particulièrement compliquée.');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Suite à un mouvement de grève encore jamais vu (les Gilets Verts) pas moins de douze gouvernements')div 2),12);
  writeln('Suite à un mouvement de grève encore jamais vu (les Gilets Verts) pas moins de douze gouvernements');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('se sont succédé entre janvier et mars. Oui, douze. En trois mois')div 2),13);
  writeln('se sont succédé entre janvier et mars. Oui, douze. En trois mois');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('L instabilité économique provoquée par ces changements politiques incessants a plongé le pays dans')div 2),14);
  writeln('L instabilité économique provoquée par ces changements politiques incessants a plongé le pays dans');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('une ère de chaos. Et ce qui devait arriver... arriva. Privée de toute subvention de l État, la direc-')div 2),15);
  writeln('une ère de chaos. Et ce qui devait arriver... arriva. Privée de toute subvention de l État, la direc-');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('-tion de l IUT de Dijon a dû se rendre à l évidence : à défaut d avoir un budget, il allait falloir')div 2),16);
  writeln('-tion de l IUT de Dijon a dû se rendre à l évidence : à défaut d avoir un budget, il allait falloir');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('utiliser la seule ressource encore abondante et peu coûteuse... vous, les étudiant(e)s.')div 2),17);
  writeln('utiliser la seule ressource encore abondante et peu coûteuse... vous, les étudiant(e)s.');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Le 30 avril 2024, la direction dévoile alors une stratégie de redressement financier pour le moins')div 2),18);
  writeln('Le 30 avril 2024, la direction dévoile alors une stratégie de redressement financier pour le moins');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('novatrice : Envoyer les étudiant(e)s coloniser d autres planètes et y construire des usines de pro')div 2),19);
  writeln('novatrice : Envoyer les étudiant(e)s coloniser d autres planètes et y construire des usines de pro');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('production automatisées. Un moyen simple (et étonnamment peu onéreux) d obtenir rapidement les ressour')div 2),20);
  writeln('production automatisées. Un moyen simple (et étonnamment peu onéreux) d obtenir rapidement les ressour');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('ces nécessaires à la survie de l établissement.')div 2),21);
  writeln('ces nécessaires à la survie de l établissement.');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('C est ainsi que, le 15 septembre 2024, vous embarquez pour un voyage à destination de Mars, à bord')div 2),22);
  writeln('C est ainsi que, le 15 septembre 2024, vous embarquez pour un voyage à destination de Mars, à bord');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('d une fusée baptisée "Maëlle", fièrement assemblée lors d une SAE du département GMP. Avec pour')div 2),23);
  writeln('d une fusée baptisée "Maëlle", fièrement assemblée lors d une SAE du département GMP. Avec pour');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('seul(e)s compagnons la Lune, le ciel, et une check-list de sécurité rédigée par Franck Deher,')div 2),24);
  writeln('seul(e)s compagnons la Lune, le ciel, et une check-list de sécurité rédigée par Franck Deher,');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.')div 2),25);
  write('vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.');
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.')div 2),28);
  attendre(10000);
  couleurTexte(Yellow);
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Maintenant, il est temps de vous mettre au travail. L IUT a besoin de vous !')div 2),30);
  write('Maintenant, il est temps de vous mettre au travail. L IUT a besoin de vous !');
  
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Appuyez sur ENTRER pour continuer')div 2),35);
  attendre(1000);
  couleurTexte(white);
  writeln('Appuyez sur ENTRER pour continuer');
  readln()
end;

procedure AfficherMessage(var msg:string);
begin
dessinerCadreXY((SCREEN_WIDTH div 2)-((Length(msg)+10) div 2),(SCREEN_HEIGHT div 2)-2,(SCREEN_WIDTH div 2)+((Length(msg)+10) div 2),(SCREEN_HEIGHT div 2)+2,simple,White,Black);
deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(msg)div 2),(SCREEN_HEIGHT div 2));
writeln(msg);
  
end;

end.