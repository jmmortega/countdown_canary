
import 'package:countdown_canary/main/bloc/main_bloc.dart';
import 'package:countdown_canary/main/view/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) => MainBloc(IdleState(
          time: DateTime.now())),

      child: MainView(),
    );
  }


  

}