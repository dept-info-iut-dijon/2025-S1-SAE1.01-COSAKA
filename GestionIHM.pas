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
uses constantunit,Sound;
// Liste des procédures et fonctions
procedure EcranTitre();
function AfficheMainMenu():String;
procedure Scenario();
procedure AfficherMessage(msg:string);
procedure AfficherZone(zone:Zone; date:Date; argent:Integer);
procedure AfficherEmplacements(zone:Zone);
procedure AfficherInventaireZone(zone:Zone);
procedure AfficherInformations(zone:zone; time:Date; montant_argent:Integer);
procedure AfficheRecapJournee(curent_zone:Zone;curent_date:Date);
procedure AfficherActions();
procedure UTF8(status:Boolean);
{Moifie le traitement des caractères spéciaux (é, à, ç, etc...) en UTF8 si status = TRUE sinon RESET}

procedure AfficherMenuBatiment();
procedure AfficherMenuActionBatiments();
procedure AfficherMenuZoneAvecMessage(msg:String);
procedure AfficherMenuMateriauxAvecMessage(msg:String; n:Integer);
procedure AfficherActionInformation(msg:string);
procedure AfficherQuestionInformation(msg:String);
procedure AfficherMenuMateriauxTransformer();

{---------Wiki---------}

procedure AfficherMenuWikiBatiment();
{Informations sur les bâtiments du jeu, (coût de construction, énergie consommée/produite et coût d'amélioration)}

procedure AfficherMenuWikiProduction();
{Informations sur les matériaux de productions du jeu}

procedure AfficherMenuMissions(miss:MissionsActives; zone_actuelle:Zone);

procedure AfficherMenuBoutique();


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

    StartSound(); // ajoute le son

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
    SonInteraction();

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
    SonInteraction();
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
procedure AfficherZone(zone:Zone; date:Date; argent:Integer);
  begin
        
    SonInteraction();
    
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
    AfficherInformations(zone, date, argent);
    AfficherInventaireZone(zone);
    AfficherActions();

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

procedure dessinerEmplacement(emplacement:Structure; numero_emplacement:Integer; x1:Integer; y1:Integer; x2:Integer; y2:Integer);
  var
    col:Byte;
    s:String; // Variable qui stock les chaine de caractères à écrire
  begin
    if not emplacement.est_decouvert then
      col:=DarkGray
    else if emplacement.panne then
      col:=Red
    else if emplacement.type_structure = Hub then
      col:=LightBlue
    else if emplacement.type_structure = Gisement then
      col:=Yellow
    else if emplacement.type_structure = Mine then
    col:=Brown
    else if emplacement.type_structure = Centrale then
    col:=LightGreen
    else if (emplacement.type_structure = Usine) or (emplacement.type_structure = AscenseurOrbital) then
    col:=LightCyan
    else
      col:=white;
    couleurTexte(col);
    dessinerCadreXY(x1, y1, x2, y2, simple, col, black);
    // Vérifie si l'emplacement est découvert
    if (not emplacement.est_decouvert) then
      // Si l'emplacement n'est pas découvert, l'indique
      begin
      s:='Emplacement non decouvert';
      deplacerCurseurXY((x1+x2-Length(s)) div 2, ((y1+y2) div 2));
      write(s);
      end
    else
      begin
      deplacerCurseurXY(x1+2, y1+1);
      write('STRUCTURE : ', emplacement.type_structure);
      if (emplacement.type_structure<>Vide) and (emplacement.type_structure<>Hub) then
        begin
        s:= 'NIVEAU : ' + IntToStr(emplacement.niveau);
        deplacerCurseurXY(x2-Length(s)-2, y1+1);
        write(s);
        s:= 'PRODUCTION : ' + GetEnumName(TypeInfo(emplacement.materiaux), Ord(emplacement.materiaux));
        deplacerCurseurXY(x1+2, y2-1);
        write(s);
        if emplacement.panne then
          begin
          s:='EN PANNE';
          deplacerCurseurXY(x2-Length(s)-2, y2-1);
          write(s);
          end;
        end;

      end;
    s:=' Emplacement ' + IntToStr(numero_emplacement) + ' ';
    deplacerCurseurXY((x1+x2-Length(s)) div 2, y1);
    write(s);
    couleurTexte(White);
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

      dessinerEmplacement(emplacement, i, gauche_cadre, haut_cadre, droite_cadre, bas_cadre);
      end;
    
    gauche_cadre:=MILIEU+ESPACEMENT;
    droite_cadre:=BORD_DROIT-ESPACEMENT;
    // Affiche la seconde moitié des emplacements
    for i:=longueur_colonne to High(listeEmplacements) do
      begin
      haut_cadre:=BORD_HAUT+(i-longueur_colonne)*hauteur_tableau+ESPACEMENT;
      bas_cadre:=BORD_HAUT+hauteur_tableau*(i-longueur_colonne+1);
      emplacement:=listeEmplacements[i];

      dessinerEmplacement(emplacement, i, gauche_cadre, haut_cadre, droite_cadre, bas_cadre);
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
  inventaire_zone:TableauMateriaux;
  i,count,startY:Integer;

  begin
    inventaire_zone:=zone.inventaire;
    count := Ord(High(Materiaux)) - Ord(Low(Materiaux)) + 1;
    startY := (SCREEN_HEIGHT div 2) - ((count) div 2) - 5;
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
            i:= i + 2; 
          end;
      end;
  end;

// .___._..._._____.___..____..__..__...._.._____.___.___.._..._.____..
// |_._|.\.|.|..___/._.\|.._.\|..\/..|../.\|_..._|_._/._.\|.\.|./.___|.
// .|.||..\|.|.|_.|.|.|.|.|_).|.|\/|.|./._.\.|.|..|.|.|.|.|..\|.\___.\.
// .|.||.|\..|.._||.|_|.|.._.<|.|..|.|/.___.\|.|..|.|.|_|.|.|\..|___).|
// |___|_|.\_|_|...\___/|_|.\_\_|..|_/_/...\_\_|.|___\___/|_|.\_|____/.

procedure AfficherInformations(zone:Zone; time:Date; montant_argent:Integer);
  begin
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),5);
    writeln('ZONE : ',zone.nom);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),7);
    writeln('DATE : ',time.jour, ' ', time.nb_jour, ' ', time.mois, ' ', time.annee);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),9);
    couleurTexte(LightMagenta);
    write(NOM_MONNAIE, ' : ', montant_argent,'€');
    couleurTexte(white);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),12);

    {Si la consommation est plus importante que la production
    alors la valeur s'affiche en rouge}
        if (ConsommationElectricite(zone)) > ProductionElectricite(zone) then
      begin
        couleurTexte(Red);
      end
      else
      begin
        couleurTexte(Yellow);
      end;
    write('Production Electricité');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-9),12);

    writeln(': ',ProductionElectricite(zone));
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),14);
    write('Consommation Electricité');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-9),14);
    writeln(': ',ConsommationElectricite(zone));
    couleurTexte(White); // Reset de la couleur
    UTF8(False);
  end;

