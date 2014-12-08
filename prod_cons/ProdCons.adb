with TEXT_IO; use TEXT_IO;

--sauvegarder ce fichier sous le nom de: ProdCons.adb, et pour compiler lancer: gnatmake ProdCons.adb -o Prodcons


-- un producteur et un consommateur avec un tampon de taille N

procedure ProdCons is
package int_io is new Integer_io(integer);
use int_io;

-- Interface  Magasinier
task type Magasinier is
entry produire(Mess : IN Integer);
entry consommer(Mess : OUT Integer);
end Magasinier;

M : Magasinier;

-- Interface Producteur
task type Producteur is end Producteur;

-- Interface consommateur
task type Consommateur is end Consommateur;

-- Body Magasinier
task body Magasinier is
cpt : Integer := 0;
-- taille du tampon
n : Integer := 8;
tampon : array(0..n-1) of Integer;
tete,queue : Integer range 0..n-1 := 0;
begin
loop
select
-- si le nombre de production est inférieur à la taille du tampon, on peut produire
when (cpt < n) => accept produire(Mess : IN Integer)
do
tampon(tete) := Mess;
end;
put_line("produire");
tete := (tete + 1) mod n;
cpt := cpt + 1;
or
-- s'il y a au moins une production, on peut consommer
when (cpt > 0) => accept consommer(Mess : OUT Integer)
do
Mess := tampon(queue);
end;
put_line("consommer");
queue := (queue + 1) mod n;
cpt := cpt -1;
end select;
end loop;
end Magasinier;
-- corps Producteur
task body Producteur is
value : Integer := 1;
begin
for i in 1..10 loop
M.produire(value);
end loop;
end Producteur;

-- corps Consommateur
task body Consommateur is
value : Integer := 0;
begin
for i in 1..10 loop
M.consommer(value);
end loop;
end Consommateur;
p : Producteur;
c : Consommateur;
begin
null;
end ProdCons; 