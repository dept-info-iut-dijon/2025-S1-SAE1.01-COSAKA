unit gestionIHM;

{$mode delphi}{$H+}

{
RÔLE : L’unité gère l’affichage console de manière structurée,
 notamment le positionnement précis du curseur,
 le centrage dynamique de textes et la prise en charge facultative de l’encodage UTF-8.
 Elle fournit des procédures permettant de contrôler la mise en page,
de calculer automatiquement les positions en fonction de la taille de l’écran et d’assurer un rendu propre,
quelle que soit la quantité de contenu affiché.
L’activation temporaire de l’UTF-8 garantit un affichage correct des caractères accentués sans perturber les autres interfaces du programme,
grâce au rétablissement du code page standard une fois les opérations terminées.
L’ensemble offre un cadre fiable pour produire des écrans console lisibles,
cohérents et adaptés à différents contextes d’utilisation.
}

interface
uses constantunit;
// Liste des procédures et fonctions
procedure EcranTitre();
function AfficheMainMenu():String;
procedure Scenario();
procedure AfficherMessage(msg:string);
procedure AfficherZone(zone:Zone);
procedure AfficherEmplacements(zone:Zone);
procedure AfficherInventaireZone(zone:Zone);
procedure AfficherInformations(zone:zone; time:string);
procedure AfficherActions();
procedure AfficherMenuWikiBatiment();
procedure AfficherMenuWikiProduction();
procedure UTF8(status:Boolean);
procedure AfficherMenuBatiment();
procedure AfficherMenuZone();
procedure AfficherActionInformation(msg:string);
procedure AfficherMenuMateriauxTransformer();

implementation

uses
{
  gestionEcran, LogiqueUnit => Autre Unit
  windows => gère l'affiche pour les symboles(ex : é, à, ç, etc...) notamment.
}
  SysUtils, TypInfo, Classes, gestionEcran, LogiqueUnit, windows;

{gère l'affiche pour les symboles(ex : é, à, ç, etc...) notamment. 
Si la procedure est régler VRAI alors UTF8 activé sinon UTF8 désactivé}
procedure UTF8(status:Boolean);
  begin
    if status = True then
    begin
      SetConsoleOutputCP(65001); // UTF8
    end
    else
    begin
      SetConsoleOutputCP(850); // RESET
    end;
  end;

procedure CadrePrincipale();
  begin
    dessinerCadreXY(2,1,(SCREEN_WIDTH-1),(SCREEN_HEIGHT-2),double,white,black); // TAILLE DE BASE
  end;


// ._____.____.____......_...._..._....._____.___._____.____.._____.
// |.____/.___|.._.\..../.\..|.\.|.|...|_..._|_._|_..._|.._.\|.____|
// |.._||.|...|.|_).|../._.\.|..\|.|_____|.|..|.|..|.|.|.|_).|.._|..
// |.|__|.|___|.._.<../.___.\|.|\..|_____|.|..|.|..|.|.|.._.<|.|___.
// |_____\____|_|.\_\/_/...\_\_|.\_|.....|_|.|___|.|_|.|_|.\_\_____|
procedure EcranTitre();
  begin
  {Centrage horizontal de chaque ligne de l’ASCII art.
  Pour chaque ligne, on calcule sa longueur avec Length(), puis on positionne
  le curseur en X à (SCREEN_WIDTH div 2) - (Length(ligne) div 2) afin de l’afficher
  exactement au centre de l’écran. La position Y est simplement incrémentée
  pour afficher les lignes les unes sous les autres tout en conservant
  un alignement uniforme.}
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

    couleurTexte(White); // reset couleur texte en blanc
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('DUPUIS Gabin | NAVELOT-GENET Anatole | SUCCAR Eric | WAGNER Tom')div 2)+12,28); // deplacer le curseur
    writeln('DUPUIS Gabin | NAVELOT-GENET Anatole | SUCCAR Eric | WAGNER Tom'); // Les meilleurs

    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('< Appuyez sur ENTRER pour commencer >')div 2),35);  
    write('< Appuyez sur ENTRER pour commencer >');
    deplacerCurseurXY(2,SCREEN_HEIGHT-1);
  end;

