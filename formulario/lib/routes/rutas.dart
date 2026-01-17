import 'package:go_router/go_router.dart';

import 'package:formulario/pages/pagina_principal.dart';
import '../pages/pagina_tipo_consulta.dart';
import '../pages/pagina_formulario.dart';
import '../pages/pagina_confirmacion.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const PaginaHome()),
    GoRoute(
      path: '/tipo-consulta',
      builder: (context, state) => const PaginaTipoConsulta(),
    ),
    GoRoute(
      path: '/formulario',
      builder: (context, state) =>
          PaginaFormulario(tipoSeleccionado: state.extra as String),
    ),
    GoRoute(
      path: '/confirmacion',
      builder: (context, state) =>
          PaginaConfirmacion(ticketId: state.extra as String),
    ),
  ],
);
