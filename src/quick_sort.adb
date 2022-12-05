package body Quick_Sort is

  ------------------------------------------------------------------------------
  -- O(log(n))
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object is

    Vet : Vetor_Random.Object := Vetor;

    ----------------------------------------------------------------------------
    function Partition (P_Vet : in out Vetor_Random.Object;
                        Low   : in Integer;
                        High  : in Integer)
                        return Natural is

      J  : Integer := Low - 1;
      Pivo : constant Vetor_Random.Funcoes.Valor := P_Vet (High);

    begin

      for I in Natural range Low .. High - 1 loop

        if Vet (I) <= Pivo then

          J := J + 1;
          Vetor_Random.Funcoes.Swap (P_Vet, J, I);

        end if;

      end loop;

      Vetor_Random.Funcoes.Swap (P_Vet, J+1, High);

      return J + 1;

    end Partition;

    ----------------------------------------------------------------------------
    procedure Recursive_Sort
      (S_Vet : in out Vetor_Random.Object;
       Low   : in Integer;
       High  : in Integer) is
      Split : Integer;
    begin

      if Low < High then

        Split := Partition (S_Vet, Low, High);

        Recursive_Sort (S_Vet, Low, Split - 1);
        Recursive_Sort (S_Vet, Split + 1, High);

      end if;

    end Recursive_Sort;
  ------------------------------------------------------------------------------
  begin

    Recursive_Sort (Vet, Vet'First, Vet'Last);
    return Vet;

  end Sort;

end Quick_Sort;
