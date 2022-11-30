import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickMapAddress extends StatefulWidget {
  const PickMapAddress(
      {Key? key,
      required this.fromAddress,
      required this.fromSignUp,
      required this.controller})
      : super(key: key);

  final bool fromAddress;
  final bool fromSignUp;
  final GoogleMapController controller;

  @override
  State<PickMapAddress> createState() => _PickMapAddressState();
}

class _PickMapAddressState extends State<PickMapAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(children: [


           // GoogleMap(initialCameraPosition: CameraPosition(target: target))

          
          ]),
        ),
      )),
    );
  }
}