procedure AfficheRecapJournee(curent_zone:Zone;curent_date:Date);
  var
    production:TableauMateriaux;
    materiau:Materiaux;
    total_materiaux_a_afficher:Integer;
    s:String;

    // Coordonées des bords du cadre affiché
    cadre_haut,
    cadre_bas,
    cadre_droite,
    cadre_gauche:Integer;

    i:Integer;
  begin
  production:=getProduction(curent_zone);
  
  total_materiaux_a_afficher:=0;
  for materiau in Materiaux do
    begin
    if (production[materiau]<>0) and (materiau<>Electricite) then
      inc(total_materiaux_a_afficher);
    end;
  
  cadre_haut:=(BORD_BAS-BORD_HAUT) div 2-total_materiaux_a_afficher-5;
  cadre_bas:=(BORD_BAS-BORD_HAUT) div 2+total_materiaux_a_afficher;
  cadre_gauche:=(BORD_DROIT-BORD_GAUCHE) div 2-40;
  cadre_droite:=(BORD_DROIT-BORD_GAUCHE) div 2+40;

  dessinerCadreXY(cadre_gauche, cadre_haut, cadre_droite, cadre_bas, simple, white, black);
  // Affiche la date
  s:='Bilan du '+GetEnumName(TypeInfo(curent_date.jour), Ord(curent_date.jour))+' '+IntToStr(curent_date.nb_jour)+' '+GetEnumName(TypeInfo(curent_date.mois), Ord(curent_date.mois))+' '+IntToStr(curent_date.annee);
  deplacerCurseurXY((cadre_droite+cadre_gauche-Length(s)) div 2, cadre_haut+1);
  write(s);
  
  if (total_materiaux_a_afficher=0) then
    begin
    s:='Aucun changement dans les materiaux aujourd''hui';
    deplacerCurseurXY(((cadre_gauche+cadre_droite-Length(s)) div 2 ), cadre_haut+3);
    write(s);
    end
  else
    begin
    i:=0;
    for materiau in Materiaux do
      begin
      if (production[materiau]<>0) and (materiau<>Electricite) then
        begin
        s:=GetEnumName(TypeInfo(curent_date.jour), Ord(curent_date.jour)) + ' :';
        deplacerCurseurXY(((cadre_gauche+cadre_droite) div 2 )-Length(s)-10, cadre_haut+3+i*2);
        write(materiau);
        if production[materiau]>0 then
          couleurTexte(Green)
        else if production[materiau]<0 then
          couleurTexte(Red);
        deplacerCurseurXY(((cadre_gauche+cadre_droite) div 2 )+10, cadre_haut+3+i*2);
        write(production[materiau]);
        couleurTexte(White);
        inc(i);
        end;
      end;
    end;
  SonBilan();
  readln;
  end;

