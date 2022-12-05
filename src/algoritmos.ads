with Bubble_Sort;
with Heap_Sort;
with Insertion_Sort;
with Merge_Sort;
with Selection_Sort;
with Interface_Ordenacao;
with Quick_Sort;

package Algoritmos is

  Invalid_Index : Exception;

  subtype Algoritmo_Range is Integer range 1 .. 6;

  type Lista_Algoritmos is array (Algoritmo_Range) of access Interface_Ordenacao.Object'Class;

  function Get_Algoritmos return Lista_Algoritmos;

  function Get_Algoritmo
    (Index : in Integer)
     return access Interface_Ordenacao.Object'Class;


private

  Sorting_Algoritmos : constant Lista_Algoritmos :=
    (new Insertion_Sort.Object,
     new Selection_Sort.Object,
     new Bubble_Sort.Object,
     new Quick_Sort.Object,
     new Merge_Sort.Object,
     new Heap_Sort.Object);

end Algoritmos;
