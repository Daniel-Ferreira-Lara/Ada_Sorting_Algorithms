with Ada.Characters.Latin_1;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

package body Vetor_Ordenavel is

  package Asu renames Ada.Strings.Unbounded;
  package Random is new Ada.Numerics.Discrete_Random (Valor);

  use type Asu.Unbounded_String;

  ------------------------------------------------------------------------------
  function Generate (Tamanho : in Natural := Size) return Object is

    Output : Object (0 .. Size) := (others => 0);

    ----------------------------------------------------------------------------
    function Num_Random return Valor is

      Seed         : Random.Generator;
      Random_Valor : Valor := 0;

    begin

      Random.Reset (Seed);
      Random_Valor := Random.Random (Seed);

      return Random_Valor;

    end Num_Random;

    ----------------------------------------------------------------------------
  begin

    for X in Output'Range loop
      Output (X) := Num_Random;
    end loop;

    return Output;

  end Generate;

  ------------------------------------------------------------------------------
  procedure Swap
    (This  : in out Object;
     Esq  : in Integer;
     Dir : in Integer) is

    Temp : Natural := This (Esq);

  begin
    This (Esq)  := This (Dir);
    This (Dir) := Temp;
  end Swap;

  ------------------------------------------------------------------------------
  function Is_Sorted
    (This : in Object)
     return Boolean is

  begin

    for i in This'First .. This'Last - 1 loop

      if This (i) > This (i + 1) then
        return False;
      end if;

    end loop;

    return True;

  end Is_Sorted;

  ------------------------------------------------------------------------------
  procedure Print_Linhas (This : in Object) is
  begin

    for X in This'Range loop
      Ada.Text_IO.Put_Line (X'Img & " =>" & This (X)'Img);
    end loop;

  end Print_Linhas;

  ------------------------------------------------------------------------------
  procedure Print_Condensado (This : in Object) is

    Print_String      : Asu.Unbounded_String := Asu.To_Unbounded_String("");
    New_Line          : constant Character   := Character'Val(13);

    Elements_Per_Line : constant Natural := 25;
    Elements_Listed   : Natural := 0;

    ----------------------------------------------------------------------------
    function Count_Digitos
      (Valor : in Natural)
       return Natural is

      Base       : Natural := 10;
      Num_Digitos : Natural := 1;

    begin

      while Valor mod Base /= Valor loop

        Base       := Base * 10;
        Num_Digitos := Num_Digitos + 1;

      end loop;

      return Num_Digitos;

    end Count_Digitos;

    ----------------------------------------------------------------------------
    function Formato_Valor
      (Valor : in Natural)
       return String is

      Max_Digitos  : constant Natural := Count_Digitos (Max);

    begin

      return Ada.Strings.Fixed.Tail
        (Source => Ada.Strings.Fixed.Trim (Valor'Img, Ada.Strings.Both),
         Count  => Max_Digitos,
         Pad    => '0');

    end Formato_Valor;

  begin

    for I in This'Range loop

      if Elements_Listed mod Elements_Per_Line = 0 then
        Ada.Text_IO.Put_Line (Asu.To_String (Print_String));
        Print_String := Asu.Null_Unbounded_String;
      else
        Print_String := Print_String & " " & Formato_Valor (This (I));
      end if;

      Elements_Listed := Elements_Listed + 1;

    end loop;

    Ada.Text_IO.Put_Line (Asu.To_String (Print_String));

  end Print_Condensado;

  ------------------------------------------------------------------------------
  procedure Print
    (This   : in Object;
     Formato : in Print_Formatado := Condensado) is

  begin

    case Formato is

      when Linha_a_Linha =>
        Print_Linhas (This);

      when Condensado =>
        Print_Condensado (This);

    end case;

  end Print;

end Vetor_Ordenavel;
