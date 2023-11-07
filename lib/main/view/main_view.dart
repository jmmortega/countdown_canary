import 'package:countdown_canary/controls/boat_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'package:countdown_canary/main/bloc/main_bloc.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocConsumer<MainBloc, MainState>(
      listener: _runningListenerStates,
      builder: (builder, state) {
        return Scaffold(
            body: Container(
                color: Color(0xFF87ceeb),
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                    children: [
                      _buildBirdsFlying(context, state),
                      Center(
                  child: _buildCountDownText(context, state)),
                      _buildBirdsFlying(context, state),
                  ],)),

                    Align(
                        child: Container(
                      height: 256,
                      child: Stack(children: _setLayers(context, state)),
                    ))
                  ],
                )));
      });


  Widget _buildDeepWave(BuildContext context, Object? state) {
    return WaveWidget(
        config: CustomConfig(
          colors: [
            Color(0xFF064273),
          ],
          durations: [
            10000,
          ],
          heightPercentages: [
            0.40,
          ],
        ),
        size: Size(double.infinity, 200));
  }

  Widget _buildMidWave(BuildContext context, Object? state) {
    return WaveWidget(
        config: CustomConfig(
          colors: [
            Color(0xFF76B6C4),
          ],
          durations: [
            9000,
          ],
          heightPercentages: [
            0.50,
          ],
        ),
        size: Size(double.infinity, 250));
  }

  Widget _buildFirstWave(BuildContext context, Object? state) {
    return WaveWidget(
        config: CustomConfig(
          colors: [
            Color(0xFF1da2d8),
          ],
          durations: [
            8000,
          ],
          heightPercentages: [
            0.40,
          ],
        ),
        size: Size(double.infinity, double.infinity));
  }


  Widget _buildBoat(BuildContext context, MainState state)
    => const BoatAnimated();


  Widget _buildIsland(BuildContext context, MainState state) {
    return const Image(image: AssetImage('assets/images/island.png'));
  }

  Widget _buildBirdsFlying(BuildContext context, MainState state) {
    return Lottie.asset('assets/animations/birds_flying.json', width: 150);
  }

  void _runningListenerStates(BuildContext context, state) {}

  Widget _buildCountDownText(BuildContext context, MainState state) {
    if(state is IdleState) {
      if(_boatArrive(state)) {
        return Text('¡Llegue!',
            style: TextStyle(
                color: Colors.white,
                fontSize: 64));
      } else {
        final difference = DateTime.parse('2023-11-16 09:00:00').difference(state.time);
        if(difference.inDays == 0) {
          return Text('Quedan ${difference.inHours} horas',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
              ));
        } else {
          return Text('Quedan ${difference.inDays} días',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
              ));
        }

      }

    }
    return SizedBox.shrink();

  }

  List<Widget> _setLayers(BuildContext context, MainState state) {
    final layers = List<Widget>.empty(growable: true);

    if(state is IdleState) {
      layers.add(_buildDeepWave(context, state));
      layers.add(_buildMidWave(context, state));
      layers.add(_buildFirstWave(context, state));

      if(_boatArrive(state)) {
          layers.add(Align(alignment: Alignment.bottomRight,child: _buildIsland(context, state)));
          layers.add(Positioned(  bottom: 30, left: 75,
              child: const Image(image: AssetImage('assets/images/boat.png'),
                width: 150,)));
      } else {
        _setIslandLayer(context, state, layers);

        if(_boatAppear(state)) {
          layers.add(Positioned(  bottom: 30, child: _buildBoat(context, state)));
        }

      }
    }


    return layers;
  }

  void _setIslandLayer(BuildContext context, IdleState state, List<Widget> layers) {
    final indexIsland = _islandPosition(state);
    layers.insert(indexIsland, Align(alignment: Alignment.bottomRight,child: _buildIsland(context, state)));
  }

  int _islandPosition(IdleState state) {
    final days = DateTime.parse('2023-11-16').difference(state.time).inDays;
    if(days == 0) {
      return 2;
    }
    else if(days == 1) {
      return 1;
    }
    else {
      return 0;
    }

  }

  bool _boatArrive(IdleState state) {
    if(DateTime.parse('2023-11-16').difference(state.time).inDays == 0) {
      return !state.time.difference(DateTime.parse('2023-11-16 09:00:00')).isNegative;
    }
    return false;
  }

  bool _boatAppear(IdleState state) {
    if(DateTime.parse('2023-11-14').difference(state.time).inDays <= 0) {
      return !state.time.difference(DateTime.parse('2023-11-14 14:00:00')).isNegative;
    }
    return false;
  }




}
