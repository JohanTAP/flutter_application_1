class RutValidator {
  static bool validarRut(String rut) {
    // Eliminar puntos y guiones del RUT
    rut = rut.replaceAll(RegExp(r'[.-]'), '');

    // Validar el formato del RUT
    if (!RegExp(r'^\d{7,8}[0-9kK]$').hasMatch(rut)) {
      // El RUT no tiene el formato correcto
      return false;
    }

    // Separar el dígito verificador del resto del RUT
    final rutNumbers = rut.substring(0, rut.length - 1);
    final dv = rut.substring(rut.length - 1).toUpperCase();

    // Calcular el dígito verificador esperado
    final calculatedDv = calcularDigitoVerificador(rutNumbers);

    // Comparar el dígito verificador calculado con el proporcionado
    return calculatedDv == dv;
  }

  static String calcularDigitoVerificador(String numbers) {
    final List<int> factor = [2, 3, 4, 5, 6, 7];
    int sum = 0;
    int j = 0;

    // Recorremos los números del RUT en orden inverso y aplicamos el algoritmo
    for (int i = numbers.length - 1; i >= 0; i--) {
      sum += int.parse(numbers[i]) * factor[j];
      j = (j + 1) % 6;
    }

    // Calculamos el dígito verificador
    int dv = 11 - (sum % 11);
    return (dv == 10)
        ? 'K'
        : (dv == 11)
            ? '0'
            : dv.toString();
  }
}