// ...............................__..__._____._..._._..._.
// ..............................|..\/..|.____|.\.|.|.|.|.|
// ..............................|.|\/|.|.._|.|..\|.|.|.|.|
// ..............................|.|..|.|.|___|.|\..|.|_|.|
// ..............................|_|..|_|_____|_|.\_|\___/.

{Affichage du menu principale}
function AfficheMainMenu():String;
  var
    res:String;
  begin
    // Tout beau tout propre(nouveau cadre)
    effacerEcran();
    CadrePrincipale();

    // ART ASCII même principe que pour les précédents.
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
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('[1] Commencer')div 2),25); // centrer, beau, on valide
    writeln('[1] Commencer');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('[2] Quitter')div 2),28); // Idem
    writeln('[0] Quitter');
    deplacerCurseurXY(2,SCREEN_HEIGHT-1);

    readln(res);
    AfficheMainMenu:=res;

  end;

// ...............................____...____._____._..._...._....____..___.___..
// ............................../.___|./.___|.____|.\.|.|../.\..|.._.\|_._/._.\.
// ..............................\___.\|.|...|.._|.|..\|.|./._.\.|.|_).||.|.|.|.|
// ...............................___).|.|___|.|___|.|\..|/.___.\|.._.<.|.|.|_|.|
// ..............................|____/.\____|_____|_|.\_/_/...\_\_|.\_\___\___/.
procedure Scenario();
  begin
    effacerEcran();
    CadrePrincipale();
    // SCENARIO - - - 
    { Tous les textes sont centré et mis en UTF8 }
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Dans une réalité. Pas si alternative que ça.')div 2),10);
    writeln('Dans une réalité. Pas si alternative que ça.');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('2024 : une année particulièrement compliquée.')div 2),11);
    writeln('2024 : une année particulièrement compliquée.');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Suite à un mouvement de grève encore jamais vu (les Gilets Verts) pas moins de douze gouvernements')div 2),12);
    writeln('Suite à un mouvement de grève encore jamais vu (les Gilets Verts) pas moins de douze gouvernements');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('se sont succédé entre janvier et mars. Oui, douze. En trois mois')div 2),13);
    writeln('se sont succédé entre janvier et mars. Oui, douze. En trois mois');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('L instabilité économique provoquée par ces changements politiques incessants a plongé le pays dans')div 2),14);
    writeln('L''instabilité économique provoquée par ces changements politiques incessants a plongé le pays dans');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('une ère de chaos. Et ce qui devait arriver... arriva. Privée de toute subvention de l État, la direc-')div 2),15);
    writeln('une ère de chaos. Et ce qui devait arriver... arriva. Privée de toute subvention de l''État, la direc-');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('-tion de l IUT de Dijon a dû se rendre à l évidence : à défaut d avoir un budget, il allait falloir')div 2),16);
    writeln('-tion de l''IUT de Dijon a dû se rendre à l''évidence : à défaut d''avoir un budget, il allait falloir');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('utiliser la seule ressource encore abondante et peu coûteuse... vous, les étudiant(e)s.')div 2),17);
    writeln('utiliser la seule ressource encore abondante et peu coûteuse... vous, les étudiant(e)s.');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Le 30 avril 2024, la direction dévoile alors une stratégie de redressement financier pour le moins')div 2),18);
    writeln('Le 30 avril 2024, la direction dévoile alors une stratégie de redressement financier pour le moins');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('novatrice : Envoyer les étudiant(e)s coloniser d autres planètes et y construire des usines de pro')div 2),19);
    writeln('novatrice : Envoyer les étudiant(e)s coloniser d''autres planètes et y construire des usines de pro');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('production automatisées. Un moyen simple (et étonnamment peu onéreux) d obtenir rapidement les ressour')div 2),20);
    writeln('production automatisées. Un moyen simple (et étonnamment peu onéreux) d''obtenir rapidement les');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('ces nécessaires à la survie de l établissement.')div 2),21);
    writeln('ressources nécessaires à la survie de l''établissement.');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('C est ainsi que, le 15 septembre 2024, vous embarquez pour un voyage à destination de Mars, à bord')div 2),22);
    writeln('C''est ainsi que, le 15 septembre 2024, vous embarquez pour un voyage à destination de Mars, à bord');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('d une fusée baptisée "Maëlle", fièrement assemblée lors d une SAE du département GMP. Avec pour')div 2),23);
    writeln('d''une fusée baptisée "Maëlle", fièrement assemblée lors d une SAE du département GMP. Avec pour');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('seul(e)s compagnons la Lune, le ciel, et une check-list de sécurité rédigée par Franck Deher,')div 2),24);
    writeln('seul(e)s compagnons la Lune, le ciel, et une check-list de sécurité rédigée par Franck Deher,');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.')div 2),25);
    write('vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.');
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('vous atteignez (contre toute attente) la surface martienne sans le moindre incident majeur.')div 2),28);
    couleurTexte(Yellow);
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Maintenant, il est temps de vous mettre au travail. L IUT a besoin de vous !')div 2),30);
    write('Maintenant, il est temps de vous mettre au travail. L''IUT a besoin de vous !');
    
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('Appuyez sur ENTRER pour continuer')div 2),35);
    couleurTexte(white);
    writeln('Appuyez sur ENTRER pour continuer');
    deplacerCurseurXY(2,SCREEN_HEIGHT-1);
    readln();

    UTF8(False);
  end;

