part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  @override

  List<Object?> get props => [];
}

class IdleState extends MainState {
  IdleState({required this.time});

  final DateTime time;

}