import 'dart:ui';

import 'package:flutter/material.dart';

class KgpBasePage extends StatelessWidget {
  final String title;
  final Widget background;
  final Widget scrollList;
  // final Widget persistentHeader;
  final List<Widget> actions;
  final List<Widget> children;
  final double expandedHeight;
  final Color backgroundColor;
  final SliverChildDelegate sliverList;

  const KgpBasePage({
    Key key,
    this.expandedHeight,
    this.actions,
    this.background,
    this.title,
    this.children,
    // this.persistentHeader,
    this.scrollList,
    this.sliverList,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.transparent,
          expandedHeight: expandedHeight != null
              ? expandedHeight
              : MediaQuery.of(context).size.height / 3,
          pinned: true,
          floating: false,
          elevation: 0.0,
          actions: actions,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(bottom: 0),
            background: background,
            title: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 7,
                        sigmaY: 7,
                      ),
                      child: Container(
                        color:
                            Theme.of(context).backgroundColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 4,
                      child: Text(
                        title != null ? title : '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: true,
            // collapseMode: CollapseMode.pin,
          ),
        ),
        // persistentHeader != null
        //     ? SliverPersistentHeader(
        //         pinned: true,
        //         floating: false,
        //         delegate: Delegate(child: persistentHeader),
        //       )
        //     : SliverToBoxAdapter(),
        sliverList == null
            ? SliverToBoxAdapter(
                child: Container(
                  child: Column(
                    children: children,
                  ),
                ),
              )
            : SliverList(delegate: sliverList)
      ],
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  Delegate({this.child});
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Theme.of(context).backgroundColor,
        child: child,
      );

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 69;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
