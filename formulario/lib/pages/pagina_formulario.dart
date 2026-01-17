import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/consulta.dart';
import '../provider/consulta_provider.dart';
import '../widgets/custom_scaffold.dart';

class PaginaFormulario extends StatefulWidget {
  final String tipoSeleccionado;
  const PaginaFormulario({super.key, required this.tipoSeleccionado});

  @override
  State<PaginaFormulario> createState() => _PaginaFormularioState();
}

class _PaginaFormularioState extends State<PaginaFormulario> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _telefonoCtrl;
  late TextEditingController _descripcionCtrl;
  bool _aceptacion = false;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _telefonoCtrl = TextEditingController();
    _descripcionCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _telefonoCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ConsultaProvider>(context, listen: false);

    return CustomScaffold(
      title: 'Completa tus datos',
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipo: ${widget.tipoSeleccionado}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _nombreCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Nombre y apellidos *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v?.trim().isEmpty ?? true ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v?.trim().isEmpty ?? true) return 'Requerido';
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(v!))
                          return 'Email inválido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _telefonoCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono (opcional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descripcionCtrl,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Descripción *',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      validator: (v) =>
                          v?.trim().isEmpty ?? true ? 'Requerido' : null,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text(
                        'Acepto la política de protección de datos *',
                      ),
                      value: _aceptacion,
                      onChanged: (v) => setState(() => _aceptacion = v!),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate() &&
                              _aceptacion) {
                            final consulta = Consulta(
                              tipo: widget.tipoSeleccionado,
                              nombreApellidos: _nombreCtrl.text.trim(),
                              email: _emailCtrl.text.trim(),
                              telefono: _telefonoCtrl.text.trim().isEmpty
                                  ? null
                                  : _telefonoCtrl.text.trim(),
                              descripcion: _descripcionCtrl.text.trim(),
                              aceptacionPrivacidad: _aceptacion,
                            );
                            try {
                              await service.agregarConsulta(consulta);
                              if (mounted)
                                context.go(
                                  '/confirmacion',
                                  extra: consulta.documentId,
                                );
                            } catch (e) {
                              if (mounted)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                            }
                          } else if (!_aceptacion) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Debe aceptar la política'),
                              ),
                            );
                          }
                        },
                        child: const Text('Enviar Consulta'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
