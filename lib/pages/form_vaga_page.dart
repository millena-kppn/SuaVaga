import 'package:flutter/material.dart';
import '../models/vaga.dart';
import '../services/vaga_service.dart';

class FormVagaPage extends StatefulWidget {
  final Vaga? vaga;
  const FormVagaPage({super.key, this.vaga});

  @override
  State<FormVagaPage> createState() => _FormVagaPageState();
}

class _FormVagaPageState extends State<FormVagaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroController = TextEditingController();
  bool _ocupada = false;
  final service = VagaService();

  @override
  void initState() {
    super.initState();
    if (widget.vaga != null) {
      _numeroController.text = widget.vaga!.numero;
      _ocupada = widget.vaga!.ocupada;
    }
  }

  void salvar() async {
    if (_formKey.currentState!.validate()) {
      final vaga = Vaga(
        id: widget.vaga?.id,
        numero: _numeroController.text,
        ocupada: _ocupada,
      );

      if (widget.vaga == null) {
        await service.inserir(vaga);
      } else {
        await service.atualizar(vaga);
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vaga == null ? 'Nova Vaga' : 'Editar Vaga'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(
                  labelText: 'Número da vaga',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o número da vaga' : null,
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Vaga ocupada?'),
                value: _ocupada,
                onChanged: (v) => setState(() => _ocupada = v),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
