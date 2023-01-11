import 'package:cabels/view/widgets/share/send_recive_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WaitingPage extends StatelessWidget {
  final String str1;
  final String str2;
  final String lottie;
  final Widget downWidget;
  final bool repeat;
  const WaitingPage({
    super.key,
    required this.str1,
    required this.str2,
    required this.downWidget,
    required this.lottie,
    this.repeat = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: SendReciveWidget(
              str1: str1,
              str2: str2,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  child: Lottie.asset(
                    lottie,
                    repeat: repeat,
                  ),
                ),
              ),
              Expanded(
                child: Container(width: double.infinity, child: downWidget),
              )
            ],
          ),
        ),
      ],
    );
  }
}