// ...............................____...___..____......._..._.____..
// ..............................|.._.\./._.\|.._.\.....|.|.|.|.._.\.
// ..............................|.|_).|.|.|.|.|_).|____|.|.|.|.|_).|
// ..............................|..__/|.|_|.|..__/_____|.|_|.|..__/.
// ..............................|_|....\___/|_|.........\___/|_|....

{ Affiche un cadre centrer avec un message en entrée 'msg'}
procedure AfficherMessage(msg:string);
  begin
  dessinerCadreXY((SCREEN_WIDTH div 2)-((Length(msg)+10) div 2),(SCREEN_HEIGHT div 2)-2,(SCREEN_WIDTH div 2)+((Length(msg)+10) div 2),(SCREEN_HEIGHT div 2)+2,simple,White,Black);
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length(msg)div 2),(SCREEN_HEIGHT div 2));
  UTF8(True);
  writeln(msg);
  UTF8(False);
  end;

// Affiche le cadre principale du jeu
procedure AfficherZone(zone:Zone);
  begin
    effacerEcran();
    {1 cadre principale avec deux cadres de chaque coté}
    dessinerCadreXY(BORD_GAUCHE, BORD_HAUT, BORD_DROIT, BORD_BAS, simple, white, black); // TAILLE DE BASE
    dessinerCadreXY(BORD_GAUCHE, BORD_HAUT, SEPARATION_ECRAN_INVENTAIRE_PRINCIPAL, BORD_BAS, double, white, black);
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    // Titre
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| SATISFACT IUT |>')div 2),1);
    writeln('<| SATISFACT IUT |>');
    // Titre 2 3 4
    deplacerCurseurXY((SCREEN_WIDTH div 10)-(Length('INVENTAIRE DE LA ZONE')div 2),2);
    writeln('INVENTAIRE DE LA ZONE');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('INFORMATIONS')div 2),2);
    writeln('INFORMATIONS');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');

    {Call des procedures pour assembler toutes les interfaces en une}
    AfficherEmplacements(zone);
    AfficherInformations(zone,'-');
    AfficherInventaireZone(zone);
    AfficherActions();
    readln();
    AfficherMenuMateriauxTransformer();
  end;

