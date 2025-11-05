import 'package:flutter/material.dart';
import '../models/vaga.dart';
import '../services/vaga_service.dart';
import 'form_vaga_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VagaService service = VagaService();
  List<Vaga> vagas = [];

  @override
  void initState() {
    super.initState();
    carregarVagas();
  }

  void carregarVagas() async {
    final lista = await service.listar();
    setState(() => vagas = lista);
  }

  void excluir(int id) async {
    await service.excluir(id);
    carregarVagas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estacionamento - Vagas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormVagaPage()),
          );
          carregarVagas();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: vagas.length,
        itemBuilder: (context, index) {
          final vaga = vagas[index];
          return ListTile(
            leading: Icon(
              vaga.ocupada ? Icons.car_repair : Icons.local_parking,
              color: vaga.ocupada ? Colors.red : Colors.green,
            ),
            title: Text('Vaga ${vaga.numero}'),
            subtitle: Text(vaga.ocupada ? 'Ocupada' : 'Livre'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FormVagaPage(vaga: vaga)),
                    );
                    carregarVagas();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => excluir(vaga.id!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