// .................................._....____._____.___.___.._..._.____..
// ................................./.\../.___|_..._|_._/._.\|.\.|./.___|.
// ................................/._.\|.|.....|.|..|.|.|.|.|..\|.\___.\.
// .............................../.___.\.|___..|.|..|.|.|_|.|.|\..|___).|
// ............................../_/...\_\____|.|_|.|___\___/|_|.\_|____/.

procedure AfficherActions();
  begin
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+4));
    writeln('[1] Gestion des bâtiments');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+5));
    writeln('[2] Explorer la zone');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+6));
    writeln('[3] Changer de zone');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln('[4] Transferer des ressources');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+8));
    writeln('[5] Passer la journée');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9));
    writeln('[6] Missions');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[7] Wiki');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+11));
    writeln('[0] Quitter la partie');
    UTF8(False);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

procedure AfficherMenuActionBatiments();
  begin
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+4));
    UTF8(True);
    writeln('[1] Construire un bâtiment');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+5));
    writeln('[2] Améliorer un bâtiment');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+6));
    writeln('[3] Changer la production');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln('[4] Réparer un bâtiment');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+8));
    writeln('[0] Retour');
    UTF8(False);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));

    UTF8(False);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

procedure AfficherMenuBatiment();
  begin
    SonInteraction();
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln('Que voulez vous construire ?');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9));
    writeln('[1] Mine');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[2] Usine');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+11));
    writeln('[3] Centrale');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[4] Ascenseur Orbitale');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+13));
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
      dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
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
      deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
      couleurTexte(White);
      SonErreur();
  end;

procedure AfficherQuestionInformation(msg:String);
  {Affiche un message ainsi qu'une boite de réponse}
  begin
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln(msg);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-8),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-6),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-7));
  end;

procedure AfficherMenuZoneAvecMessage(msg:String);
  begin
    SonInteraction();
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    UTF8(True);
    writeln(msg);
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

procedure AfficherMenuMateriauxAvecMessage(msg:String; n:Integer);
  {Affiche un menu permettant au joueur de séléctionner un matériaux (sauf éléctricité), ainsi qu'un message}
  var
  i:Integer;
  begin
    SonInteraction();
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    UTF8(True);
    writeln(msg);
    i:=n;
    while (i<5+n) and (i<ord(high(Materiaux))) do
      begin
      deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9+i-n));
      writeln('[', i-n,'] ',Materiaux(i));
      inc(i);
      end;
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9+i-n));
    writeln('[5] Autre');

    UTF8(False);
    dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
  end;

