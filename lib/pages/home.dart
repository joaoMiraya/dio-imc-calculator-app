import 'package:flutter/material.dart';

class IMC {
  final double weight;
  final double height;

  IMC({required this.weight, required this.height});

  double get imc {
    var result = weight / (height * height);
    return result;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textFieldController1 = TextEditingController();
  final TextEditingController _textFieldController2 = TextEditingController();

  List<String> imcResults = [];

  void calculateIMC() {
    final weightInput = _textFieldController1.text;
    final heightInput = _textFieldController2.text;

    if (weightInput.isEmpty || heightInput.isEmpty) {
      setState(() {
        imcResults.add('Preencha ambos os campos.');
      });
      return;
    }

    final weight = double.tryParse(weightInput);
    final height = double.tryParse(heightInput);

    if (weight == null || height == null || weight <= 0 || height <= 0) {
      setState(() {
        imcResults.add(
            'Valores inválidos. Insira um numero decimal positivo. Ex: 1.80. ');
      });
    } else {
      final imc = IMC(weight: weight, height: height);
      setState(() {
        imcResults.add('Seu IMC é: ${imc.imc.toStringAsFixed(2)}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _textFieldController1,
                  decoration:
                      const InputDecoration(labelText: 'Insira o seu peso'),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _textFieldController2,
                  decoration:
                      const InputDecoration(labelText: 'Insira a sua altura'),
                ),
              ),
              ElevatedButton(
                onPressed: calculateIMC,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.fromLTRB(36.0, 18.0, 36.0, 18.0),
                  ),
                ),
                child: const Text('Calcular meu IMC'),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(23.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(65.0),
                  child: ListView.builder(
                    itemCount: imcResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 20.0),
                        title: Text(
                          imcResults[index],
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
