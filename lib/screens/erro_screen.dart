import 'package:flutter/material.dart';
import 'home_screen.dart'; // Importe sua tela inicial

class ErroScreen extends StatelessWidget {
  final String mensagem;
  final VoidCallback? onRetry;

  const ErroScreen({
    Key? key,
    this.mensagem = 'Ocorreu um erro inesperado.',
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.red.shade50,
        appBar: AppBar(
          title: const Text('Erro'),
          centerTitle: true,
          backgroundColor: Colors.red.shade400,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 80, color: Colors.red.shade500),
                const SizedBox(height: 24),
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 24),
                if (onRetry != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh, color: Colors.black,),
                    label: const Text(
                      'Calma, agora vai!',
                      style: TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade500,
                    ),
                    onPressed: onRetry,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
