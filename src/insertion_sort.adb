package body Insertion_Sort is

  ------------------------------------------------------------------------------
  -- O(n²)

  overriding
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object is

    Vet : Vetor_Random.Object := Vetor;

    J   : Integer := 0;
    Key : Integer := 0;

    Size : constant Natural := Vet'Size/Vet(0)'Size;

  begin

    for I in 1 .. Size - 1 loop

      Key := Vet (I);
      J   := I - 1;

      while J >= 0 and then Vet (J) > Key loop
        Vet (J+1) := Vet (J);
        J         := J - 1;
      end loop;

      Vet (J+1) := Key;

    end loop;

    return Vet;

  end Sort;

end Insertion_Sort;
