unit LogiqueUnit;
{$mode delphi}{$H+}

interface
  uses
    constantunit, GestionIHM;


implementation
  uses
    SysUtils, Classes;

procedure setEmplacement(var emplacement:Structure; 
                         new_niveau:Integer; new_est_decouvert:Boolean;
                         new_type_structure:Batiment; new_materiaux:Materiaux;
                         new_production:Integer);
  {Définit les valeur des paramètres de l'emplacement 'emplacement'.
  Attention, tous les paramètres doivent être renseignés.}
  begin
    emplacement.type_structure:=new_type_structure;
    emplacement.niveau:=new_niveau;
    emplacement.est_decouvert:=new_est_decouvert;
    emplacement.materiaux:=new_materiaux;
    emplacement.production:=new_production;
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

function getEmplacementVideAlea(zone:Zone):Structure;
  {Renvoie un emplacement vide de 'zone'.
  Si il n'y en a pas, renvoie le premier emplacement de 'zone'.}
  var
    curent_emplacement:Structure;
    a_emplacement_vide:Boolean;   // Indique si la zone contient au moins un emplacement vide.
  begin
    // Vérifie si la zone possède au moins un emplacement vide.
    curent_emplacement:=zone.emplacements[low(zone.emplacements)];
    a_emplacement_vide:=false;
    for curent_emplacement in zone.emplacements do
      begin
      if (curent_emplacement.type_structure<>Vide) then
        begin
        a_emplacement_vide:=true;
        end;
      end;

    // Boucle si au moins un emplacement vide existe et tant qu'aucun n'est trouvé.
    while a_emplacement_vide and (curent_emplacement.type_structure<>Vide) do
      begin
      curent_emplacement:=zone.emplacements[random(8)+1];
      end;
    getEmplacementVideAlea:=curent_emplacement;
  end;

procedure ajouteStructureemplacementAlea(var zone:Zone; niveau:Integer; 
                                         est_decouvert:Boolean; type_structure:Batiment;
                                         materiaux:Materiaux; production:Integer);
  {Ajoute une structure avec des caractéristiques spécifiés en paramètre
  à un emplacement aléatoire d'une zone.}
  var
    emplacement:Structure;
  begin
    emplacement:=getEmplacementVideAlea(zone);
    if emplacementsSontDifferents(emplacement, zone.emplacements[low(zone.emplacements)]) then
      begin
      setEmplacement(emplacement, 2, true, Gisement, zone.minerais[1], 0);
      end;
  end;

procedure initEmplacements(var zone:Zone);
  {Fonction qui prend en paramètres une zone
  et qui renvoie cette même zone après avoir
  initialisé tous ses emplacements,  prêts pour le jeu.}
  begin
    // Définie le Hub de la zone
    setEmplacement(zone.emplacements[0], 0, true, Hub, Null, 0);
    // Définie un emplacement avec un gisement du premier minerai de la zone.
    setEmplacement(zone.emplacements[random(8)+1], 3, true, Gisement, zone.minerais[0], 0);

    
    // Définie un gisement du deuxième minerai de la zone dans un emplacement aléatoire.
    ajouteStructureEmplacementAlea(zone, 2, true, Gisement, zone.minerais[1], 0);
    
    // A 1/5 chance d'ajouter un deuxième gisement d'un minerai y étant déjà.
    if (random<0.2) then
      begin
      ajouteStructureEmplacementAlea(zone, 2, false, Gisement, zone.minerais[random(1)], 0);
      end;
    
    if (random<0.5) then
      begin
      ajouteStructureEmplacementAlea(zone, 1, false, Gisement, zone.minerais[random(2)], 0)
      end;  
  end;

procedure creerMine(var emplacement:Structure);
  {Procédure qui prend en paramètre un emplacement et 
  qui renvoie ce même emplacement en changeant le type 
  de la structure en 'Mine', en initialisant le niveau 
  de la structure à 1 et la valeur de la production}
  const
    // Initialise le nouveau niveau à 1
    NOUVEAU_NIVEAU = 1;
  var
    production:Integer;
    message:string;
  begin
    // Vérifie si le type de struture est bien un Gisement
    if (emplacement.type_structure=Gisement) then
    begin
      // Calcul de la production selon le niveau du Gisement
      production := round(PRODUCTION_BASE[emplacement.materiaux]*(1 + ((emplacement.niveau - 1) / 4)));
      // Modifie l'emplacement avec les nouveaux paramètres
      setEmplacement(emplacement, NOUVEAU_NIVEAU, emplacement.est_decouvert, 
                      Mine, emplacement.materiaux, production);
    end
    else
    begin
      message := 'Vous devez impérativement placer une mine sur un gisement';
      // Affiche le message
      AfficherMessage(message);
    end;
  end;

  procedure revenusProduction(zone:Zone);
  {Fonction qui prend en parametre une zone et qui ajoute a 
  chaque materiaux dans l'inventaire les materiaux produit 
  par les différents batiments}
  var
    emplacement:Structure;
  begin
    // Boucle sur chaque emplacements de la zone
    for emplacement in zone.emplacements do
    begin
      // Vérifie que l'emplacement a été découvert
      if emplacement.est_decouvert then
        // Ajoute le nombre de materiaux produit à l'emplacement du même matériaux
        zone.inventaire[emplacement.materiaux] := zone.inventaire[emplacement.materiaux] + emplacement.production;
    end;
  end;

end.