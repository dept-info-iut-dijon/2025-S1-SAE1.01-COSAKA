unit gestionIHM;

{$mode delphi}{$H+}

interface
procedure EcranTitre();
procedure MainMenu();

implementation


uses
  SysUtils, Classes,gestionEcran,constantUnit;


{Affichage du menu ECRAN TITRE}
procedure EcranTitre();
begin
    dessinerCadreXY(5,2,153,38,double,white,black); // TAILLE DE BASE
    deplacerCurseurXY(20,5);
    writeln('  /$$$$$$              /$$     /$$            /$$$$$$                      /$$   /$$ /$$$$$$ /$$   /$$ /$$$$$$$$      ');
    deplacerCurseurXY(20,6);
    writeln(' /$$__  $$            | $$    |__/           /$$__  $$                    | $$  | $/|_  $$_/| $$  | $$|__  $$__/      ');
    deplacerCurseurXY(20,7);
    writeln('| $$  \__/  /$$$$$$  /$$$$$$   /$$  /$$$$$$$| $$  \__//$$$$$$   /$$$$$$$ /$$$$$$|_/   | $$  | $$  | $$   | $$         ');
    deplacerCurseurXY(20,8);
    writeln('|  $$$$$$  |____  $$|_  $$_/  | $$ /$$_____/| $$$$   |____  $$ /$$_____/|_  $$_/      | $$  | $$  | $$   | $$         ');
    deplacerCurseurXY(20,9);
    writeln(' \____  $$  /$$$$$$$  | $$    | $$|  $$$$$$ | $$_/    /$$$$$$$| $$        | $$        | $$  | $$  | $$   | $$         ');


    deplacerCurseurXY(63,35);
    writeln('Appuyez sur ENTRER pour commencer');
end;

{Affichage du menu principale}
procedure MainMenu();
begin

end;

end.


{ ASCII ART ECRAN TITRE

  /$$$$$$              /$$     /$$            /$$$$$$                      /$$   /$$ /$$$$$$ /$$   /$$ /$$$$$$$$      
 /$$__  $$            | $$    |__/           /$$__  $$                    | $$  | $/|_  $$_/| $$  | $$|__  $$__/      
| $$  \__/  /$$$$$$  /$$$$$$   /$$  /$$$$$$$| $$  \__//$$$$$$   /$$$$$$$ /$$$$$$|_/   | $$  | $$  | $$   | $$         
|  $$$$$$  |____  $$|_  $$_/  | $$ /$$_____/| $$$$   |____  $$ /$$_____/|_  $$_/      | $$  | $$  | $$   | $$         
 \____  $$  /$$$$$$$  | $$    | $$|  $$$$$$ | $$_/    /$$$$$$$| $$        | $$        | $$  | $$  | $$   | $$         
 /$$  \ $$ /$$__  $$  | $$ /$$| $$ \____  $$| $$     /$$__  $$| $$        | $$ /$$    | $$  | $$  | $$   | $$         
|  $$$$$$/|  $$$$$$$  |  $$$$/| $$ /$$$$$$$/| $$    |  $$$$$$$|  $$$$$$$  |  $$$$/   /$$$$$$|  $$$$$$/   | $$         
 \______/  \_______/   \___/  |__/|_______/ |__/     \_______/ \_______/   \___/    |______/ \______/    |__/    

}