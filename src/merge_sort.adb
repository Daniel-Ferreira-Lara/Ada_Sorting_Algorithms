package body Merge_Sort is

  ------------------------------------------------------------------------------
  -- O(n*log(n))
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object is

    Vet : Vetor_Random.Object := Vetor;

    ----------------------------------------------------------------------------
    function Merge (Esq  : in Vetor_Random.Object;
                    Dir : in Vetor_Random.Object) return Vetor_Random.Object is

      E : Integer := Esq'First;
      D : Integer := Dir'First;
      M : Integer := Esq'First;

    begin
      while E <= Esq'Last and D <= Dir'Last loop

        if Esq (E) <= Dir (D) then
          Vet (M) := Esq (E);
          E := E + 1;
        else
          Vet (M) := Dir (D);
          D := D + 1;
        end if;

        M := M + 1;

      end loop;

      while E <= Esq'Last loop
        Vet (M) := Esq (E);
        E := E + 1;
        M := M + 1;
      end loop;

      while D <= Dir'Last loop
        Vet (M) := Dir (D);
        D := D + 1;
        M := M + 1;
      end loop;

      return Vet;

    end Merge;

  ------------------------------------------------------------------------------
  begin

    if Vetor'First < Vetor'Last then

      declare

        Mid : constant Integer := Vetor'First + (Vetor'Last - Vetor'First)/2;

        Esq_Sub    : Vetor_Random.Object (Vetor'First .. Mid)  := (others => 0);
        Dir_Sub   : Vetor_Random.Object (Mid+1 .. Vetor'Last) := (others => 0);

      begin

        Esq_Sub  := This.Sort (Vetor (Vetor'First .. Mid));
        Dir_Sub := This.Sort (Vetor (Mid+1 .. Vetor'Last));

        Vet := Merge (Esq_Sub, Dir_Sub);

      end;

    end if;

    return Vet;

  end Sort;

end Merge_Sort;
