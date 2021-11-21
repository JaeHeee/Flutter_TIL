import 'package:flutter/material.dart';

class TilButton extends StatelessWidget {
  const TilButton({
    required this.title,
    required this.routeName,
    Key? key,
  }) : super(key: key);

  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(routeName);
            },
            child: const Text('Example'),
          )
        ],
      ),
    );
  }
}