procedure AfficherMenuMateriauxTransformer();
  var
    m: Materiaux;
    i, startY: Integer; 
  begin
    startY := (SCREEN_HEIGHT div 2) + 3; // Pos de départ
    i := 1; // Num à partir de 1

    SonInteraction();

    // Dessine le cadre
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);
    
    UTF8(True);
    
    // Affiche le titre
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34), startY + (i - 1)-2);
    writeln('Que voulez vous produire ?');
    
    // Affiche les matériaux transformés uniquement
    for m in Materiaux do 
      begin
        if (m <> Electricite) and (m <> Hematite) and (m <> Chalcocite) and (m <> Regolitique) and (m <> Pyrolyte) then
          begin
            deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34), startY + (i - 1));
            writeln('[', i, '] ', m);
            i := i + 1;
          end;
          UTF8(False);
        dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
        deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
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

procedure AfficherMenuWikiBatiment();
  begin
    SonInteraction();

    effacerEcran();
    dessinerCadreXY(2, 1, (SCREEN_WIDTH-1), (SCREEN_HEIGHT-2), simple, white, black); // TAILLE DE BASE
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL,1,(SCREEN_WIDTH -1),(SCREEN_HEIGHT-2),double,white,black);
    
    {---------Titre---------}
    
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| WIKI BATIMENTS |>')div 2),1);
    writeln('<| WIKI BATIMENTS |>');

    {---------Mine---------}

    deplacerCurseurXY(5,3);
    couleurTexte(Blue);
    writeln('Mine');

    // Niveaux
    deplacerCurseurXY(8,4);
    couleurTexte(LightBlue);
    writeln('Niveau');

    couleurTexte(White);
    deplacerCurseurXY(8,6);
    writeln('1');
    deplacerCurseurXY(8,7);
    writeln('2');
    deplacerCurseurXY(8,8);
    writeln('3');

    // Prix
    deplacerCurseurXY(30,4);
    couleurTexte(LightBlue);
    write('Coût');

    couleurTexte(White);
    deplacerCurseurXY(30,6);
    writeln('x10 Plaque');
    deplacerCurseurXY(30,7);
    writeln('x20 Plaque / x20 Régolithe');
    deplacerCurseurXY(30,8);
    writeln('x20 Plaque / x20 Alliage');

    // Consommation
    deplacerCurseurXY(112,4);
    couleurTexte(LightBlue);
    writeln('Consommation');

    couleurTexte(White);
    deplacerCurseurXY(112,6);
    writeln('100 énergie');
    deplacerCurseurXY(112,7);
    writeln('100 énergie');
    deplacerCurseurXY(112,8);
    writeln('100 énergie');

    {---------Usine---------}

    deplacerCurseurXY(5,11);
    couleurTexte(Blue);
    writeln('Usine');

    // Niveaux
    deplacerCurseurXY(8,12);
    couleurTexte(LightBlue);
    writeln('Niveau');

    couleurTexte(White);
    deplacerCurseurXY(8,14);
    writeln('1');
    deplacerCurseurXY(8,15);
    writeln('2');
    deplacerCurseurXY(8,16);
    writeln('3');

    // Prix
    deplacerCurseurXY(30,12);
    couleurTexte(LightBlue);
    write('Coût');

    couleurTexte(White);
    deplacerCurseurXY(30,14);
    writeln('x10 Câbles / x10 Plaque');
    deplacerCurseurXY(30,15);
    writeln('x20 Plaque / x20 Régolithe');
    deplacerCurseurXY(30,16);
    writeln('x20 Plaque / x20 Alliage ');

    // Consommation
    deplacerCurseurXY(112,12);
    couleurTexte(LightBlue);
    writeln('Consommation');
    
    couleurTexte(White);
    deplacerCurseurXY(112,14);
    writeln('200 énergie');
    deplacerCurseurXY(112,15);
    writeln('200 énergie');
    deplacerCurseurXY(112,16);
    writeln('200 énergie');

    {---------QG Spacial---------}

    deplacerCurseurXY(5,19);
    couleurTexte(Blue);
    writeln('QG Spacial');

    // Consommation
    deplacerCurseurXY(112,20);
    couleurTexte(LightBlue);
    writeln('Consommation');
    
    couleurTexte(White);
    deplacerCurseurXY(112,22);
    writeln('100 énergie');

    {---------Générateur Thermique F-1---------}

    deplacerCurseurXY(5,24);
    couleurTexte(Blue);
    writeln('Générateur Thermique F-1');

    // Niveau
    deplacerCurseurXY(8,25);
    couleurTexte(LightBlue);
    writeln('Niveau');

    couleurTexte(White);
    deplacerCurseurXY(8,27);
    writeln('1');

    // Prix
    deplacerCurseurXY(30,25);
    couleurTexte(LightBlue);
    write('Coût');

    couleurTexte(White);
    deplacerCurseurXY(30,27);
    writeln('x30 Câbles / x10 Plaque  / x20 Régolithe');

    // Consommation
    deplacerCurseurXY(112,25);
    couleurTexte(LightBlue);
    writeln('Consommation');

    couleurTexte(White);
    deplacerCurseurXY(112,27);
    writeln('1200 énergie');

    {---------Structure d'Expédition Sol-Orbital---------}

    deplacerCurseurXY(5,31);
    couleurTexte(Blue);
    writeln('Structure d''Expédition Sol-Orbital');

    // Niveau
    deplacerCurseurXY(8,32);
    couleurTexte(LightBlue);
    writeln('Niveau');

    couleurTexte(White);
    deplacerCurseurXY(8,34);
    writeln('1');

    // Prix
    deplacerCurseurXY(30,32);
    couleurTexte(LightBlue);
    write('Coût');

    couleurTexte(White);
    deplacerCurseurXY(30,34);
    writeln('x200 Câbles / x200 Plaque / x200 Régolithe');

    // Consommation
    deplacerCurseurXY(112,32);
    couleurTexte(LightBlue);
    writeln('Consommation');

    couleurTexte(White);
    deplacerCurseurXY(112,34);
    writeln('1000 énergie');

    deplacerCurseurXY(5,(SCREEN_HEIGHT-3));
    writeln('Source : Karine Serier');

    // Navigation ACTIONS
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');
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



procedure AfficherMenuWikiProduction();
  begin
    SonInteraction();

    effacerEcran();
    dessinerCadreXY(2, 1, (SCREEN_WIDTH-1), (SCREEN_HEIGHT-2), simple, white, black); // TAILLE DE BASE
    dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL,1,(SCREEN_WIDTH -1),(SCREEN_HEIGHT-2),double,white,black);
    
    {---------Titre---------}
    
    UTF8(True);
    deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| WIKI PRODUCTION |>')div 2),1);
    writeln('<| WIKI PRODUCTION |>');

    {---------Matériaux---------}

    deplacerCurseurXY(8,4);
    couleurTexte(LightBlue);
    writeln('Matériaux');

    couleurTexte(White);
    deplacerCurseurXY(8,7);
    writeln('Cuivre');
    deplacerCurseurXY(8,9);
    writeln('Fer');
    deplacerCurseurXY(8,11);
    writeln('Câbles');
    deplacerCurseurXY(8,13);
    writeln('Plaque');
    deplacerCurseurXY(8,15);
    writeln('Conduits');
    deplacerCurseurXY(8,17);
    writeln('Fixateur');
    deplacerCurseurXY(8,19);
    writeln('Alliage');
    deplacerCurseurXY(8,21);
    writeln('Panneaux');
    deplacerCurseurXY(8,23);
    writeln('Poutres');
    deplacerCurseurXY(8,25);
    writeln('Dalles');

    {---------Quantité produite par lot---------}

    deplacerCurseurXY(50,4);
    couleurTexte(LightBlue);
    write('Quantité de production par lot');

    couleurTexte(White);
    deplacerCurseurXY(50,7);
    writeln('15 Lingots');
    deplacerCurseurXY(50,9);
    writeln('15 Lingots');
    deplacerCurseurXY(50,11);
    writeln('5 Câbles');
    deplacerCurseurXY(50,13);
    writeln('10 Plaque');
    deplacerCurseurXY(50,15);
    writeln('10 Conduits');
    deplacerCurseurXY(50,17);
    writeln('5 Sacs');
    deplacerCurseurXY(50,19);
    writeln('15 Alliages');
    deplacerCurseurXY(50,21);
    writeln('2 Panneaux');
    deplacerCurseurXY(50,23);
    writeln('2 Poutres');
    deplacerCurseurXY(50,25);
    writeln('2 Dalles');

    {---------Ressources nécessaires à la production---------}

    deplacerCurseurXY(90,4);
    couleurTexte(LightBlue);
    writeln('Ressources nécessaires');

    couleurTexte(White);
    deplacerCurseurXY(90,7);
    writeln('x30 Chalcocite');
    deplacerCurseurXY(90,9);
    writeln('x30 Hématite');
    deplacerCurseurXY(90,11);
    writeln('x15 Cuivre');
    deplacerCurseurXY(90,13);
    writeln('x60 Fer');
    deplacerCurseurXY(90,15);
    writeln('x30 Fer');
    deplacerCurseurXY(90,17);
    writeln('x15 Régolitique');
    deplacerCurseurXY(90,19);
    writeln('x30 Hématite / x15 Pyrolyté');
    deplacerCurseurXY(90,21);
    writeln('x20 Plaque / x20 Alliage');
    deplacerCurseurXY(90,23);
    writeln('x20 Plaque / x15 Régolithe');
    deplacerCurseurXY(90,25);
    writeln('x30 Régolithe');

    deplacerCurseurXY(5,(SCREEN_HEIGHT-3));
    writeln('Source : Sabine Vaudeville');

    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10))-(Length('ACTIONS')div 2),((SCREEN_HEIGHT div 2)));
    writeln('ACTIONS');
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

