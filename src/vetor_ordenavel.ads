
generic
  Min  : Natural := 0;
  Max  : Natural := 9;
  Size : Natural := 200;

package Vetor_Ordenavel is

  subtype Valor is Natural range Min .. Max;

  type Object is array (Integer range <>) of Valor;

  function Generate
    (Tamanho : Natural := Size)
     return Object;

  procedure Swap
    (This  : in out Object;
     Esq  : in Integer;
     Dir : in Integer);


  function Is_Sorted
    (This : in Object)
     return Boolean;

  type Print_Formatado is (Linha_a_Linha,Condensado);

  procedure Print
    (This   : in Object;
     Formato : in Print_Formatado := Condensado);

end Vetor_Ordenavel;
