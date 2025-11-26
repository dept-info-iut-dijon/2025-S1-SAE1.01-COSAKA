unit LogiqueUnit;
{$mode delphi}{$H+}

interface
  uses
    constantunit;


implementation
  uses
    SysUtils, Classes;

procedure setEmplacement(var emplacement:Structure; 
                         new_niveau:Integer; new_est_decouvert:Boolean;
                         new_type_structure:Batiment; new_materiaux:Materiaux; 
                         new_production:Integer);
  begin
    emplacement.type_structure:=new_type_structure;
    emplacement.niveau:=new_niveau;
    emplacement.est_decouvert:=new_est_decouvert;
    emplacement.materiaux:=new_materiaux;
    emplacement.production:=new_production;
  end;

function initEmplacementsZone1(zone:Zone):Zone;
  {Fonction qui prend en paramètres une zone
  et qui renvoie cette même zone avec ses emplacements
   initialisés comme zone de départ.}
  begin
    // Définie le Hub de la zone
    setEmplacement(zone.emplacements[0], 0, true, Hub, Null, 0);
    // Définie un emplacement avec un gisement du premier minerai du jeu.
    
    // Définie un emplacement avec un gisement du premier minerai du jeu.
    
  end;

function initEmplacements(zone:Zone):Zone;
  {Fonction qui prend en paramètres une zone
  et qui renvoie cette même zone après avoir
  initialisé tous ses emplacements,  prêts pour le jeu.}
  var
    i:Integer;
  
  begin
    zone.emplacements[0].type_structure:=Hub;
    for i:=0 to 2 do
      begin
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
  begin
    // Vérifie si le type de struture est bien un Gisement
    if emplacement.type_structure = Gisement then
    begin
      // Calcul de la production selon le niveau du Gisement
      production := round(PRODUCTION_BASE[emplacement.materiaux]*(1 + ((emplacement.niveau - 1) / 4)));
      // Modifie l'emplacement
      setEmplacement(emplacement, NOUVEAU_NIVEAU, emplacement.est_decouvert, 
                      Mine, emplacement.materiaux, production);
    end;
  end;

end.