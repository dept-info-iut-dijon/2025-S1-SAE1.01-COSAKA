unit gestionIHM;

{$mode delphi}{$H+}

interface
uses constantunit;

procedure EcranTitre();
function MainMenu():String;
procedure Scenario();
procedure AfficherMessage(msg:string);
procedure AfficherJeu();
procedure AfficherEmplacements(zone:Zone);
procedure AfficherInventaireZone();
procedure AfficherInformations(zone:string; time:string);
procedure AfficherActions();

implementation

uses
  SysUtils, Classes, gestionEcran, LogiqueUnit;


procedure CadrePrincipale();
  begin
    dessinerCadreXY(2,1,(SCREEN_WIDTH-1),(SCREEN_HEIGHT-2),double,white,black); // TAILLE DE BASE
  end;


{Affichage de l'Ecran Titre}
procedure EcranTitre();
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

    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('< Appuyez sur ENTRER pour commencer >')div 2),35);
    write('< Appuyez sur ENTRER pour commencer >');
  end;

{Affichage du menu principale}
function MainMenu():String;
  var
    res:String;
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

    readln(res);
    MainMenu:=res;

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
    couleurTexte(Yellow);
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Maintenant, il est temps de vous mettre au travail. L IUT a besoin de vous !')div 2),30);
    write('Maintenant, il est temps de vous mettre au travail. L IUT a besoin de vous !');
    
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Appuyez sur ENTRER pour continuer')div 2),35);
    couleurTexte(white);
    writeln('Appuyez sur ENTRER pour continuer');
  end;

procedure AfficherMessage(msg:string);
  begin
  dessinerCadreXY((SCREEN_WIDTH div 2)-((Length(msg)+10) div 2),(SCREEN_HEIGHT div 2)-2,(SCREEN_WIDTH div 2)+((Length(msg)+10) div 2),(SCREEN_HEIGHT div 2)+2,simple,White,Black);
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(msg)div 2),(SCREEN_HEIGHT div 2));
  writeln(msg);
  end;

// Affiche le cadre principale du jeu
procedure AfficherJeu();
  begin
    effacerEcran();
    dessinerCadreXY(BORD_GAUCHE, BORD_HAUT, BORD_DROIT, BORD_BAS, simple, white, black); // TAILLE DE BASE
    dessinerCadreXY(BORD_GAUCHE, BORD_HAUT, SEPARATION_ECRAN_INVENTAIRE_PRINCIPAL, BORD_BAS, double, white, black);
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    // Titre
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| SATISFACT IUT |>')div 2),1);
    writeln('<| SATISFACT IUT |>');
    // Titre 2
    deplacerCurseurXY((SCREEN_WIDTH div 10)-(Length('INVENTAIRE DE LA ZONE')div 2),2);
    writeln('INVENTAIRE DE LA ZONE');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('INFORMATIONS')div 2),2);
    writeln('INFORMATIONS');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');

    AfficherInformations('Dijon','Mardi 10 avril 2007');
    AfficherInventaireZone();
    AfficherActions()
  end;

procedure dessinerEmplacement(emplacement:Structure; x1:Integer; y1:Integer; x2:Integer; y2:Integer);
  begin
      dessinerCadreXY(x1, y1, x2, y2, simple, white, black);
      if (not emplacement.est_decouvert) and false then
        begin
        deplacerCurseurXY((x1+x2-Length('Emplacement non decouvert')) div 2, ((y1+y2) div 2));
        write('Emplacement non decouvert');
        end
      else
        begin
        deplacerCurseurXY(x1+1, y1+1);
        write(emplacement.type_structure);
        end;
  end;


