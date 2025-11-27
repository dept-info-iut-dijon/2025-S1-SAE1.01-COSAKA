unit constantUnit;

interface
  type
    // Materiaux que l'on peut récolter
    Materiaux=(Fer, Cuivre, Calcaire, Charbon, LingotFer, LingotCuivre, 
                PlaqueFer, TuyauFer, SacBeton, Acier, PlaqueRenforcee, 
                PoutreIndustrielle, Fondations, Electricite);

    // Batiment que l'ont peut construire
    Batiment=(Vide, Hub, Gisement, Mine, Usine, Centrale);

    Consommation=Array[Materiaux] of Integer;
    
    // Les structures que pourront contenir les emplacements (représente un emplacement en quelque sorte)
    Structure=record
      type_structure:Batiment;
      niveau:Integer;
      est_decouvert:Boolean;
      materiaux:Materiaux;
      production:Integer;
      consommable:Consommation;
      // Il faudrat sûrement rajouter des choses par la suite
    end;

    Emplacements=Array[0..9] of Structure;

    // Une zone du jeu, contenant par défaut 10 emplacements
    Zone=record
      numero:Integer;
      nom:String;
      emplacements:Emplacements;
      minerais:Array[0..2] of Materiaux;
      inventaire:Array[Materiaux] of Integer;
    end;
  
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
    

    MINERAI1=Fer;   // Minerai le plus courant
    MINERAI2=Cuivre;  // 2ème Minerai le plus courant

    CONSOMMATION0:Consommation=(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);  // Un tableau de consommation où rien est consommé (tout = à 0)

    PRODUCTION_BASE:array[Materiaux] of Integer=(10, 15, 10, 10, // La production de base des Mines, Usines et Générateurs
                                                 10, 10, 10, 10, 
                                                 10, 10, 10, 10, 
                                                 10, 10);

                                                                                    // Niveau 1
    CONSTRUCTION_BASE:Array[1..3] of Array[Batiment] of array[Materiaux] of Integer=(((0,0,0,0,0,0,0,0,0,0,0,0,0,0),  // Vide
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Hub
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Gisement
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Mine
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Usine
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0)),   // Centrale
                                                                                    // Niveau 2
                                                                                    ((0,0,0,0,0,0,0,0,0,0,0,0,0,0),   // Vide
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Hub
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Gisement
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Mine
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Usine
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0)),   // Centrale
                                                                                    // Niveau 3
                                                                                    ((0,0,0,0,0,0,0,0,0,0,0,0,0,0),   // Vide
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Hub
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Gisement
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Mine
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0),    // Usine
                                                                                    (0,0,0,0,0,0,0,0,0,0,0,0,0,0)));  // Centrale

    CONSOMMABLE_BASE:Array[Materiaux] of Consommation=((0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                                                       (0,0,0,0,0,0,0,0,0,0,0,0,0,0));

    NOM_ZONE1='L Antre de Marzani';
    NOM_ZONE2='La Caverne Simmonet';
    NOM_ZONE3='La Montagne Coulon';
    
    

    StructureTest:Structure = (
                    type_structure:Hub;
                    niveau:1;
                    est_decouvert:True;
                    materiaux:Fer;
                    production:800;
                    consommable:(0,0,0,0,0,0,0,0,0,0,0,0,0,0));

    ZoneTest:Zone = (
                    numero:1;
                    nom:'SabineLaGoat';
                 //   emplacements:();
                 //   minerais:(Fer,Cuivre,Calcaire);
                   // inventaire:(0,0,0,0,0,0,0,0,0,0,0,0,0,0)
                   ); 

  //  StructureTest:Structure = (
    //                type_structure:Hub;
      //              niveau:1;
        //            est_decouvert:True;
          //          materiaux:Fer;
            //        production:800;
              //      consommable:(0,0,0,0,0,0,0,0,0,0,0,0,0,0));

   // ZoneTest:Zone = (
     //               numero:1;
      //              nom:'SabineLaGoat';
                 //   emplacements:();
                 //   minerais:(Fer,Cuivre,Calcaire);
                   // inventaire:(0,0,0,0,0,0,0,0,0,0,0,0,0,0)
                //   );

implementation

end.