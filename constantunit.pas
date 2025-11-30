unit constantUnit;

interface
  uses classes,sysutils;

  type
    // Materiaux que l'on peut récolter
    Materiaux = (
    FragmentDeChalcocite,
    MineraiDHematite,
    ArgileRegolitique,
    CarbonePyrolyte,
    
    LingotsDeCuivre,
    LingotsDeFer,
    PlaquesStandard,
    CablesDeCuivre,
    ConduitsDeFluide,
    SacsDeRegolitheFixateur,
    AlliageCryogenique,
    PanneauxADensiteOptimale,
    PoutresDeSoutenement,
    DallesDeStabilite,
    Electricite
    );

    // Batiment que l'ont peut construire
    Batiment=(Vide, Hub, Gisement, Mine, Usine, Centrale, AscenseurOrbital);

    TableauMateriaux=Array[Materiaux] of Integer;
    
    // Les structures que pourront contenir les emplacements (représente un emplacement en quelque sorte)
    Structure=record
      type_structure:Batiment;
      niveau:Integer;
      est_decouvert:Boolean;
      materiaux:Materiaux;
      production:Integer;
      consommable:TableauMateriaux;
      panne:Boolean;
      // Il faudrat sûrement rajouter des choses par la suite
    end;

    Emplacements=Array[0..9] of Structure;

    // Une zone du jeu, contenant par défaut 10 emplacements
    Zone=record
      numero:Integer;
      nom:String;
      emplacements:Emplacements;
      minerais:Array[0..2] of Materiaux;
      inventaire:TableauMateriaux;
    end;

    Mois=(Janvier, Fevrier, Mars, Avril, 
          Mai, Juin, Juillet, Aout, Septembre, 
          Octobre, Novembre, Decembre);
    
    Jour=(Lundi, Mardi, Mercredi, Jeudi, Vendredi, Samedi, Dimanche);

    Date=record
      annee:Integer;
      mois:Mois;
      nb_jour:Integer;
      jour:Jour;
    end;

    ZonesJeu=Array[0..2] of Zone;

    Mission=record
      ressources:TableauMateriaux;
      points:Integer;
      accompli:Boolean;
    end;

    MissionsActives=Array[0..2] of Mission;
  
  const
    SCREEN_WIDTH=200;
    SCREEN_HEIGHT=40;
    
    BORD_HAUT = 1;  // Position y de la bordure haute de l'interface du jeu.
    BORD_BAS = SCREEN_HEIGHT-2;    // Position y de la bordure basse de l'interface du jeu.
    BORD_GAUCHE = 2;  // Position x de la bordure gauche de l'interface du jeu.
    BORD_DROIT = SCREEN_WIDTH-1;  // Position x de la bordure droite de l'interface du jeu.

    // Coordonée X de la séparation entre l'affichage de l'inventaire et l'affichage principal
    SEPARATION_ECRAN_INVENTAIRE_PRINCIPAL = SCREEN_WIDTH div 5;
    // Coordonée X de la séparation entre l'affichage des informations et l'affichage principal
    SEPARATION_ECRAN_INFO_PRINCIPAL = (SCREEN_WIDTH div 5)*4;
    

    MINERAI1=MineraiDHematite;   // Minerai le plus courant
    MINERAI2=FragmentDeChalcocite;  // 2ème Minerai le plus courant

    CONSOMMATION0:TableauMateriaux=(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);  // Un tableau de consommation où rien est consommé (tout = à 0)

    PRODUCTION_BASE:array[Materiaux] of Integer=(10, 15, 10, 10, // La production de base des Mines, Usines et Générateurs
                                                 10, 10, 10, 5, 
                                                 10, 10, 10, 10, 
                                                 10, 10, 1000);

                                                                                     // Niveau 1
    CONSTRUCTION_BASE:Array[1..3] of Array[Batiment] of array[Materiaux] of Integer=(((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Vide
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Hub
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Gisement
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Mine
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Usine
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Centrale
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)),    // AscenseurOrbital
                                                                                     // Niveau 2
                                                                                     ((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Vide
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Hub
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Gisement
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Mine
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Usine
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Centrale
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)),    // AscenseurOrbital
                                                                                     // Niveau 3
                                                                                     ((0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Vide
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Hub
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Gisement
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Mine
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Usine
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Centrale
                                                                                      (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)));  // AscenseurOrbital

    CONSOMMABLE_BASE:Array[Materiaux] of TableauMateriaux=((0,0,0,0,0,0,0,0,0,0,0,0,0,0,100),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,100),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,100),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,100),
                                                       (30,0,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,30,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,60,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,15,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,150),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0));

    NOM_ZONE1='L''Antre de Marzani';
    NOM_ZONE2='La Caverne Simmonet';
    NOM_ZONE3='La Montagne Coulon';
    
    NOM_MONNAIE='Si-Monnaie';

    // Constante utiles pour naviguer dans les menus
    QUITTER='0';
    CONSTRUIRE='1';
    CHANGER_PRODUCTION='2';
    AMELIORER='3';
    EXPLORER='4';
    CHANGER_ZONE='5';
    TRANSFERT_RESSOURCES='6';
    PASSER_JOURNEE='7';
    MISSIONS='8';
    WIKI='9';

    MATERIAUX_PREMIERS='4';
    MATERIAUX_AUTRES='1';
    MATERIAUX_TRANSFORMES='9';
    NBR_BATIMENTS_AMELIORABLES='3';

    // Sert dans les menus affichés en plusieurs fois.
    AUTRE='5';

implementation

end.