// .____.._____.____.____.___._..._._..._._____.____...........................
// |.._.\|.____/.___/.___|_._|.\.|.|.\.|.|.____|.._.\..........................
// |.|.|.|.._|.\___.\___.\|.||..\|.|..\|.|.._|.|.|_).|.........................
// |.|_|.|.|___.___).|__).|.||.|\..|.|\..|.|___|.._.<..........................
// |____/|_____|____/____/___|_|_\_|_|_\_|_____|_|.\_\._____._..._._____.____..
// |.____|..\/..|.._.\|.|....../.\../.___|.____|..\/..|.____|.\.|.|_..._/.___|.
// |.._|.|.|\/|.|.|_).|.|...../._.\|.|...|.._|.|.|\/|.|.._|.|..\|.|.|.|.\___.\.
// |.|___|.|..|.|..__/|.|___./.___.\.|___|.|___|.|..|.|.|___|.|\..|.|.|..___).|
// |_____|_|..|_|_|...|_____/_/...\_\____|_____|_|..|_|_____|_|.\_|.|_|.|____/.

procedure dessinerEmplacement(emplacement:Structure; x1:Integer; y1:Integer; x2:Integer; y2:Integer);
  var
    s:String; // Variable qui stock les chaine de caractères à écrire
  begin
      dessinerCadreXY(x1, y1, x2, y2, simple, white, black);
      // Vérifie si l'emplacement est découvert
      if (not emplacement.est_decouvert) and false then
        // Si l'emplacement n'est pas découvert, l'indique
        begin
        s:='Emplacement non decouvert';
        deplacerCurseurXY((x1+x2-Length(s)) div 2, ((y1+y2) div 2));
        write(s);
        end
      else
        begin
        deplacerCurseurXY(x1+2, y1+1);
        write('Structure : ', emplacement.type_structure);
        if (emplacement.type_structure<>Vide) and (emplacement.type_structure<>Hub) then
          begin
          s:= 'Niveau : ' + IntToStr(emplacement.niveau);
          deplacerCurseurXY(x2-Length(s)-2, y1+1);
          write(s);
          s:= 'Production : ' + GetEnumName(TypeInfo(emplacement.materiaux), Ord(emplacement.materiaux));
          deplacerCurseurXY(x1+2, y2-1);
          write(s);
          end;

        end;
  end;

// ...._...._____._____.___.____._..._._____.____..............................
// .../.\..|..___|..___|_._/.___|.|.|.|.____|.._.\.............................
// ../._.\.|.|_..|.|_...|.|.|...|.|_|.|.._|.|.|_).|............................
// ./.___.\|.._|.|.._|..|.|.|___|.._..|.|___|.._.<.............................
// /_/___\_\_|__.|_|_..|___\____|_|.|_|_____|_|.\_\.__._____._..._._____.____..
// |.____|..\/..|.._.\|.|....../.\../.___|.____|..\/..|.____|.\.|.|_..._/.___|.
// |.._|.|.|\/|.|.|_).|.|...../._.\|.|...|.._|.|.|\/|.|.._|.|..\|.|.|.|.\___.\.
// |.|___|.|..|.|..__/|.|___./.___.\.|___|.|___|.|..|.|.|___|.|\..|.|.|..___).|
// |_____|_|..|_|_|...|_____/_/...\_\____|_____|_|..|_|_____|_|.\_|.|_|.|____/.

