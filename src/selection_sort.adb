package body Selection_Sort is

  ------------------------------------------------------------------------------
  --
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object is

    Vet : Vetor_Random.Object := Vetor;
    Min : Integer := 0;

  begin

    for I in Vet'First .. Vet'Last - 1 loop

      Min := I;

      for J in I+1 .. Vet'Last loop

        if Vet(J) < Vet(Min) then
          Min := J;
        end if;

      end loop;

      if Min /= I then
        Vetor_Random.Funcoes.Swap (Vet, I, Min);
      end if;

    end loop;

    return Vet;

  end Sort;

end Selection_Sort;
