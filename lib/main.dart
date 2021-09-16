import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(SliderDemo());
}

class SliderDemo extends StatefulWidget {
  const SliderDemo({Key? key}) : super(key: key);

  @override
  _SliderDemoState createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(parent: controller, curve: Curves.easeInCubic);

    // TODO: implement initState
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void rAnimattion() {
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.accents,
      Colors.blue,
      Colors.yellow,
      Colors.brown,
      Colors.cyan
    ];
    return MaterialApp(
      title: "Slider Demo",
      home: AnimatedBuilder(
        animation: controller,
        child: Container(
            child: CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
              Container(
            color: index % 2 == 0 ? Colors.amber : Colors.green,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ItemAnimation(
              animation: _animation,
            ),
          ),
          options: CarouselOptions(
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            enableInfiniteScroll: false,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              rAnimattion();
            },
          ),
        )),
        builder: (BuildContext context, Widget? child) {
          return child!;
        },
      ),
    );
  }
}

class ItemAnimation extends AnimatedWidget {
  final Animation<double> animation;
  const ItemAnimation({Key? key, required Animation<double> this.animation})
      : super(key: key, listenable: animation);
  static final _imageTween = Tween<double>(begin: 0.0, end: 300.0);
  static final _textTween = Tween<double>(begin: 20.0, end: 200.0);
  static final _opacityTween = Tween<double>(begin: 0.2, end: 1.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -(300 - _imageTween.evaluate(animation)),
            left: 0,
            child: Container(
              height: 300,
              width: 500,
              decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://1.bp.blogspot.com/-hN0NCoAmEDY/X8z1OcRjXmI/AAAAAAAAlc0/hHqbHzqOPhIABiVomzpYacPeEufV816QQCNcBGAsYHQ/s0/hinh-nen-may-cuc-dep.jpg"),
                      fit: BoxFit.cover)),
            )),
        Positioned(
          top: 320,
          left: 50,
          child: Text(
            "Titleeeeeee",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        Positioned(
          bottom: _textTween.evaluate(animation),
          child: Opacity(
            opacity: _opacityTween.evaluate(animation),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Version 3 refactored the code so that common animation controls were moved to AnimatedTextKit and all animations, except for TextLiquidFill, extend from AnimatedText. This saved hundreds of lines of duplicate code, increased consistency across animations, and makes it easier to create new animations.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        )
      ],
    );
  }
}
