package body Bubble_Sort is

  ------------------------------------------------------------------------------
  --O (n²)
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object is

    use type Vetor_Random.Funcoes.Valor;

    Vet     : Vetor_Random.Object := Vetor;
    Swapped : Boolean        := True;

  begin

    while Swapped loop

      Swapped := False;

      for i in Natural range 1 .. Vet'Length - 1 loop

        if Vet(i-1) > Vet(i) then

          Vetor_Random.Funcoes.Swap (Vet, i-1, i);
          Swapped := True;

        end if;

      end loop;

    end loop;

    return Vet;

  end Sort;

end Bubble_Sort;
