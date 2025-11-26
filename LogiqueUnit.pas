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
                         new_type_structure:Batiment; new_materiaux:Materiaux,
                         new_production:production);
  {Définit les valeur des paramètres de l'emplacement 'emplacement'.
  Attention, tous les paramètres doivent être renseignés.}
  begin
    emplacement.type_structure:=new_type_structure;
    emplacement.niveau:=new_niveau;
    emplacement.est_decouvert:=new_est_decouvert;
    emplacement.materiaux:=new_materiaux;
    emplacement.production:=new_production;
  end;

function getEmplacementVideAlea(zone:Zone):Structure;
  var
    curent_emplacement:Structure;
  begin
    curent_emplacement:=zone.emplacements[random(1, 9)];
    while (curent_emplacement.type_structure<>Null) do
      begin
      curent_emplacement:=zone.emplacements[random(1, 9)];
      end;
  end;

procedure initEmplacements(var zone:Zone);
  {Fonction qui prend en paramètres une zone
  et qui renvoie cette même zone après avoir
  initialisé tous ses emplacements,  prêts pour le jeu.}
  var
    curent_emplacement:Structure;

  begin
    // Définie le Hub de la zone
    setEmplacement(zone.emplacements[0], 0, true, Hub, Null);
    // Définie un emplacement avec un gisement du premier minerai de la zone.
    setEmplacement(zone.emplacements[random(1, 9)], 3, true, Hub, zone.minerais[0]);

    
    // Définie un gisement du deuxième minerai de la zone dans un emplacement aléatoire.
    setEmplacement(curent_emplacement, 2, true, Hub, zone.minerais[1]);
    

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
    if emplacement.type_structure = Gisement then
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