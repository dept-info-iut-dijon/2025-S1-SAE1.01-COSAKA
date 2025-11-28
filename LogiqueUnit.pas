unit LogiqueUnit;
{$mode delphi}{$H+}

interface
uses
  constantunit;

function getEmplacement(zone:Zone):Emplacements;

function ProductionElectricite(zone:Zone):Integer;
function ConsommationElectricite(zone:Zone):Integer;

procedure MainMenu();

implementation
  uses
    SysUtils, Classes, GestionIHM;

procedure setEmplacement(var emplacement:Structure; 
                         new_niveau:Integer; new_est_decouvert:Boolean;
                         new_type_structure:Batiment; new_materiaux:Materiaux;
                         new_production:Integer; new_consommable:Consommation);
  {Définit les valeur des paramètres de l'emplacement 'emplacement'.
  Attention, tous les paramètres doivent être renseignés.}
  begin
    emplacement.type_structure:=new_type_structure;
    emplacement.niveau:=new_niveau;
    emplacement.est_decouvert:=new_est_decouvert;
    emplacement.materiaux:=new_materiaux;
    emplacement.production:=new_production;
    emplacement.consommable:=new_consommable;
  end;

function getEmplacement(zone:Zone):Emplacements;
  {Renvoie la liste des emplacements de la zone passé en paramètre.}
  begin
  getEmplacement:=zone.emplacements;
  end;

function emplacementsSontDifferents(emplacement1:Structure; emplacement2:Structure):Boolean;
  {Renvoie True si les emplacements en paramètres sont différents, False sinon}
  begin
    emplacementsSontDifferents:=(emplacement1.niveau<>emplacement2.niveau) or
                                (emplacement1.est_decouvert<>emplacement2.est_decouvert) or
                                (emplacement1.type_structure<>emplacement2.type_structure) or
                                (emplacement1.materiaux<>emplacement2.materiaux) or
                                (emplacement1.production<>emplacement2.production);
  end;