procedure AfficherEmplacements(zone:Zone);
  {Affiches les emplacements d'un zone donnée en paramètre}
  const
    BORD_GAUCHE=SEPARATION_ECRAN_INVENTAIRE_PRINCIPAL;
    BORD_DROIT=SEPARATION_ECRAN_INFO_PRINCIPAL;
    MILIEU=(BORD_GAUCHE+BORD_DROIT) div 2;
  var
    emplacement:Structure;
    listeEmplacements:Emplacements; // Liste des emplacements de la zone
    
    i,
    
    // Coordonées x et y des bordures du cadre
    haut_cadre,
    bas_cadre,
    gauche_cadre,
    droite_cadre,

    longueur_colonne, // Nombre de cellule par colonne
    hauteur_tableau,  // Hauteur des cellules
    nbEmplacements:Integer; // Nombre d'emplacament dans la zone
  begin
    listeEmplacements:=getEmplacement(zone);
    nbEmplacements:=Length(listeEmplacements);

    longueur_colonne:=nbEmplacements div 2;
    if ((nbEmplacements mod 2)=1) then
      begin
      inc(longueur_colonne);
      end;

    hauteur_tableau:=(BORD_BAS-BORD_HAUT) div longueur_colonne;

    gauche_cadre:=BORD_GAUCHE+1;
    droite_cadre:=MILIEU-1;
    // Affiche la première moitié des emplacements
    for i:=low(listeEmplacements) to longueur_colonne-1 do
      begin
      haut_cadre:=BORD_HAUT+i*hauteur_tableau+1;
      bas_cadre:=BORD_HAUT+hauteur_tableau*(i+1);
      emplacement:=listeEmplacements[i];

      dessinerEmplacement(emplacement, gauche_cadre, haut_cadre, droite_cadre, bas_cadre);
      end;
    
    gauche_cadre:=MILIEU+1;
    droite_cadre:=BORD_DROIT-1;
    // Affiche la seconde moitié des emplacements
    for i:=longueur_colonne to High(listeEmplacements) do
      begin
      haut_cadre:=BORD_HAUT+(i-longueur_colonne)*hauteur_tableau+1;
      bas_cadre:=BORD_HAUT+hauteur_tableau*(i-longueur_colonne+1);
      emplacement:=listeEmplacements[i];

      dessinerEmplacement(emplacement, gauche_cadre, haut_cadre, droite_cadre, bas_cadre);
      end;
    

  end;

procedure AfficherInventaireZone();
  var
  m:Materiaux; // Prend la liste des Materiaux
  valeur:array[Materiaux] of Integer;
  i,count,startY:Integer;

  begin

    count := Ord(High(Materiaux)) - Ord(Low(Materiaux)) + 1;
    startY := (SCREEN_HEIGHT div 2) - ((count) div 2);
    i:= 0;
    for m in Materiaux do 
      begin
          valeur[m] := 0;
          if (m <> Electricite) and (m <> Fondations) then
          begin
          deplacerCurseurXY((SCREEN_WIDTH div 10-15),startY+i);
          writeln(m);
          deplacerCurseurXY((SCREEN_WIDTH div 10+10),startY+i);
          writeln(': ',valeur[m]);
          i:= i + 1; 
          end;
      end;
  end;

procedure AfficherInformations(zone:string; time:string);
  var
  m:Materiaux; // Prend la liste des Materiaux
  valeur:array[Materiaux] of Integer;

  begin
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),5);
    writeln('ZONE : ',zone);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),7);
    writeln('DATE : ',time);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),10);
    write('Production Electricite');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-9),10);
    writeln(': ',valeur[Electricite]);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),11);
    write('Consommation Electricite');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-9),11);
    couleurTexte(Yellow); // couleur jaune
    writeln(': ',valeur[Electricite]);
    couleurTexte(White); // Reset de la couleur


    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),13);
    write('Fondations');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-9),13);
    writeln(': ',valeur[Fondations]);
  end;

procedure AfficherActions();
  begin
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+3));
    writeln('[1] Construire un batiment');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+4));
    writeln('[2] Chnager la production');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+5));
    writeln('[3] Ameliorer un batiment');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+6));
    writeln('[4] Explorer la zone');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln('[5] Changer de zone');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+8));
    writeln('[6] Transferer des ressources');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9));
    writeln('[7] Passer la journee');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[8] Missions');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+11));
    writeln('[9] Wiki');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[0] Quitter la partie');
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

  end.