procedure AfficherEmplacements(zone:Zone);
  {Affiches les emplacements d'un zone donnée en paramètre}
  const
    BORD_GAUCHE=SEPARATION_ECRAN_INVENTAIRE_PRINCIPAL;  // Les coordonées x du bord gauche du cadre principal
    BORD_DROIT=SEPARATION_ECRAN_INFO_PRINCIPAL;   // Les coordonées x du bord droit du cadre principal
    MILIEU=(BORD_GAUCHE+BORD_DROIT) div 2;    // Les coordonées x du milieu du cadre principal
    ESPACEMENT=2;   // Espacement entre les cellules et le bord du cadre principal
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
    nbEmplacements:Integer; // Nombre d'emplacement dans la zone
  begin
    listeEmplacements:=getEmplacement(zone);
    nbEmplacements:=Length(listeEmplacements);

    longueur_colonne:=nbEmplacements div 2;
    if ((nbEmplacements mod 2)=1) then
      begin
      inc(longueur_colonne);
      end;

    hauteur_tableau:=(BORD_BAS-BORD_HAUT-ESPACEMENT) div longueur_colonne;

    gauche_cadre:=BORD_GAUCHE+ESPACEMENT;
    droite_cadre:=MILIEU-ESPACEMENT;
    // Affiche la première moitié des emplacements
    for i:=low(listeEmplacements) to longueur_colonne-1 do
      begin
      haut_cadre:=BORD_HAUT+(i)*hauteur_tableau+ESPACEMENT;
      bas_cadre:=BORD_HAUT+hauteur_tableau*(i+1);
      emplacement:=listeEmplacements[i];

      dessinerEmplacement(emplacement, gauche_cadre, haut_cadre, droite_cadre, bas_cadre);
      end;
    
    gauche_cadre:=MILIEU+ESPACEMENT;
    droite_cadre:=BORD_DROIT-ESPACEMENT;
    // Affiche la seconde moitié des emplacements
    for i:=longueur_colonne to High(listeEmplacements) do
      begin
      haut_cadre:=BORD_HAUT+(i-longueur_colonne)*hauteur_tableau+ESPACEMENT;
      bas_cadre:=BORD_HAUT+hauteur_tableau*(i-longueur_colonne+1);
      emplacement:=listeEmplacements[i];

      dessinerEmplacement(emplacement, gauche_cadre, haut_cadre, droite_cadre, bas_cadre);
      end;
    

  end;

// .___._...___....._______._..._._____.._....___.____.._____.
// |_._|.\.|.\.\..././.____|.\.|.|_..._|/.\..|_._|.._.\|.____|
// .|.||..\|.|\.\././|.._|.|..\|.|.|.|./._.\..|.||.|_).|.._|..
// .|.||.|\..|.\.V./.|.|___|.|\..|.|.|/.___.\.|.||.._.<|.|___.
// |___|_|.\_|..\_/..|_____|_|.\_|.|_/_/...\_\___|_|.\_\_____|

procedure AfficherInventaireZone(zone:Zone);
  var
  m:Materiaux; // Prend la liste des Materiaux
  inventaire_zone:Inventaire;
  i,count,startY:Integer;

  begin
    inventaire_zone:=zone.inventaire;
    count := Ord(High(Materiaux)) - Ord(Low(Materiaux)) + 1;
    startY := (SCREEN_HEIGHT div 2) - ((count) div 2);
    i:= 0;
    for m in Materiaux do 
      begin
          if (m <> Electricite) then
            begin
            deplacerCurseurXY((SCREEN_WIDTH div 10-15),startY+i);
            writeln(m);
            deplacerCurseurXY((SCREEN_WIDTH div 10+10),startY+i);

            // Affiche les valeurs en rouge si elle sont = 0
            if inventaire_zone[m] = 0 then
              begin
                couleurTexte(Red);
              end;
            writeln(': ',inventaire_zone[m]);
            couleurTexte(White);
            i:= i + 1; 
          end;
      end;
  end;

// .___._..._._____.___..____..__..__...._.._____.___.___.._..._.____..
// |_._|.\.|.|..___/._.\|.._.\|..\/..|../.\|_..._|_._/._.\|.\.|./.___|.
// .|.||..\|.|.|_.|.|.|.|.|_).|.|\/|.|./._.\.|.|..|.|.|.|.|..\|.\___.\.
// .|.||.|\..|.._||.|_|.|.._.<|.|..|.|/.___.\|.|..|.|.|_|.|.|\..|___).|
// |___|_|.\_|_|...\___/|_|.\_\_|..|_/_/...\_\_|.|___\___/|_|.\_|____/.

procedure AfficherInformations(zone:Zone; time:string);
  var
  m:Materiaux; // Prend la liste des Materiaux
  valeur:array[Materiaux] of Integer;

  begin
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),5);
    writeln('ZONE : ',zone.nom);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),7);
    writeln('DATE : ',time);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),10);

    {Si la consommation est plus importante que la production
    alors la valeur s'affiche en rouge}
        if (ConsommationElectricite(zone)) > ProductionElectricite(zone) then
      begin
        couleurTexte(Red);
      end
      else
      begin
        couleurTexte(Green);
      end;
      UTF8(True);
    write('Production Electricité');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-9),10);

    writeln(': ',ProductionElectricite(zone));
    couleurTexte(White);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),11);
    couleurTexte(Yellow); // couleur jaune
    write('Consommation Electricité');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-9),11);
    writeln(': ',ConsommationElectricite(zone));
    couleurTexte(White); // Reset de la couleur
    UTF8(False);
  end;