procedure decouvre(var emplacement:Structure);
  {Découvre l'emplacement placé en paramètre}
  begin
  emplacement.est_decouvert:=True;
  end;

function getIndiceEmplacementNonDecouvertAlea(zone:Zone):Integer;
  {Renvoie un emplacement non découvert de 'zone'.
  Si il n'y en a pas, renvoie le premier emplacement de 'zone'.}
  var
    indice_curent_emplacement:Integer;
    curent_emplacement:Structure;
    a_emplacement_non_decouvert:Boolean;   // Indique si la zone contient au moins un emplacement vide.
  begin
    // Vérifie si la zone possède au moins un emplacement vide.
    indice_curent_emplacement:=low(zone.emplacements);
    curent_emplacement:=zone.emplacements[indice_curent_emplacement];
    a_emplacement_non_decouvert:=false;
    for curent_emplacement in zone.emplacements do
      begin
      if (not curent_emplacement.est_decouvert) then
        begin
        a_emplacement_non_decouvert:=true;
        end;
      end;
    
    // Boucle si au moins un emplacement vide existe et tant qu'aucun n'est trouvé.
    if a_emplacement_non_decouvert then
      begin
      curent_emplacement:=zone.emplacements[indice_curent_emplacement];
      while (curent_emplacement.est_decouvert) do
        begin
        indice_curent_emplacement:=random(9)+1;
        curent_emplacement:=zone.emplacements[indice_curent_emplacement];
        end;
      end;
    getIndiceEmplacementNonDecouvertAlea:=indice_curent_emplacement;
  end;

function getIndiceEmplacementVideAlea(zone:Zone):Integer;
  {Renvoie un emplacement vide de 'zone'.
  Si il n'y en a pas, renvoie le premier emplacement de 'zone'.}
  var
    indice_curent_emplacement:Integer;
    curent_emplacement:Structure;
    a_emplacement_vide:Boolean;   // Indique si la zone contient au moins un emplacement vide.
  begin
    // Vérifie si la zone possède au moins un emplacement vide.
    indice_curent_emplacement:=low(zone.emplacements);
    curent_emplacement:=zone.emplacements[indice_curent_emplacement];
    a_emplacement_vide:=false;
    for curent_emplacement in zone.emplacements do
      begin
      if (curent_emplacement.type_structure=Vide) then
        begin
        a_emplacement_vide:=true;
        end;
      end;
    
    // Boucle si au moins un emplacement vide existe et tant qu'aucun n'est trouvé.
    if a_emplacement_vide then
      begin
      curent_emplacement:=zone.emplacements[indice_curent_emplacement];
      while (curent_emplacement.type_structure<>Vide) do
        begin
        indice_curent_emplacement:=random(9)+1;
        curent_emplacement:=zone.emplacements[indice_curent_emplacement];
        end;
      end;
    getIndiceEmplacementVideAlea:=indice_curent_emplacement;
  end;

procedure ajouteStructureEmplacementAlea(var zone:Zone; niveau:Integer; 
                                         est_decouvert:Boolean; type_structure:Batiment;
                                         materiaux:Materiaux; production:Integer;
                                         consommable:Consommation);
  {Ajoute une structure avec des caractéristiques spécifiés en paramètre
  à un emplacement aléatoire d'une zone.}
  var
    indice:Integer;
  begin
    indice:=getIndiceEmplacementVideAlea(zone);
    // Vérifie que l'emplacement ne soit pas un Hub (car getIndiceEmplacementVideAlea renvoie un hub si elle ne trouve pas d'mplacement vide)
    if emplacementsSontDifferents(zone.emplacements[indice], zone.emplacements[low(zone.emplacements)]) then
      begin
      setEmplacement(zone.emplacements[indice], niveau, est_decouvert, type_structure, materiaux, production, consommable);
      end;
  end;

procedure initEmplacements(var zone:Zone);
  {Fonction qui prend en paramètres une zone
  et qui renvoie cette même zone après avoir
  initialisé tous ses emplacements,  prêts pour le jeu.}
  var
    i:integer;
  begin
    // Définie tous les emplacements par des emplacements vides et non découverts
    for i:=low(zone.emplacements) to high(zone.emplacements) do
      begin
      setEmplacement(zone.emplacements[i], 0, false, Vide, MineraiDHematite, 0, CONSOMMATION0);
      end;
    // Définie le Hub de la zone
    setEmplacement(zone.emplacements[0], 0, true, Hub, MineraiDHematite, 0, CONSOMMATION0);
    // Définie un emplacement avec un gisement du premier minerai de la zone.
    setEmplacement(zone.emplacements[random(8)+1], 3, true, Gisement, zone.minerais[0], 0, CONSOMMATION0);

    
    // Définie un gisement du deuxième minerai de la zone dans un emplacement aléatoire.
    ajouteStructureEmplacementAlea(zone, 2, false, Gisement, zone.minerais[1], 0, CONSOMMATION0);
    
    // A 1/5 chance d'ajouter un deuxième gisement d'un minerai y étant déjà.
    if (random<0.2) then
      begin
      ajouteStructureEmplacementAlea(zone, 2, false, Gisement, zone.minerais[random(1)], 0, CONSOMMATION0);
      end;
    
    if (random<0.5) then
      begin
      ajouteStructureEmplacementAlea(zone, 1, false, Gisement, zone.minerais[random(2)], 0, CONSOMMATION0)
      end;  
  end;

function initZone(numero:Integer; nom:String; minerai1:Materiaux; minerai2:Materiaux; minerai3:Materiaux):Zone;
  var
    new_zone:Zone;
    m:Materiaux;
  begin
    new_zone.numero:=numero;
    new_zone.nom:=nom;
    new_zone.minerais[0]:=minerai1;
    new_zone.minerais[1]:=minerai2;
    new_zone.minerais[2]:=minerai3;
    initEmplacements(new_zone);
    for m:=low(zone.inventaire) to high(zone.inventaire) do
      begin
      new_zone.inventaire[m]:=0;
      end;
    initZone:=new_zone;
  end;

function MateriauxNecessairesConstruction(var zone:Zone; batiment:Batiment; niveau:Integer):Boolean;
  {Fonction qui prend en parametre une zone, un emplacement 
  et un niveau et renvoie Faux si l'inventaire de la zone 
  contient moins de materiaux que le nombre de materiaux 
  qu'il faut pour construire un batiment  et renvoie Vrai sinon}
  var
    materiau:Materiaux;
  begin
    MateriauxNecessairesConstruction := True;
    // Boucle sur chaque materiaux du type Materiaux
    for materiau in Materiaux do
    begin
      // Vérifie que le materiau sur lequel on boucle est necessaire a la construction du batiment
      if (CONSTRUCTION_BASE[niveau][batiment][materiau] > 0) then
      begin
        // Vérifie que l'inventaire de la zone possèdent assez de matériaux
        if (zone.inventaire[materiau] < CONSTRUCTION_BASE[niveau][batiment][materiau]) then
          MateriauxNecessairesConstruction := False;
      end;
    end;
  end;

procedure SuppressionMateriauxConstruction(var zone:Zone; batiment:Batiment; niveau:Integer);
  {Procédure qui prend en parametre une zone, un emplacement et 
  un niveau et enleve les matériaux necessaires pour la construction
  d'un batiment à l'inventaire de la zone}
  var
    materiau:Materiaux;
  begin
    // Boucle sur chaque materiaux du type Materiaux
    for materiau in Materiaux do
    begin
      // Vérifie que le materiau sur lequel on boucle est necessaire a la construction du batiment
      if (CONSTRUCTION_BASE[niveau][batiment][materiau] > 0) then
      begin
        // Supprime les matériaux nécessaire a la construction de l'inventaire
        zone.inventaire[materiau] :=  zone.inventaire[materiau] - CONSTRUCTION_BASE[niveau][batiment][materiau];
      end;
    end;
  end;

procedure creerMine(var zone:Zone; emplacement:Integer);
  {Procédure qui prend en paramètre un emplacement et 
  une zone et qui modifie ce même emplacement en changeant 
  le type de la structure en 'Mine', en initialisant le 
  niveau de la structure à 1, en supprimant les coûts de 
  la construction de l'inventaire de la zone, en 
  initialisant l'énergie consommé du batiment et en 
  initialisant la production de base du batiment}
  const
    // Initialise le nouveau niveau à 1
    NOUVEAU_NIVEAU = 1;
  var
    production:Integer;
    possedeMateriauxNecessaires:Boolean;
  begin
    // Vérifie si le type de struture est bien un Gisement
    if (zone.emplacements[emplacement].type_structure=Gisement) then
    begin
      // Vérifie que la zone possede les materiaux necessaires a la construction du batiment
      possedeMateriauxNecessaires := MateriauxNecessairesConstruction(zone, Mine, NOUVEAU_NIVEAU);
      if possedeMateriauxNecessaires then
      begin
        // Supprime les materiaux necessaire a la construction du batiment de l'inventaire de la zone
        SuppressionMateriauxConstruction(zone, Mine, NOUVEAU_NIVEAU);

        // Calcul de la production selon le niveau du Gisement
        production := round(PRODUCTION_BASE[zone.emplacements[emplacement].materiaux]);

        // Modifie l'emplacement avec les nouveaux paramètres
        setEmplacement(zone.emplacements[emplacement], NOUVEAU_NIVEAU, zone.emplacements[emplacement].est_decouvert, 
                        Mine, zone.emplacements[emplacement].materiaux, production, CONSOMMABLE_BASE[zone.emplacements[emplacement].materiaux]);
      end
      else
      begin
        // Affiche le message d'erreur
        AfficherActionInformation('Vous n''avez pas les materiaux necessaires');
        readln;
      end;
    end
    else
    begin
      // Affiche le message d'erreur
      AfficherActionInformation('Vous devez impérativement placer une mine sur un gisement');
      readln;
    end;
  end;

procedure creerUsine(var zone:Zone; emplacement:Integer; nouveau_materiaux:Materiaux);
  {{Procédure qui prend en paramètre un emplacement, une zone 
  et un nouveau materiau qui modifie ce même emplacement en changeant 
  le type de la structure en 'Usine', en initialisant le 
  niveau de la structure à 1, en supprimant les coûts de 
  la construction de l'inventaire de la zone, en initialisant 
  l'énergie consommé du batiment et en initialisant la production 
  de base du batiment }
  const
    NOUVEAU_NIVEAU = 1;
  var
    possedeMateriauxNecessaires:Boolean;
  begin
    // Vérifie que la zone possede les materiaux necessaires a la construction du batiment
    possedeMateriauxNecessaires := MateriauxNecessairesConstruction(zone, Usine, NOUVEAU_NIVEAU);
    if possedeMateriauxNecessaires then
    begin
      // Supprime les materiaux necessaire a la construction du batiment de l'inventaire de la zone
      SuppressionMateriauxConstruction(zone, Usine, NOUVEAU_NIVEAU);
      
      // Modifie l'emplacement en mettant les parametres voulu, en initialisant la production et les consommables de base de l'usine
      setEmplacement(zone.emplacements[emplacement], NOUVEAU_NIVEAU, zone.emplacements[emplacement].est_decouvert, 
                      Usine, nouveau_materiaux, PRODUCTION_BASE[nouveau_materiaux], CONSOMMABLE_BASE[nouveau_materiaux]);
    end
    else
    begin
      // Affiche le message d'erreur
      AfficherActionInformation('Vous n''avez pas les materiaux necessaires');
      readln;
    end;
  end;

procedure creerCentrale(var zone:Zone; var emplacement:Integer);
  {{Procédure qui prend en paramètre un emplacement, une zone 
  et un nouveau materiau qui modifie ce même emplacement en changeant 
  le type de la structure en 'Usine', en initialisant le 
  niveau de la structure à 1, en supprimant les coûts de 
  la construction de l'inventaire de la zone, en initialisant 
  l'énergie consommé du batiment et en initialisant la production 
  de base du batiment }
  const
    NOUVEAU_NIVEAU = 1;
  var
    possedeMateriauxNecessaires:Boolean;
  begin
    // Vérifie que la zone possede les materiaux necessaires a la construction du batiment
    possedeMateriauxNecessaires := MateriauxNecessairesConstruction(zone, Centrale, NOUVEAU_NIVEAU);
    if possedeMateriauxNecessaires then
    begin
      // Supprime les materiaux necessaire a la construction du batiment de l'inventaire de la zone
      SuppressionMateriauxConstruction(zone, Centrale, NOUVEAU_NIVEAU);
      
      // Modifie l'emplacement en mettant les parametres voulu, en initialisant la production et les consommables de base de l'usine
      setEmplacement(zone.emplacements[emplacement], NOUVEAU_NIVEAU, zone.emplacements[emplacement].est_decouvert, 
                      Centrale, Electricite, PRODUCTION_BASE[Electricite], zone.emplacements[emplacement].consommable);
    end
    else
    begin
      // Affiche le message d'erreur
      AfficherActionInformation('Vous n''avez pas les materiaux necessaires');
      readln;
    end;
  end;

procedure ChangementUsine(var zone:Zone; emplacement:Integer; nouveau_materiaux:Materiaux);
  {}
  var
    niveau:Integer;
    production:Integer;
  begin
    niveau := zone.emplacements[emplacement].niveau;

    production := round(PRODUCTION_BASE[zone.emplacements[emplacement].materiaux]*1.5*niveau);

    // Modifie l'emplacement en mettant les parametres voulu, en initialisant la production et les consommables de base de l'usine
    setEmplacement(zone.emplacements[emplacement], zone.emplacements[emplacement].niveau, zone.emplacements[emplacement].est_decouvert, 
                    zone.emplacements[emplacement].type_structure, nouveau_materiaux, production, CONSOMMABLE_BASE[nouveau_materiaux]);
    
    zone.emplacements[emplacement].consommable[Electricite] := round(zone.emplacements[emplacement].consommable[Electricite]*1.5*niveau);
  end;

procedure UpgradeBatiment(var zone:Zone; emplacement:Integer);
  {Procedure qui prend en parametre une zone, un emplacement et 
  un niveau et modifie l'emplacement ce qui permet d'augmenter 
  le niveau du batiment en augmentant sa consommation d'electricité 
  et sa production}
  var
    possedeMateriauxNecessaires:Boolean;
    production:Integer;
    niveau:Integer;
  begin
    niveau:=zone.emplacements[emplacement].niveau+1;
    if niveau <= 3 then
    begin
      // Vérifie que la zone possede les materiaux necessaires a la construction du batiment
      possedeMateriauxNecessaires := MateriauxNecessairesConstruction(zone, zone.emplacements[emplacement].type_structure, niveau);
      if possedeMateriauxNecessaires then
      begin
        // Supprime les materiaux necessaire a la construction du batiment de l'inventaire de la zone
        SuppressionMateriauxConstruction(zone, zone.emplacements[emplacement].type_structure, niveau);

        // Augmente la consommation de l'electricité du batiment
        zone.emplacements[emplacement].consommable[Electricite] := round(zone.emplacements[emplacement].consommable[Electricite]*1.5);

        // Augmente la production du batiment
        production := round(zone.emplacements[emplacement].production*1.5);
        
        // Modifie l'emplacement en mettant nouveaux parametres voulu
        setEmplacement(zone.emplacements[emplacement], niveau, zone.emplacements[emplacement].est_decouvert, 
                        zone.emplacements[emplacement].type_structure, zone.emplacements[emplacement].materiaux, production, zone.emplacements[emplacement].consommable);
      end
      else
      begin
        // Affiche le message d'erreur
        AfficherActionInformation('Vous n''avez pas les materiaux necessaires');
        readln;
      end;
    end
    else
    begin
      AfficherActionInformation('Vous avez atteint le niveau maximum');
      readln;
    end;
  end;

function ProductionElectricite(zone:Zone):Integer;
  {Fonction qui prend en parametre une zone et qui renvoie 
  la somme de la production d'Electricite de la zone}
  var
    emplacement:Structure;
    production:Integer;
  begin
    production := 0;
    // Boucle sur chaque emplacement de la zone
    for emplacement in zone.emplacements do
    begin
      // Vérifie qu'une centrale est sur l'emplacement
      if (emplacement.type_structure = Centrale) then
        // Ajoute la production d'Electricite de la centrale a la production global
        production := production + emplacement.production;
    end;
    ProductionElectricite := production;
  end;

function ConsommationElectricite(zone:Zone):Integer;
  {Fonction qui prend en parametre une zone et qui renvoie 
  la somme de la consommation d'Electricite de la zone}
  var
    emplacement:Structure;
    consommation:Integer;
  begin
    consommation := 0;
    // Boucle sur chaque emplacement de la zone
    for emplacement in zone.emplacements do
    begin
      // Ajoute la consommation d'Electricite du batiment a la consommation global
      consommation := consommation + emplacement.consommable[Electricite];
    end;
    ConsommationElectricite := consommation;
  end;


function MateriauxNecessaires(zone:Zone; emplacement:Structure):Boolean;
  {Fonction qui prend en parametre une zone et un emplacement et 
  renvoie Faux si l'inventaire de la zone contient moins de materiaux 
  que l'emplacement en consomme et renvoie Vrai sinon}
  var
    materiau:Materiaux;
  begin
    MateriauxNecessaires := True;
    // Boucle sur chaque materiaux du type Materiaux
    for materiau in Materiaux do
    begin
      // Vérifie que l'emplacement consomme le materiaux sur lequel on boucle
      if (emplacement.consommable[materiau] > 0) then
      begin
        // Vérifie que l'inventaire de la zone possèdent assez de matériaux
        if (zone.inventaire[materiau] < emplacement.consommable[materiau]) then
          MateriauxNecessaires := False;
      end;
    end;
  end;

procedure revenusProduction(var zone:Zone);
  {procédure qui prend en parametre une zone et qui ajoute a 
  chaque materiaux dans l'inventaire de la zone les materiaux 
  produit par les différents batiments}
  var
    emplacement:Structure;
    materiau:Materiaux;
    possedeMateriauxNecessaires:Boolean;
    pElectricite:Integer;
    cElectricite:Integer;
  begin
    // Calcule la production en Electricite d'une zone
    pElectricite := ProductionElectricite(zone);
    // Calcule la Consommation en Electricite d'une zone
    cElectricite := ConsommationElectricite(zone);
    // Vérifie que l'on consomme moins ou autant d'Electricite que la production d'Electricite
    if (cElectricite <= pElectricite) then
    begin
      // Boucle sur chaque emplacements de la zone
      for emplacement in zone.emplacements do
      begin
        // Vérifie que l'emplacement a été découvert
        if emplacement.est_decouvert then
        begin
          // Vérifie que l'inventaire de la zone possede assez de materiaux
          possedeMateriauxNecessaires := MateriauxNecessaires(zone, emplacement);

          if possedeMateriauxNecessaires then
          begin
            // Boucle sur chaque materiaux
            for materiau in Materiaux do
            begin
              // Vérifie que l'emplacement consomme le materiaux sur lequel on boucle
              if (emplacement.consommable[materiau] > 0) then
                  // Enleve les matériaux consommés à l'inventaire de la zone
                  zone.inventaire[materiau] := zone.inventaire[materiau] - emplacement.consommable[materiau];
            end;

            // Ajoute le nombre de materiaux produit à l'emplacement du même matériaux
            zone.inventaire[emplacement.materiaux] := zone.inventaire[emplacement.materiaux] + emplacement.production;
          end;
        end;
      end;
    end;
  end;

procedure MenuCreerBatiment(var zone:Zone);
  {}
  var
    choix:String;
    choix_int:Integer;
    choix2:String;
    choix2_int:Integer;
    sortie:Boolean;
    sortie2:Boolean;
    materiau:Materiaux;
  begin
    AfficherActionInformation('Veuillez choisir un emplacement(entre 0 et 9)');
    readln(choix);
    choix_int:=StrToInt(choix);
    if zone.emplacements[choix_int].est_decouvert then
    begin
      if (zone.emplacements[choix_int].type_structure = Vide) or (zone.emplacements[choix_int].type_structure = Gisement) then
      begin
        sortie:=False;
        while not sortie do
        begin
          AfficherMenuBatiment();
          readln(choix);
          if choix = '0' then
            sortie:=True
          else  if choix = '1' then
          begin 
            creerMine(zone, choix_int);
            sortie:=True;
          end
          else if choix = '2' then
          begin
            sortie2:=False;
            while not sortie2 do
            begin
              AfficherMenuMateriauxTransformer();
              readln(choix2);
              if (choix>=QUITTER) and (choix<=MATERIAUX_TRANSFORMES) then
              begin
                choix2_int:=StrToInt(choix2);
                sortie2:=True;
              end;
            end;
            if choix2<>QUITTER then
            begin
              for materiau in Materiaux do
              begin
                if ord(materiau) = (choix2_int+StrToInt(MATERIAUX_PREMIERS)-1) then
                  creerUsine(zone, choix_int, materiau);
              end;
              sortie:=True;
            end;
          end
          else if choix = '3' then
            begin
              creerCentrale(zone, choix_int);
              sortie:=True;
            end;
        end;
      end
      else
      begin
        AfficherActionInformation('Vous ne pouvez pas construire un batiment sur un autre batiment');
        readln;
      end;
    end
    else
    begin
      AfficherActionInformation('Vous ne pouvez pas construire un batiment sur un emplacement non explore');
      readln;
    end;
  end;

procedure MenuUpgradeBatiment(var zone:Zone);
  {}
  var
    choix:string;
    choix_int:Integer;
  begin
    AfficherActionInformation('Veuillez choisir un emplacement(entre 0 et 9)');
    readln(choix);
    choix_int:=StrToInt(choix);
    if zone.emplacements[choix_int].est_decouvert then
    begin
      if (zone.emplacements[choix_int].type_structure = Mine) or 
          (zone.emplacements[choix_int].type_structure = Usine) or 
          (zone.emplacements[choix_int].type_structure = Centrale) then
      begin
        UpgradeBatiment(zone, choix_int);
      end
      else
      begin
        AfficherActionInformation('Vous devez choisir uniquement un batiment améliorable');
        readln;
      end;
    end
    else
    begin
      AfficherActionInformation('Vous ne pouvez pas construire un batiment sur un emplacement non explore');
      readln;
    end;
  end;

procedure setDate(var date:Date);
  {Définie la date de départ}
  begin
  date.annee:=2025;
  date.mois:=Septembre;
  date.nb_jour:=1;
  date.jour:=Lundi;
  end;

function nbJourMois(mois:Mois; annee:Integer):Integer;
  {Renvoie le nombre de jour dans un mois en fonction du mois et d'une année}
  begin
  if (mois=fevrier) then
    begin
    if ((annee mod 4) = 0) and ((annee mod 100) <> 0) then
      nbJourMois:=29
    else
      nbJourMois:=28;
    end
  else if (ord(mois) mod 2 = 0) then
    nbJourMois:=30
  else
    nbJourMois:=31;
  end;

procedure suivante(var date:Date);
  {Augmente la date d'un jour}
  var
    nb_jour_max:Integer;
  begin
    // Avancement du jour de la semaine
    if (date.jour=high(Jour)) then
      date.jour:=low(Jour)
    else
      date.jour:=succ(date.jour);

    // Vérifie le nombre de jour dans le mois actuelle
    nb_jour_max:=nbJourMois(date.mois, date.annee);

    // Augmente la date
    date.nb_jour:=date.nb_jour+1;

    // Si on est arrivé à la fin du mois
    if (date.nb_jour>nb_jour_max) then
      begin
      // Remet le jour à 1
      date.nb_jour:=1;

      // Augmente le mois en vérifiant si on est arrivé à la fin de l'année (augmente l'année si c'est le cas)
      if (date.mois=high(Mois)) then
        begin
        date.mois:=low(Mois);
        inc(date.annee);
        end
      else
        date.mois:=succ(date.mois);
      end;
  end;

procedure jourSuivant(var zone:Zone; var date:Date);
  {Passe au jour suivant en récupérant les ressources produites}
  begin
  suivante(date);
  revenusProduction(zone);
  end;

procedure Explore(var zone:Zone);
  {Effectue une action 'Explorer'}
  var
    indice:Integer;
  begin
  if (Random<0.5) then
    begin
    indice:=getIndiceEmplacementNonDecouvertAlea(zone);
    decouvre(zone.emplacements[indice]);
    end;
  end;

procedure NavigWiki();
  var 
    choix, Choix2: integer;
    quitter: boolean;

  begin
    // Initialisation var sortie
    quitter := false;
    // Boucle wiki
    repeat
      // wiki bâtiment
      AfficherMenuWikiBatiment();
      readln(choix);
      
      case choix of
        // wiki prod
        1: begin
            // Boucle menu wiki prod
            repeat
              // Affichage wiki prod
              AfficherMenuWikiProduction();
              readln(Choix2);
              case Choix2 of
                // Retour wiki bâtiment
                1: ;
                // Retour
                2: begin
                      Scenario();
                      // Quitter wiki
                      quitter := true;
                    end;
                // Quitter wiki
                0: quitter := true;
              end;
            until (Choix2 = 0) or (Choix2 = 1) or (Choix2 = 2);
          end;
        //Retour
        2: begin
            Scenario();
            // quitter du wiki
            quitter := true;
          end;
        // quitter wiki
        0: quitter := true;
      end;
    until quitter;
  end;

procedure MenuChangementUsine(var zone:Zone);
  {}
  var
    choix:string;
    choix_int:Integer;
    choix2:string;
    choix2_int:Integer;
    sortie:Boolean;
    materiau:Materiaux;
  begin
    AfficherActionInformation('Veuillez choisir un emplacement(entre 0 et 9)');
    readln(choix);
    choix_int:=StrToInt(choix);
    if (zone.emplacements[choix_int].type_structure = Usine) then
    begin
    sortie:=False;
    while not sortie do
    begin
      AfficherMenuMateriauxTransformer();
      readln(choix2);
      if (choix>=QUITTER) and (choix<=MATERIAUX_TRANSFORMES) then
      begin
        choix2_int:=StrToInt(choix2);
        sortie:=True;
      end;
    end;
    if choix2<>QUITTER then
    begin
      for materiau in Materiaux do
      begin
        if ord(materiau) = (choix2_int+StrToInt(MATERIAUX_PREMIERS)-1) then
          ChangementUsine(zone, choix_int, materiau);
      end;
    end;
    end
    else
    begin
      AfficherActionInformation('Vous devez selectionner un emplacement contenant une Usine');
      readln;
    end;
  end;

procedure menuChangementZone(var curent_zone:Integer);
  {Affiche le menu de choix de zone et change la zone en conséquence}
  var
    choix:String;
    choix_valide:Boolean;
  begin
  choix_valide:=false;
  AfficherMenuZone();
  readln(choix);
  while (not choix_valide) do
    begin
    if choix='0' then
      choix_valide:=true
    else if choix='1' then
      begin
      choix_valide:=true;
      curent_zone:=0;
      end
    else if choix='2' then
      begin
      choix_valide:=true;
      curent_zone:=1;
      end
    else if choix='3' then
      begin
      choix_valide:=true;
      curent_zone:=2;
      end
    else
      AfficherMenuZone();
      readln(choix);
    end;
  end;

procedure JeuPrincipal();
  var
    curent_zone:Integer;
    zones:Array[0..2] of Zone;
    choix:String;
    curent_date:Date;
  begin
    Scenario();
    choix:='';
    setDate(curent_date);
    curent_zone:=0;
    zones[0]:=initZone(0, NOM_ZONE1, MineraiDHematite, FragmentDeChalcocite, CarbonePyrolyte);
    zones[1]:=initZone(0, NOM_ZONE2, MineraiDHematite, FragmentDeChalcocite, CarbonePyrolyte);
    zones[2]:=initZone(0, NOM_ZONE2, ArgileRegolitique, CarbonePyrolyte, MineraiDHematite);
    while (choix<>QUITTER) do
      begin
      AfficherZone(zones[curent_zone], curent_date);
      readln(choix);
      if (choix=CONSTRUIRE) then
        begin
        MenuCreerBatiment(zones[curent_zone]);
        end
      else if (choix=CHANGER_PRODUCTION) then
        begin
        MenuChangementUsine(zones[curent_zone]);
        end
      else if (choix=AMELIORER) then
        begin
        MenuUpgradeBatiment(zones[curent_zone]);
        end
      else if (choix=EXPLORER) then
        begin
        Explore(zones[curent_zone]);
        jourSuivant(zones[curent_zone], curent_date);
        end
      else if (choix=CHANGER_ZONE) then
        begin
        menuChangementZone(curent_zone);
        end
      else if (choix=TRANSFERT_RESSOURCES) then
        begin
        end
      else if (choix=PASSER_JOURNEE) then
        begin
        jourSuivant(zones[curent_zone], curent_date);
        end
      else if (choix=MISSIONS) then
        begin

        // A CHANGER CAR ON PEUT PAS Y ACCER DANS ASCENSEUR ORBITAL !!!
          AfficherMenuMissions();
          readln();
        end
      else if (choix=WIKI) then
        begin
          NavigWiki();
        end;
      end;  
  end;

procedure MainMenu();
  var
    choix:String;
  begin
    choix:='';
    while (choix<>QUITTER) do
      begin
      choix:=AfficheMainMenu();
      if (choix='1') then
        JeuPrincipal();
      end;
  end;

end.