procedure AfficherMenuMissions(miss:MissionsActives; zone_actuelle:Zone);
 var
   i: Integer; // Compteur pour les missions (0 à 2)
   j: Materiaux; // Itérateur sur le type Materiaux
   LigneRessource: Integer; // Gère la position verticale pour l'affichage des ressources
   Quantite: Integer; // Pour stocker la quantité requise
 
 begin
  SonInteraction();

  effacerEcran();
  dessinerCadreXY(BORD_GAUCHE, BORD_HAUT, BORD_DROIT, BORD_BAS, simple, white, black); 
  dessinerCadreXY(BORD_GAUCHE, BORD_HAUT, SEPARATION_ECRAN_INVENTAIRE_PRINCIPAL, BORD_BAS, double, white, black);
  dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL, BORD_HAUT, BORD_DROIT, BORD_BAS, double, white, black);

  AfficherInventaireZone(zone_actuelle);

  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| MISSIONS |>')div 2),1);
  writeln('<| MISSIONS |>');

  // CADRES
     if (miss[0].accompli) = True then
     begin
       couleurTexte(Green);
     end;


  dessinerCadreXY((SCREEN_WIDTH div 5)+3, 2, ((SCREEN_WIDTH div 5)*2-2), SCREEN_HEIGHT-4, simple, white, black);
    // CADRES
     if (miss[1].accompli) = True then
     begin
       couleurTexte(Green);
     end;
  dessinerCadreXY(((SCREEN_WIDTH div 5)*2+1), 2, ((SCREEN_WIDTH div 5)*3-2), SCREEN_HEIGHT-4, simple, white, black);
    // CADRES
     if (miss[2].accompli) = True then
     begin
       couleurTexte(Green);
     end;
  dessinerCadreXY(((SCREEN_WIDTH div 5)*3)+1, 2, ((SCREEN_WIDTH div 5)*4-3), SCREEN_HEIGHT-4, simple, white, black);
  UTF8(True);
  
   // --- BOUCLE PRINCIPALE POUR LES 3 MISSIONS (i=0, 1, 2) ---
  for i := 0 to 2 do
  begin
  
   // 1. TITRE DE LA MISSION
   DeplacerCurseurXY((5 + (SCREEN_WIDTH div 5)*(2*i + 3)) div 2 - 5, 4);
   couleurTexte(yellow);
   write('MISSION ', i + 1);
   couleurTexte(white);

   // 2. TITRE DES RESSOURCES
   DeplacerCurseurXY(((SCREEN_WIDTH div 5)*(2*i + 3)) div 2 - 14, 8);
   write('Ressources necessaires');
   
   // 3. AFFICHAGE DES RESSOURCES NÉCESSAIRES
   LigneRessource := 10; 
   couleurTexte(White);
   
   // Itération sur l'énumération Materiaux
   for j in Materiaux do
   begin
     if j <> Electricite then
     begin
       Quantite := miss[i].ressources[j];
       
       // On affiche la ressource seulement si la quantité requise est > 0
       if Quantite > 0 then
       begin
         DeplacerCurseurXY(((SCREEN_WIDTH div 5)*(2*i + 3)) div 2 - 14, LigneRessource);
         writeln(' - ', j, ' x', Quantite); 
         
         LigneRessource := LigneRessource + 1;
       end;
     end;
   end;
     
   // Ajout d'une ligne de séparation
   LigneRessource := LigneRessource + 1; 
   
   // 4. RÉCOMPENSE
   DeplacerCurseurXY(((SCREEN_WIDTH div 5)*(2*i + 3)) div 2 - 14, 32);
   write('Récompense : ',miss[i].points,'€');

   // 5. ÉTAT
   DeplacerCurseurXY(((SCREEN_WIDTH div 5)*(2*i + 3)) div 2 - 14, 35);
   couleurTexte(white);
   write('Etat : ');
   if (miss[i].accompli) = True then
   begin
   couleurTexte(Green);
   writeln('Terminé');
   end
   else
   begin
   couleurTexte(Red);
   writeln('En cours...');
      couleurTexte(White);
   end;
  end; // Fin de la boucle For i
   
   // --- SECTION DU BAS (Commandes) ---
  deplacerCurseurXY((SCREEN_WIDTH div 4)-7,(SCREEN_HEIGHT-3));
  writeln('Emetteur : Frank Deher');
  deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+8));
  writeln('[1] Accomplir une mission');
  deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
  writeln('[2] Boutique');
  deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
  writeln('[0] Revenir au jeu');
  UTF8(False);
  dessinerCadreXY((SCREEN_WIDTH div 5+1)*4,(SCREEN_HEIGHT-5),(SCREEN_WIDTH -4),(SCREEN_HEIGHT-3),simple,white,black);
  deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10)),((SCREEN_HEIGHT )-4));
 end;


