with Interface_Ordenacao;
with Vetor_Random;

package Bubble_Sort is

  type Object is new Interface_Ordenacao.Object with null record;
  overriding
  function Nome (This : in Object) return String is ("Bubble Sort");

  overriding
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object;

end Bubble_Sort;
