with Vetor_Ordenavel;

package Vetor_Random is
  package Funcoes is new Vetor_Ordenavel(Min  => 0, Max  => 999, Size => 500);
  subtype Object is Funcoes.Object;

end Vetor_Random;
