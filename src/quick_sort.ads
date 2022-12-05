with Interface_Ordenacao;
with Vetor_Random;

package Quick_Sort is

  type Object is new Interface_Ordenacao.Object with null record;

  overriding
  function Nome (This : in Object) return String is ("Quick Sort");

  overriding
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object;

end Quick_Sort;
