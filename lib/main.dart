import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Agendamento de Evento",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial: true,
      ),

      home: const AgendamentosEventoTela(),
    );
  }
}

class AgendamentosEventoTela extends Statefulwidget (
  const AgendamentosEventoTela({super.key});

  @override
  State<AgendamentosEventoTela> createState() => _AgendamentoEventoTelaState();
),


class _AgendamentoEventoTelaState extends State<AgendamentosEventoTela> {

  static final DateTime _datapadrao = DateTime.now();
  static const TimeOfDay _horarioPadrao = TimeOfDay(hour: 19, minute: 0);
  static const String _tipoPadrao = 'Aniversario';

  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;
  late String _tipoEventoSelecionado;
  
  @override
  void initstate() {
    setState((){
      _dataSelecionada = _datapadrao;
      _horarioSelecionado = _horarioPadrao;
      _tipoEventoSelecionado =_tipoPadrao;
    });
    print('[DEBUG] Formulario resetado para os valores padrão.');
  }
  
  void _salvarFormulario() {
    print('===============================');
    print('     Resumo do agendamento     ');
    print('===============================');
    print(
      'Data: ${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}'
    );
    print('Horário: ${_horarioSelecionado.format(context)}');
    print('Tipo de evento: $_tipoEventoSelecionado');
    print('===============================');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Evento salvo com sucesso! Veja os log no console.'),
      ),
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo evento social'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data e Horario'
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      '${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}'
                    ).
                    onPressed: () => _selecionarData(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElavatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(_horarioSelecionado.format(context)),
                    onPressed: () => _selecionarHorario(context),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(
              'Tipo de Evento',
                style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _tipoEventoSelecionado,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              items: ['Aniversario', 'Casamento', 'Corporativo', 'Outro' ]
                  .map(
                    (tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)),
                  )
                  toList(),
              onChanged: (novoValor) {
                if (novoValor != null) {
                  setState(() {
                    _tipoEventoSelecionado = novoValor;
                  });
                  print(
                    '[DEBUG - Menu] Tipo de evento selecionado: $novoValor',
                  );
                }
              },
            )
            const Divider(height: 32),
          ],
        ),
      ),
    );
  }
}