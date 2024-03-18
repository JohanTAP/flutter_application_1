class Radiografia {
  final String rutaRadiografia;

  Radiografia({required this.rutaRadiografia});

  factory Radiografia.fromJson(Map<String, dynamic> json) {
    return Radiografia(
      rutaRadiografia: json['ruta_radiografia'],
    );
  }
}
