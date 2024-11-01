import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cálculo de IMC",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: const IMCForm(),
          ),
        ),
      ),
    );
  }
}

class IMCForm extends StatefulWidget {
  const IMCForm({super.key});

  @override
  _IMCFormState createState() => _IMCFormState();
}

class _IMCFormState extends State<IMCForm> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String result = "";

  double calculateIMC(double weight, double height) {
    return weight / (height * height);
  }

  String getIMCCategory(double imc) {
    if (imc < 18.5) {
      return "Abaixo do Peso";
    } else if (imc < 24.9) {
      return "Peso Normal";
    } else if (imc < 29.9) {
      return "Sobrepeso";
    } else {
      return "Obesidade";
    }
  }

  void calculateAndShowIMC() {
    final double weight = double.tryParse(weightController.text) ?? 0;
    final double height = double.tryParse(heightController.text) ?? 0;

    if (weight > 0 && height > 0) {
      final double imc = calculateIMC(weight, height);
      final String category = getIMCCategory(imc);
      setState(() {
        result = "IMC: ${imc.toStringAsFixed(2)} - $category";
      });
    } else {
      setState(() {
        result = "Digite valores válidos.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Center(
          child: Text(
            "Height x Weight",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: weightController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Weight (kg)',
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: heightController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Height (m)',
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: calculateAndShowIMC,
            child: const Text("Calcular IMC"),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            result,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
