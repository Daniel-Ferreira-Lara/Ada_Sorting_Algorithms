package body Algoritmos is

  function Get_Algoritmos return Lista_Algoritmos is (Sorting_Algoritmos);

  function Get_Algoritmo
    (Index : in Integer)
     return access Interface_Ordenacao.Object'Class is

  begin

    return Sorting_Algoritmos (Algoritmo_Range (Index));

  exception

    when Constraint_Error => raise Invalid_Index;

  end Get_Algoritmo;


end Algoritmos;
