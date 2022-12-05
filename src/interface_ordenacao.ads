with Vetor_Random;
package Interface_Ordenacao is

  type Object is interface;
  function Nome (This : in Object) return String is abstract;
  function Sort
    (This       : in Object;
     Vetor : in Vetor_Random.Object)
     return Vetor_Random.Object is abstract;

end Interface_Ordenacao;
