//import '../models/campaign.dart';
import 'text_field_card.dart';
import 'package:flutter/material.dart';
import 'package:donor_app/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({
    required this.buttonText,
    required this.route,
    selectedCampaign,
  });

  final String buttonText;
  final String route;
 // Campaign? selectedCampaign;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20,
      child: Align(
          alignment: Alignment.bottomCenter,
          child: TextFieldCard(
            isButton: true,
            childWidget: Center(
              child: TextButton(
                child: Text(
                  buttonText,
                  style: kTextStlye(FontWeight.bold, 16, Colors.white),
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, route,
                      //arguments: selectedCampaign?.id);
                },
              ),
            ),
          )),
    );
  }
}