with Ada.Calendar;
with Ada.Characters.Latin_1;
with Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with Algoritmos;
with Bubble_Sort;
with Heap_Sort;
with Insertion_Sort;
with Merge_Sort;
with Quick_Sort;
with Vetor_Random;
with Selection_Sort;
with Interface_Ordenacao;

use Ada.Strings.Unbounded;

package body Interface_In_Out is

  Exit_Exception : Exception;
  New_Line : constant Character := Ada.Characters.Latin_1.LF;
  package Txt renames Ada.Text_IO;

  type Formato_Saida is(Completo, Resumo_Tempo, Resumo_Resultado, Verifica);

  for Formato_Saida use
    (Completo         => 1,
     Resumo_Tempo     => 2,
     Resumo_Resultado => 3,
     Verifica         => 4);

  Print_Formato : Formato_Saida := Completo;

  Vet_Teste : Vetor_Random.Object := Vetor_Random.Funcoes.Generate;

  type Test_Resultado is record
    Test_Nome : Unbounded_String;
    Tempo_Exec  : Duration := 0.0;
    Output    : Vetor_Random.Object (Vet_Teste'Range);
  end record;
  type Test_Resultados is array (1 .. 6) of Test_Resultado;
  Algoritmo_Atual : access Interface_Ordenacao.Object'Class := new Bubble_Sort.Object;

  ----------------------------------------------------------------------------
  procedure Separador is
  begin
    Txt.Put_Line ("------------------------------");
  end Separador;

  ----------------------------------------------------------------------------
  procedure Print_Vet is
  begin
    Separador;
    Txt.Put_Line ("Vetor Gerado:");
    Separador;
    Vetor_Random.Funcoes.Print (Vet_Teste);
    Separador;
  end Print_Vet;

  ------------------------------------------------------------------------------
  procedure Gera_Vet is
  begin
    Vet_Teste := Vetor_Random.Funcoes.Generate;
    Print_Vet;
  end Gera_Vet;

  ------------------------------------------------------------------------------
  procedure Escolhe_Saida is
      Choice : Integer := 0;

  begin
    Txt.Put_Line (New_Line & "Escolha o formato da Saida: ");
    for I in Formato_Saida loop
      Txt.Put_Line (Integer'Image (Formato_Saida'Enum_Rep (I)) & ". " & I'Img);
    end loop;
    Txt.Put (" ==> ");
    Ada.Integer_Text_IO.Get (Choice);
    Print_Formato := Formato_Saida'Val (Choice - 1);
    Txt.Put_Line ("Escolhido: " & Print_Formato'Img);
    Separador;
  exception
    when Constraint_Error => Txt.Put_Line ("Opcao Invalida.");

  end Escolhe_Saida;
  ----------------------------------------------------------------------------
  function Rodar (Algoritmo : access Interface_Ordenacao.Object'Class)
                  return Test_Resultado is
    Vet   : Vetor_Random.Object := Vet_Teste;
    Inicio : Ada.Calendar.Time;
    Gasto  : Duration;
    use type Ada.Calendar.Time;

  begin
    Inicio := Ada.Calendar.Clock;
    Vet   := Algoritmo.Sort (Vet_Teste);
    Gasto  := Ada.Calendar.Clock - Inicio;

    return (Test_Nome => To_Unbounded_String (Algoritmo.Nome),
            Tempo_Exec  => Gasto,
            Output    => Vet);
  end Rodar;
  ------------------------------------------------------------------------------
  procedure Escolhe_Algoritmo is
    Choice : Integer := 0;
  begin
      Txt.Put_Line (New_Line & "Escolha o Algoritmo: ");
    for I in Algoritmos.Algoritmo_Range loop
      Txt.Put_Line (I'Img & ". " & Algoritmos.Get_Algoritmo (I).Nome);
    end loop;

    Txt.Put (" ==> ");
    Ada.Integer_Text_IO.Get (Choice);
    Algoritmo_Atual := Algoritmos.Get_Algoritmo (Choice);
    Txt.Put_Line ("Escolhido: " & Algoritmos.Get_Algoritmo (Choice).Nome);
    Separador;
  exception
    when Algoritmos.Invalid_Index => Txt.Put_Line ("Invalid Choice.");
  end Escolhe_Algoritmo;
  ------------------------------------------------------------------------------
  procedure Resultado_Algoritmo is
    Resultado : constant Test_Resultado := Rodar (Algoritmo_Atual);
  begin
    Txt.Put_Line ("Nome:  " & To_String (Resultado.Test_Nome));
    case Print_Formato is

      when Completo =>
        Vetor_Random.Funcoes.Print (Resultado.Output);
        Txt.Put_Line ("Time:  " & Resultado.Tempo_Exec'Img);
         Txt.Put_Line ("Check: " & Boolean'Image (Vetor_Random.Funcoes.Is_Sorted (Resultado.Output)));

      when Resumo_Tempo =>
         Txt.Put_Line ("Time: " & Resultado.Tempo_Exec'Img);

      when Resumo_Resultado =>
        Txt.Put_Line ("Resultado:");
        Vetor_Random.Funcoes.Print (Resultado.Output);

      when Verifica =>
        Txt.Put_Line ("Check: " & Boolean'Image (Vetor_Random.Funcoes.Is_Sorted (Resultado.Output)));
    end case;
  end Resultado_Algoritmo;
  ------------------------------------------------------------------------------
  procedure Print (Resultados : in Test_Resultados) is

    ----------------------------------------------------------------------------
    procedure Print_Resultados is
    begin

      Txt.Put_Line ("Sort Resultados:");
      Separador;
      for I in Resultados'Range loop
        Txt.Put_Line (To_String (Resultados (I).Test_Nome));
        Vetor_Random.Funcoes.Print (Resultados (I).Output);
      end loop;
    end Print_Resultados;
    ----------------------------------------------------------------------------
    procedure Print_Tempos is
    begin

      Txt.Put_Line ("Tempos: ");
      Separador;
      for I in Resultados'Range loop
        Txt.Put_Line (To_String (Resultados (I).Test_Nome) & ": " & Resultados (I).Tempo_Exec'Img);
      end loop;
    end Print_Tempos;
    ----------------------------------------------------------------------------
    procedure Print_Verificacao is
    begin

      Txt.Put_Line ("Verificacao: ");
      Separador;

      for I in Resultados'Range loop
        Txt.Put_Line (To_String (Resultados (I).Test_Nome) & ": " & Vetor_Random.Funcoes.Is_Sorted (Resultados (I).Output)'Img);
      end loop;

    end Print_Verificacao;
  ------------------------------------------------------------------------------
  begin

    Print_Vet;
    case Print_Formato is

      when Completo =>
        Print_Resultados;
        Separador;
        Print_Tempos;
        Separador;
        Print_Verificacao;
        Separador;

      when Resumo_Tempo => Print_Tempos;

      when Resumo_Resultado => Print_Resultados;

      when Verifica => Print_Verificacao;

    end case;

  end Print;

  ------------------------------------------------------------------------------
  procedure Rodar_Todos is
    Resultados : Test_Resultados;
  begin
    for I in Algoritmos.Algoritmo_Range loop
      Resultados (I) := Rodar (Algoritmos.Get_Algoritmo (I));
    end loop;
    Print (Resultados);
  end Rodar_Todos;

  ------------------------------------------------------------------------------
  procedure Sair is
  begin
    raise Exit_Exception;
  end Sair;
  ------------------------------------------------------------------------------
  type Opcao is record
    Nome     : Unbounded_String;
    Chamada : access procedure;
  end record;

  Opcoes : constant array (Positive range 1 .. 6) of Opcao :=
    ((To_Unbounded_String ("Gerar outro vetor"),     Gera_Vet'Access),
     (To_Unbounded_String ("Mudar Formato da saida"),Escolhe_Saida'Access),
     (To_Unbounded_String ("Escolher Algoritmo"),    Escolhe_Algoritmo'Access),
     (To_Unbounded_String ("Ordenar"),               Resultado_Algoritmo'Access),
     (To_Unbounded_String ("Rodar Todos Algoritmos"),Rodar_Todos'Access),
     (To_Unbounded_String ("Sair"),                  Sair'Access));
  ------------------------------------------------------------------------------
  procedure Prompt is
    Choice : Integer := 0;
  begin
    Print_Vet;
    while True loop
      Txt.Put_Line ("");

      for I in Opcoes'Range loop
            Txt.Put_Line (I'Img & ". " & To_String (Opcoes (I).Nome));
      end loop;

      Txt.Put_Line (New_Line & "Formato da Saida:     " & Print_Formato'Img);
      Txt.Put_Line ("Algoritmo: " & Algoritmo_Atual.Nome & New_Line);

      Txt.Put_Line (New_Line & "Escolha uma Opcao: ");
      Ada.Integer_Text_IO.Get (Choice);

      if Choice in Opcoes'Range then
        Opcoes (Choice).Chamada.all;
      else
        Txt.Put_Line ("Opcao Invalida.");
      end if;
    end loop;

  exception
    when Exit_Exception => Txt.Put_Line ("Saindo.");

  end Prompt;
end Interface_In_Out;
