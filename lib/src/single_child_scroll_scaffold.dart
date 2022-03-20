import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterloo/waterloo.dart';

class SingleChildScrollScaffold extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool act;
  final Widget child;

  const SingleChildScrollScaffold({Key? key, required this.title, this.subTitle, this.act = true, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WaterlooAppBar.get(
            title: Provider.of<WaterlooTextProvider>(context, listen: false).get(title) ?? '',
            context: context,
            subtitle: Provider.of<WaterlooTextProvider>(context, listen: false).get(subTitle) ?? '',
            handleAction: act ? () {} : null),
        body: SingleChildScrollView(child: child));
  }
}

class ContainerScaffold extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool act;
  final Widget child;

  const ContainerScaffold({Key? key, required this.title, this.subTitle, this.act = true, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WaterlooAppBar.get(
            title: Provider.of<WaterlooTextProvider>(context, listen: false).get(title) ?? '',
            context: context,
            subtitle: Provider.of<WaterlooTextProvider>(context, listen: false).get(subTitle) ?? '',
            handleAction: act ? () {} : null),
        body: Container(child: child));
  }
}
