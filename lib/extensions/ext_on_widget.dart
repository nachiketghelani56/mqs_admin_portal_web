import 'package:flutter/material.dart';

extension ExtOnWidget on Widget {
  Widget tap(Function onTap) => InkWell(
        onTap: () {
          onTap();
        },
        child: this,
      );

  Widget get center => Center(child: this);
  Widget get centerRight =>
      Align(alignment: Alignment.centerRight, child: this);
  Widget get centerLeft => Align(alignment: Alignment.centerLeft, child: this);
}
