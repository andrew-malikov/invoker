import 'package:Invoker/src/dependency_container.dart';
import 'package:Invoker/src/services/dependency_service.dart';

class ContainerFactory {
  DependencyContainer empty() => DependencyService.empty();
}
