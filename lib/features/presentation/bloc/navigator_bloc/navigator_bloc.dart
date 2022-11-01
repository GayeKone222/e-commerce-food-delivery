import 'package:e_commerce/core/Routes/navigation_service.dart';
import 'package:e_commerce/core/Routes/routes_name.dart';
import 'package:e_commerce/core/dependency_injection.dart/injections.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
 
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorState> {
  final NavigationService navigationService ;
  NavigatorBloc({required this.navigationService}) : super(NavigatorInitial()) {
    on<PushNamed>(_onPushNamed);
    on<PushNamedAndRemoveUntil>(_onPushNamedAndRemoveUntil);
    on<PushReplacementNamed>(_onPushReplacementNamed);
    on<Pop>(_onPop);
    on<PopAll>(_onPopAll);
  }

  void _onPushNamed(PushNamed event, Emitter<NavigatorState> emit) async {
    if (!navigationService.isCurrentRoute(event.route)) {
      emit(NavigatorLoading());
      navigationService.navigateTo(event.route,
          queryParams: event.queryParams, objectParam: event.objectParam);
      emit(Navigated());
    } else {
      if (kDebugMode) {
        print("route already shown");
      }
    }
  }

  void _onPushNamedAndRemoveUntil(
      PushNamedAndRemoveUntil event, Emitter<NavigatorState> emit) async {
    if (!navigationService.isCurrentRoute(event.route)) {
      emit(NavigatorLoading());
      navigationService.navigateToAndRemoveUntil(
          event.route, event.untilRoute!,
          queryParams: event.queryParams, objectParam: event.objectParam);
      emit(Navigated());
    } else {
      if (kDebugMode) {
        print("route already shown");
      }
    }
  }

  void _onPushReplacementNamed(
      PushReplacementNamed event, Emitter<NavigatorState> emit) async {
    if (!navigationService.isCurrentRoute(event.route)) {
      emit(NavigatorLoading());
      navigationService.navigateToAndReplacePrevious(event.route,
          queryParams: event.queryParams, objectParam: event.objectParam);
      emit(Navigated());
    } else {
      if (kDebugMode) {
        print("route already shown");
      }
    }
  }

  void _onPop(Pop event, Emitter<NavigatorState> emit) async {
    emit(NavigatorLoading());
    navigationService.goBack();
    emit(Navigated());
  }

  void _onPopAll(PopAll event, Emitter<NavigatorState> emit) async {
    navigationService.navigateToAndRemoveUntil(Routes.HomeRoute, "/");
  }
}
