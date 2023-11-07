import 'package:flutter/cupertino.dart';

class BoatAnimated extends StatefulWidget {
  const BoatAnimated({super.key});

  @override
  State<StatefulWidget> createState() => _BoatAnimatedState();

}

class _BoatAnimatedState extends State<BoatAnimated>
  with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
        vsync: this)
    ..repeat(reverse: true);

    _rotationAnimation = Tween<double>(begin: -0.05, end: 0.05)
    .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _rotationAnimation,
    child: const Image(image: AssetImage('assets/images/boat.png'),
      width: 150,));

  }
}