
package body Heap_Sort is

  ------------------------------------------------------------------------------
  --O(n*log(n))
   function Sort
   (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object is

    Vet : Vetor_Random.Object := Vetor;

    ----------------------------------------------------------------------------
    procedure Heapify (Vetor : in out Vetor_Random.Object;
                       N          : in Integer;
                       I          : in Integer) is

      Topo : Integer := I;
      E    : Integer := 2*I + 1;
      D    : Integer := 2*I + 2;

    begin

      if E < N and then Vetor (E) > Vetor (Topo) then
        Topo := E;
      end if;

      if D < N and then Vetor (D) > Vetor (Topo) then
        Topo := D;
      end if;

      if Topo /= I then
        Vetor_Random.Funcoes.Swap (Vetor, I, Topo);
        Heapify (Vetor, N, Topo);
      end if;

    end Heapify;

    ----------------------------------------------------------------------------
    procedure Perform_Sort
      (S_Vet : in out Vetor_Random.Object;
       Size  : in Integer) is
    begin

      for Index in reverse 0 .. Size/2 - 1 loop
        Heapify (S_Vet, Size, Index);
      end loop;

      for Index in reverse 0 .. Size - 1 loop
        Vetor_Random.Funcoes.Swap (S_Vet, 0, Index);
        Heapify (S_Vet, Index, 0);
      end loop;

    end Perform_Sort;
    Heap_Size : constant Natural := Vetor'Size / Vetor (0)'Size;
    ----------------------------------------------------------------------------

   begin

    Perform_Sort (Vet, Heap_Size);
    return Vet;

   end Sort;

end Heap_Sort;
