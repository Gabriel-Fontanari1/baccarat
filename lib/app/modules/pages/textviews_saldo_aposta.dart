import 'package:flutter/material.dart';

class TextViewSuaAposta extends StatefulWidget {
  const TextViewSuaAposta({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextViewSuaApostaState createState() => _TextViewSuaApostaState();
}

class _TextViewSuaApostaState extends State<TextViewSuaAposta> {
  int totalApostado = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 89, 17, 102), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'APOSTA: ${totalApostado > 0 ? '\$' : ''}$totalApostado',
            style: const TextStyle(
              color: Color.fromARGB(255, 123, 28, 139),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// TextView para exibir o saldo atualizado
class TextViewSeuSaldo extends StatelessWidget {
  final int saldo;

  const TextViewSeuSaldo({super.key, required this.saldo});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 72, 14, 82), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'SALDO: ${saldo == 0 ? '' : '\$'}$saldo',
            style: const TextStyle(
              color: Color.fromARGB(255, 123, 28, 139),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
