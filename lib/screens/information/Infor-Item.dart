import 'package:covid19/components/card-component.dart';
import 'package:covid19/models/covid-Infor.model.dart';
import 'package:covid19/screens/information/infor-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class InforItem extends StatelessWidget {
  const InforItem({
    Key key,
    @required this.data,
    this.index,
  }) : super(key: key);

  final CovidInfor data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CardComponent(
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 2.5,
              child: Image.asset(
                'assets/infor/${data.infor[index].image}',
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            FadeInDown(
              child: Text(
                data.infor[index].title ?? '',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InforPage(
            data: data.infor[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
