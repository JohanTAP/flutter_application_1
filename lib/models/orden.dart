class Orden {
  final int idorden;
  final int idPaciente;
  final int idUsuarioRecepcionista;
  final int idDoctor;
  final int? idAsistenteDental;

  Orden({
    required this.idorden,
    required this.idPaciente,
    required this.idUsuarioRecepcionista,
    required this.idDoctor,
    this.idAsistenteDental,
  });

  factory Orden.fromJson(Map<String, dynamic> json) {
    return Orden(
      idorden: json['idorden'] ?? 0,
      idPaciente: json['paciente']['idpaciente'] ?? 0,
      idUsuarioRecepcionista: json['recepcionista'][0]['idusuario'] ?? 0,
      idDoctor: json['doctor']['iddoctor'] ?? 0,
      idAsistenteDental: json['asistente_dental']?['idasistente_dental'],
    );
  }
}
