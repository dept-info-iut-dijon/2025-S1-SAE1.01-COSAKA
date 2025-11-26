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
{Définit les valeur des paramètres de l'emplacement 'emplacement'.
  Attention, tous les paramètres doivent être renseignés.}
  begin
    emplacement.type_structure:=new_type_structure;
    emplacement.niveau:=new_niveau;
    emplacement.est_decouvert:=new_est_decouvert;
    emplacement.materiaux:=new_materiaux;
  end;

function getEmplacementVideAlea(zone:Zone):Structure;
  var
    curent_emplacement:Structure;
  begin
    
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

    curent_emplacement:=zone.emplacements[random(1, 9)];
    while (curent_emplacement.type_structure<>Null) do
      begin
      curent_emplacement:=zone.emplacements[random(1, 9)];
      end;
    // Définie un gisement du deuxième minerai de la zone dans un emplacement aléatoire.
    setEmplacement(curent_emplacement, 2, true, Hub, zone.minerais[1]);
    

  end;


end.