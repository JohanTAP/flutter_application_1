class Orden {
  final int idorden;
  final int idPaciente;
  final int idUsuarioRecepcionista;
  final int idDoctor;
  final int? idAsistenteDental;
  final String fechaSolicitud;
  final String horaSolicitud;
  final String nombresPaciente;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String fechaNacimiento;
  final String telefono;
  final String email;
  final String nombreDoctor;
  final String sucursal;

  Orden({
    required this.idorden,
    required this.idPaciente,
    required this.idUsuarioRecepcionista,
    required this.idDoctor,
    this.idAsistenteDental,
    required this.fechaSolicitud,
    required this.horaSolicitud,
    required this.nombresPaciente,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.telefono,
    required this.email,
    required this.nombreDoctor,
    required this.sucursal,
  });

  factory Orden.fromJson(Map<String, dynamic> json) {
    return Orden(
      idorden: json['idorden'] ?? 0,
      idPaciente: json['paciente']['idpaciente'] ?? 0,
      idUsuarioRecepcionista: json['recepcionista'][0]['idusuario'] ?? 0,
      idDoctor: json['doctor']['iddoctor'] ?? 0,
      idAsistenteDental: json['asistente_dental']?['idasistente_dental'],
      fechaSolicitud: json['fecha_solicitud'] ?? '',
      horaSolicitud: json['hora_solicitud'] ?? '',
      nombresPaciente: json['paciente']['nombres_paciente'] ?? '',
      apellidoPaterno: json['paciente']['apellido_paterno'] ?? '',
      apellidoMaterno: json['paciente']['apellido_materno'] ?? '',
      fechaNacimiento: json['paciente']['fecha_nacimiento'] ?? '',
      telefono: json['paciente']['telefono'] ?? '',
      email: json['paciente']['email'] ?? '',
      nombreDoctor: json['doctor']['nombre'] ?? '',
      sucursal: json['recepcionista'][0]['sucursal'] ?? '',
    );
  }
}
