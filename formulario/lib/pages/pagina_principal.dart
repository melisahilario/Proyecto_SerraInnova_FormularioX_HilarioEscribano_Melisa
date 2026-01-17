import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../provider/consulta_provider.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/tarjeta_consulta.dart';

class PaginaHome extends StatefulWidget {
  const PaginaHome({super.key});

  @override
  State<PaginaHome> createState() => _PaginaHomeState();
}

class _PaginaHomeState extends State<PaginaHome> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ConsultaProvider>(context, listen: false).cargarConsultas();
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ConsultaProvider>(context);
    return CustomScaffold(
      title: 'Consultas Recibidas - SerraInnova',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tipos de Consulta',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: service.tiposConsulta
                  .map((t) => Chip(label: Text(t.split(' ').take(3).join(' '))))
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Lista de Consultas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: service.consultas.isEmpty
                  ? const Center(child: Text('No hay consultas'))
                  : ListView.builder(
                      itemCount: service.consultas.length,
                      itemBuilder: (context, index) {
                        final c = service.consultas[index];
                        return TarjetaConsulta(
                          consulta: c,
                          onDelete: () async {
                            final ok =
                                await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Eliminar'),
                                    content: const Text(
                                      '¿Seguro que quieres eliminar esta consulta?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, false),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, true),
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                ) ??
                                false;
                            if (ok)
                              await service.eliminarConsulta(c.documentId);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/tipo-consulta'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
