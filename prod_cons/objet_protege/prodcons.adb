
with TEXT_IO; use TEXT_IO;

-- 1 producteur, 1 consommateur, tampon de taille n

procedure ProdConsObjetProtege is

    package int_io is new Integer_io(integer);
    use int_io;

    n:Integer:=8;
    type Tampon_Type is array (0..n-1) of Integer;

    -- interface Magasinier

    protected type Magasinier is
        entry produire(Mess : IN Integer);
        entry consommer(Mess : OUT Integer);
    private
            cpt : Integer := 0; --Compteur de remplissage du tampon
            tampon : tampon_Type;
            tete,queue : Integer range 0..n-1:= 0; --Tete et queue varient entre 0 et n-1
    end Magasinier;

    M : Magasinier;

    -- Interface Producteur
    task type Producteur is end Producteur;

    -- Interface Consommateur
    task type Consommateur is end Consommateur;

    --body  Magasinier
    protected body Magasinier is
        entry produire(Mess : IN Integer)
            when (cpt < n) is
        begin
            tampon(tete) := Mess;
            tete := (tete + 1) mod n;
            put_line("produire");
            cpt := cpt + 1;
        end produire;

        entry consommer(Mess : OUT Integer)
            when (cpt > 0) is
        begin
            Mess := tampon(queue);
            queue := (queue + 1) mod n;
            put_line("consommer");
            cpt := cpt-1;
        end consommer;

    end Magasinier;

    task body Producteur is
        value : Integer := 3;
    begin
        for i in 1..10 loop
            M.produire(value);
        end loop;
    end Producteur;


    task body Consommateur is
        value : Integer := 0;
    begin
        for i in 1..10 loop
            M.consommer(value);
        end loop;
    end Consommateur;

    P : Producteur;
    C : Consommateur;

    begin
        null;
end ProdConsObjetProtege;