// .................................._....____._____.___.___.._..._.____..
// ................................./.\../.___|_..._|_._/._.\|.\.|./.___|.
// ................................/._.\|.|.....|.|..|.|.|.|.|..\|.\___.\.
// .............................../.___.\.|___..|.|..|.|.|_|.|.|\..|___).|
// ............................../_/...\_\____|.|_|.|___\___/|_|.\_|____/.

procedure AfficherActions();
  begin
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+3));
    writeln('[1] Construire un bâtiment');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+4));
    writeln('[2] Changer la production');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+5));
    writeln('[3] Améliorer un bâtiment');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+6));
    writeln('[4] Explorer la zone');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln('[5] Changer de zone');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+8));
    writeln('[6] Transferer des ressources');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9));
    writeln('[7] Passer la journée');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[8] Missions');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+11));
    writeln('[9] Wiki');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[0] Quitter la partie');
    UTF8(False);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

procedure AfficherMenuBatiment();
  begin
   dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
   deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln('Que voulez vous construire ?');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9));
    writeln('[1] Mine');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[2] Usine');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+11));
    writeln('[3] Centrale');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[0] Retour');
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

procedure AfficherActionInformation(msg: string);
  var
    i, j, compteur, dernierEspace: integer;
    ligne: string;
  begin
      // Nouveau Cadre
      dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
      deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
      couleurTexte(Red); // couleur Rouge
      
      compteur := 0;
      ligne := '';
      j := 1;
      dernierEspace := 0;
      
      for i := 1 to Length(msg) do
      begin
          ligne := ligne + msg[i];
          Inc(compteur);
          
          // Mémoriser pos dernier espace
          if msg[i] = ' ' then
              dernierEspace := compteur;
          
          // Si 32 char ou fin du msg
          if (compteur >= 32) or (i = Length(msg)) then
          begin
              // Si pas fin et qu'on a trouvé un espace
              if (i < Length(msg)) and (dernierEspace > 0) then
              begin
                  // Afficher seulement jusqu'au dernier espace
                  deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7+j));
                  writeln(Copy(ligne, 1, dernierEspace));
                  
                  // Garde reste pour la ligne suivante
                  ligne := Copy(ligne, dernierEspace + 1, Length(ligne) - dernierEspace);
                  compteur := Length(ligne);
                  dernierEspace := 0;
              end
              else
              begin
                  // Afficher full ligne
                  deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7+j));
                  writeln(ligne);
                  ligne := '';
                  compteur := 0;
                  dernierEspace := 0;
              end;
              
              Inc(j);
          end;
      end;
  end;


procedure AfficherMenuZone();
  begin
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    UTF8(True);
    writeln('Où allons nous ?');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9));
    writeln('[1] ',NOM_ZONE1);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[2] ',NOM_ZONE2);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+11));
    writeln('[3] ',NOM_ZONE3);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[0] Retour');
    UTF8(False);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

