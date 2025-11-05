class Vaga {
  int? id;
  String numero;
  bool ocupada;

  Vaga({this.id, required this.numero, this.ocupada = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numero': numero,
      'ocupada': ocupada ? 1 : 0,
    };
  }

  factory Vaga.fromMap(Map<String, dynamic> map) {
    return Vaga(
      id: map['id'],
      numero: map['numero'],
      ocupada: map['ocupada'] == 1,
    );
  }
}
