import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_scaffold.dart';

class PaginaConfirmacion extends StatelessWidget {
  final String ticketId;
  const PaginaConfirmacion({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: '¡Consulta enviada!',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 120, height: 120),
              const SizedBox(height: 24),
              const Text(
                '¡Gracias por contactar con SERRA INNOVA!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Hemos recibido tu consulta correctamente.\n'
                'Nuestro equipo la revisará con cariño y compromiso social.\n'
                'Te responderemos lo antes posible.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Text(
                'Número de referencia: $ticketId',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Tiempo estimado: menos de 48 horas'),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
