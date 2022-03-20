import 'package:flutter/material.dart';
import 'package:waterloo/waterloo.dart';


class EmptyPage extends StatelessWidget {

  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: WaterlooAppBar.get(title: 'Dummy Page', context: context,
        subtitle: 'POC Subtitle', handleAction: () { }),
        body: const Card( child: Text('This is a temporary Page'))
    );

  }
}


