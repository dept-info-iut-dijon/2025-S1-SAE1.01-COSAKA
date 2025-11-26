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
                         new_type_structure:Batiment; new_materiaux:Materiaux);
  begin
    emplacement.type_structure:=new_type_structure;
    emplacement.niveau:=new_niveau;
    emplacement.est_decouvert:=new_est_decouvert;
    emplacement.materiaux:=new_materiaux;
  end;

function initEmplacementsZone1(zone:Zone):Zone;
  {Fonction qui prend en paramètres une zone
  et qui renvoie cette même zone avec ses emplacements
   initialisés comme zone de départ.}
  begin
    // Définie le Hub de la zone
    setEmplacement(zone.emplacements[0], 0, true, Hub, Null);
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


end.