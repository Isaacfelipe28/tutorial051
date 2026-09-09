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

enum Visibilidade {public, private, vip}


class _AgendamentoEventoTelaState extends State<AgendamentosEventoTela> {

  static final DateTime _datapadrao = DateTime.now();
  static const TimeOfDay _horarioPadrao = TimeOfDay(hour: 19, minute: 0);
  static const String _tipoPadrao = 'Aniversario';
  static const double _convidaoPadrao = 50.0;
  static const Visibilidade _visibilidadePadrao = .private;

  static const Map<String, bool> _servicosPadrao = {
    'Buffet': false,
    'Fotógrafo': false,
    'Decoração': false,
    'DJ': false,
  };

  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;
  late String _tipoEventoSelecionado;
  late double _quantidadeConvidados;
  late Visibilidade visibilidadeSelecionada;
  late Map<String, bool> _servicosSelecionado
  
  @override
  void initstate() {
    setState((){
      _dataSelecionada = _datapadrao;
      _horarioSelecionado = _horarioPadrao;
      _tipoEventoSelecionado =_tipoPadrao;
      _quantidadeConvidados = _convidaoPadrao;
      _visibilidadeSelecionada = _visibilidadePadrao;
      _servicosSelecionado = Map<String, bool>.from(_servicosPadrao);
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
    print('Estimativa de Convidados: ${_quantidadeConvidados.round()}');
    print('Visibilidade: $_visibilidadeSelecionada')
    print('Serviços Adicionais: $_servicosSelecionado')
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text (
                  'Quantidade de Convidados',
                  style: Theme.of(context).textTheme.titleMedium,
                ), // Text
                Text(
                  '${_quantidadeConvidados.round()} pessoas',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ]
            ), 
            Slider(
              value: quantidadeConvidados,
              min: 10,
              max: 500,
              divisions: 49,
              label: _quantidadeConvidados.round().toString(),
              onChanged: (novoValor) {
                setState(() {
                  quantidadeConvidados = novoValor;
                });
                print(
                  '[DEBUG - Slider] Quantidade de convidados: ${novoValor.round()}',
                ); 
              },
            ),
            const Divider(height: 32),

            Text(
              'Visibilidade do Evento',
              style: Theme.of(context).textTheme.titleMedium,
            ), 
            RadioGroup<Visibilidade>(
              groupValue: visibilidadeSelecionada
              onChanged: (Visibilidade? visibilidade) {
                setState(() {
                  visibilidadeSelecionada = visibilidade !;
                  print('[DEBUG - Radio] Visibilidade: $visibilidade');
                });
              },
              child: Column(
                children: [
                  ListTile(
                    title: Text('Publico'),
                    leading: Radio<Visibilidade>(value: Visibilidade.public)
                  ), // ListTile

                  ListTile(
                    title: Text('Privado'),
                    leading: Radio<Visibilidade>(value: Visibilidade.private),
                  ), // ListTile
                  ListTile(
                    title: Text('Apenas Convidados'),
                    leading: Radio<Visibilidade>(value: Visibilidade.vip),
                  ),
                ],
              ), 
            ), 
            const Divider(height: 32),
            Text(
              'Serviços Adicionais',
              style: Theme.of(context).textTheme.titleMedium,
            ), // Text
            Column(
              children: _servicosSelecionados.keys.map((servico) {
                return CheckboxListTile(
                  dense: true,
                  title: Text(servico)
                  value: servicosSelecionados[servico],
                  onChanged: (bool? marcado) {
                      setState(() {
                      _servicosSelecionados[servico] = marcado ?? false;
                    });
                    print(
                      '[DEBUG - Checkbox] Servico "$servico" alterado para: $marcado'
                    )
                  }
                ); 
              }) .toList(),
            ), 
            const Divider(height: 32),

          ],
        ),
      ),
    );
  }
}