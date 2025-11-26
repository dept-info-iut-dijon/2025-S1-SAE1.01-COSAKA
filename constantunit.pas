unit constantUnit;

interface
  type
    // Materiaux que l'on peut récolter
    Materiaux=(Fer, Cuivre);

    // Batiment que l'ont peut construire
    Batiment=(Hub, Gisement, Mine);
    
    // Les structures que pourront contenir les emplacements (représente un emplacement en quelque sorte)
    Structure=record
      type_structure:Batiment;
      niveau:Integer;
      est_decouvert:Boolean;
      materiaux:Materiaux;
      // Il faudrat sûrement rajouter des choses par la suite
    end;

    // Une zone du jeu, contenant par défaut 10 emplacements
    Zone=record
      numero:Integer;
      nom:String;
      emplacements:Array[0..9] of Structure;
    end;
  
  const
    SCREEN_WIDTH=200;
    SCREEN_HEIGHT=40;

    EMPLACEMENTS_PAR_ZONE=10;


    MINERAI1=Fer;   // Minerai le plus courant
    MINERAI2=Cuivre;  // 2ème Minerai le plus courant

    NOM_ZONE1='L Antre de Marzani';
    NOM_ZONE2='La Caverne Simmonet';
    NOM_ZONE3='La Montagne Coulon';

implementation

end.