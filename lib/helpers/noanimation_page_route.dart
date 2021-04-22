import 'package:flutter/material.dart';

class NoAnimationMaterialPageRoute extends MaterialPageRoute {
  NoAnimationMaterialPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
