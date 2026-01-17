import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/consulta_provider.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/responsive_layout.dart';

class PaginaTipoConsulta extends StatelessWidget {
  const PaginaTipoConsulta({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ConsultaProvider>(context, listen: false);
    final theme = Theme.of(context);

    final lista = ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: service.tiposConsulta.length,
      itemBuilder: (context, index) {
        final tipo = service.tiposConsulta[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(tipo),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
            onTap: () => context.push('/formulario', extra: tipo),
          ),
        );
      },
    );

    return CustomScaffold(
      title: 'SerraInnova',
      body: ResponsiveLayout(
        mobileBody: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  '¿En qué podemos ayudarte?', // ← FRASE PRINCIPAL
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Elige el motivo de tu consulta y te ayudaremos lo antes posible',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                lista,
              ],
            ),
          ),
        ),
        tabletBody: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(padding: const EdgeInsets.all(32.0), child: lista),
          ),
        ),
        desktopBody: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: lista),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      children: [
                        // Opcional: imagen de fondo sostenible
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
