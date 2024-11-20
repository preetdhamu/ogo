import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OGridViewUnequal extends StatelessWidget {
  OGridViewUnequal(
      {super.key,
      required this.builder,
      required this.items,
      this.physics,
      this.shrinkWrap = false});
  Widget Function(BuildContext, int) builder;
  int? items;
  ScrollPhysics? physics;
  bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.only(top: 0),
      itemCount: items,
      itemBuilder: builder,
    );
  }
}
