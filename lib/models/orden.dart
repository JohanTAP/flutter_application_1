class Orden {
  final int idorden;

  Orden({
    required this.idorden,
  });

  factory Orden.fromJson(Map<String, dynamic> json) {
    return Orden(
      idorden:
          json['idorden'] ?? 0, // Si es nulo, asigna un valor predeterminado
    );
  }
}
