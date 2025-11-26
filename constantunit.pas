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
      production:Integer;
      // Il faudrat sûrement rajouter des choses par la suite
    end;

    // Une zone du jeu, contenant par défaut 10 emplacements
    Zone=record
      numero:Integer;
      nom:String;
      emplacements:Array[0..9] of Structure;
      minerais:Array[0..2] of Materiaux;
      inventaire:Array[Fer..Cuivre] of Integer;
    end;
  
  const
    SCREEN_WIDTH=200;
    SCREEN_HEIGHT=40;



    MINERAI1=Fer;   // Minerai le plus courant
    MINERAI2=Cuivre;  // 2ème Minerai le plus courant

    PRODUCTION_BASE:array[Fer..Cuivre] of Integer=(10, 15);

    NOM_ZONE1='L Antre de Marzani';
    NOM_ZONE2='La Caverne Simmonet';
    NOM_ZONE3='La Montagne Coulon';

implementation

end.