import './view/auth.dart';
import '../../core/navigation/routes.dart';

class AuthRoutes {
  final authenticate = Route(
    builder: (_) => AuthenticateView(),
  );
}
