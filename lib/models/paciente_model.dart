class Paciente {
  final int idPaciente;
  final String numeroIdentificacion;
  final String nombresPaciente;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String fechaNacimiento;
  final String telefono;
  final int emailId;
  final int idEmail;
  final String email;

  Paciente({
    this.idPaciente =
        0, // Hacemos idPaciente opcional y le asignamos un valor predeterminado
    required this.numeroIdentificacion,
    required this.nombresPaciente,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaNacimiento,
    required this.telefono,
    required this.emailId,
    required this.idEmail,
    required this.email,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      idPaciente: json['idPaciente'] ?? 0,
      numeroIdentificacion: json['numero_identificacion'] ?? '',
      nombresPaciente: json['nombres_paciente'] ?? '',
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      fechaNacimiento: json['fecha_nacimiento'] ?? '',
      telefono: json['telefono'] ?? '',
      emailId: json['email_idemail'] ?? 0,
      idEmail: json['idemail'] ?? 0,
      email: json['email'] ?? '',
    );
  }
}
