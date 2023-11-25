import 'package:chess/core/widgets/w_scale.dart';
import 'package:flutter/material.dart';

import '../../constants/icons.dart';

class MainButton extends StatefulWidget {
  final String destination;
  final String text;
   const MainButton({
    Key? key,
    required this.destination,
    required this.text,
  }): super(key: key);

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: WScale(
        onTap: (){
          Navigator.of(context)
              .pushNamed(widget.destination);
        },
        child: Container(
          width: double.maxFinite,
          height: 70,
          alignment: Alignment.center,

          child: Stack(
            children: [
              Align(alignment: Alignment.center,
                  child: Image.asset(AppIcons.mainButton)),
              Align(alignment: Alignment.center,
                child: Text(widget.text,
                  style: Theme.of(context).textTheme.labelLarge,),
              )
            ],
          ),
          // Image.asset(AppIcons.mainButton),
        ),
      ),
    );
  }
}
