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

  late DateTime _dataSelecionada;
  late TimeOfDay _horarioSelecionado;
  
  @override
}