procedure AfficherMenuBoutique();
begin
  SonInteraction();

  effacerEcran();
  dessinerCadreXY(2, 1, (SCREEN_WIDTH-1), (SCREEN_HEIGHT-2), simple, white, black); // TAILLE DE BASE
  dessinerCadreXY(SEPARATION_ECRAN_INFO_PRINCIPAL,1,(SCREEN_WIDTH -1),(SCREEN_HEIGHT-2),double,white,black);
  UTF8(True);
  deplacerCurseurXY((SCREEN_WIDTH div 2)-(Length('<| BOUTIQUE |>')div 2),1);
  writeln('<| BOUTIQUE |>');
  UTF8(False);
  // Cadre 1
  dessinerCadreXY(4,2,(SCREEN_WIDTH)-(SCREEN_WIDTH div 4)+8,(SCREEN_HEIGHT div 3),simple,white,black);
  // Cadre 2
  dessinerCadreXY(4,(SCREEN_HEIGHT div 3)+1,(SCREEN_WIDTH)-(SCREEN_WIDTH div 4)+8,(SCREEN_HEIGHT div 3)*2-1,simple,white,black);
  // cadre 3
  dessinerCadreXY(4,(SCREEN_HEIGHT-(SCREEN_HEIGHT div 3)-1),(SCREEN_WIDTH)-(SCREEN_WIDTH div 4)+8,SCREEN_HEIGHT-3,simple,white,black);
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+7));
    writeln('Que voulez-vous acheter?'); 
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+9));
    writeln('[1] Boost1');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+10));
    writeln('[2] Boost2');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+11));
    writeln('[3] Boost3');
    deplacerCurseurXY((SCREEN_WIDTH-(SCREEN_WIDTH div 10) div 10-34),((SCREEN_HEIGHT div 2)+12));
    writeln('[0] Revenir au jeu');
end;

end.