procedure AfficherMenuMateriauxTransformer();
  var
    m: Materiaux; // Parcourt les matériaux
    i, startY: Integer; // Compteur et position Y
  begin
    startY := (SCREEN_HEIGHT div 2) + 3; // Position de départ
    i := 1; // Numérotation à partir de 1
    
    // Dessine le cadre
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    
    UTF8(True);
    
    // Affiche le titre
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34), startY + (i - 1)-2);
    writeln('Que voulez vous produire ?');
    
    // Affiche les matériaux transformés uniquement
    for m in Materiaux do 
      begin
        if (m <> Electricite) and (m <> Fer) and (m <> Cuivre) and (m <> Calcaire) and (m <> Charbon) then
          begin
            deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34), startY + (i - 1));
            writeln('[', i, '] ', m);
            i := i + 1;
          end;
      end;
    
    // Option retour
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34), startY + (i - 1));
    writeln('[0] Retour');
    
    UTF8(False);
  end;

// ..............................__........_____._.._____.
// ..............................\.\.....././_._|.|/./_._|
// ...............................\.\./\././.|.||.'./.|.|.
// ................................\.V..V./..|.||...\.|.|.
// .____...._.._____.___.__..__.____\_/\_/_.|___|_|\_\___|
// |.__.)../.\|_..._|_._|..\/..|.____|.\.|.|_..._/.___|...
// |.._.\./._.\.|.|..|.||.|\/|.|.._|.|..\|.|.|.|.\___.\...
// |.|_)./.___.\|.|..|.||.|..|.|.|___|.|\..|.|.|..___).|..
// |____/_/...\_\_|.|___|_|..|_|_____|_|.\_|.|_|.|____/...

procedure AfficherMenuWikiBatiment();
  begin
    effacerEcran();
    dessinerCadreXY(2, 1, (SCREEN_WIDTH-1), (SCREEN_HEIGHT-2), simple, white, black); // TAILLE DE BASE
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL,1,(SCREEN_WIDTH -1),(SCREEN_HEIGHT-2),double,white,black);

    // Titre
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| WIKI BATIMENTS |>')div 2),1);
    writeln('<| WIKI BATIMENTS |>');

    deplacerCurseurXY(5,(SCREEN_HEIGHT-3));
    writeln('Source : Karine Serier');


    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+8));
    writeln('[1] Wiki PRODUCTION');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[2] Scenario');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[0] Revenir au jeu');
    UTF8(False);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

// ..............................__........_____._.._____....
// ..............................\.\.....././_._|.|/./_._|...
// ...............................\.\./\././.|.||.'./.|.|....
// ................................\.V..V./..|.||...\.|.|....
// .____..____...___..____.._..._.._\_/\_/__|___|_|\_\___|._.
// |.._.\|.._.\./._.\|.._.\|.|.|.|/.___|_..._|_._/._.\|.\.|.|
// |.|_).|.|_).|.|.|.|.|.|.|.|.|.|.|.....|.|..|.|.|.|.|..\|.|
// |..__/|.._.<|.|_|.|.|_|.|.|_|.|.|___..|.|..|.|.|_|.|.|\..|
// |_|...|_|.\_\\___/|____/.\___/.\____|.|_|.|___\___/|_|.\_|

procedure AfficherMenuWikiProduction();
  begin
    effacerEcran();
    dessinerCadreXY(2, 1, (SCREEN_WIDTH-1), (SCREEN_HEIGHT-2), simple, white, black); // TAILLE DE BASE
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL,1,(SCREEN_WIDTH -1),(SCREEN_HEIGHT-2),double,white,black);

    // Titre
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| WIKI PRODUCTION |>')div 2),1);
    writeln('<| WIKI PRODUCTION |>');

    deplacerCurseurXY(5,(SCREEN_HEIGHT-3));
    writeln('Source : Sabine Vaudeville');

    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+8));
    writeln('[1] Wiki BATIMENTS');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[2] Scenario');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[0] Revenir au jeu');
    UTF8(False);

      dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
      deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
    end;


end.