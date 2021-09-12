import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'isolate_utils.dart';

class IsolateScreen extends StatefulWidget {
  static const routeName = '/isolate-screen';
  const IsolateScreen({Key key}) : super(key: key);

  @override
  _IsolateScreenState createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  final IsolateUtils _isolateUtils = IsolateUtils();
  final String _url = 'https://randomuser.me/api';
  int _count = 0;
  String _isolateResult = 'isolateResult';
  String _computeResult = 'computeResult';

  @override
  void initState() {
    _isolateUtils.initIsolate();
    super.initState();
  }

  @override
  void dispose() {
    _isolateUtils.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
              child: const Text('Counter'),
            ),
            Text(_count.toString()),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: _isolateSpawn,
              child: const Text('Isolate.spawn'),
            ),
            Text(_isolateResult),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: _compute,
              child: const Text('Compute'),
            ),
            Text(_computeResult),
          ],
        ),
      ),
    );
  }

  void _isolateSpawn() async {
    final responsePort = ReceivePort();

    _isolateUtils.sendMessage(
      handler,
      _isolateUtils.sendPort,
      responsePort,
      params: _url,
    );

    final result = await responsePort.first;
    setState(() {
      _isolateResult = result.toString();
    });
  }

  void _compute() async {
    final result = await compute(handler, _url);
    setState(() {
      _computeResult = result;
    });
  }

  static Future<dynamic> handler(String url) async {
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);

    return json['results'][0]['email'];
  }
}
