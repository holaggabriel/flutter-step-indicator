import 'package:flutter/material.dart';
import 'step_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Step Indicator')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ejemplo 1: Proceso de compra simple
              StepIndicator(
                currentStep: 2,
                totalSteps: 4,
                steps: const ["Inicio", "Carrito", "Pago", "Confirmación"],
                completedColor: Colors.green,
                incompleteColor: Colors.grey,
              ),

              const SizedBox(height: 40),

              // Ejemplo 2: Proceso de registro
              StepIndicator(
                currentStep: 2,
                totalSteps: 3,
                steps: const ["Datos personales", "Verificación", "Completado"],
                completedColor: Colors.blue,
                incompleteColor: Colors.grey[300]!,
              ),

              const SizedBox(height: 40),

              // Ejemplo 3: Proceso con errores
              StepIndicator(
                currentStep: 1,
                totalSteps: 4,
                steps: const ["Inicio", "Actual", "Validación", "Final"],
                completedColor: Colors.red,
                incompleteColor: Colors.grey,
                stepSize: 30,
                lineHeight: 8,
              ),

              const SizedBox(height: 40),

              // Ejemplo 4: Proceso largo
              StepIndicator(
                currentStep: 3,
                totalSteps: 10,
                steps: const [
                  "Paso 1",
                  "Paso 2 muy largo",
                  "Actual",
                  "Paso 4",
                  "Final",
                  "Paso 1",
                  "Paso 2 muy largo",
                  "Actual",
                  "Paso 4",
                  "Final",
                ],
                completedColor: Colors.purple,
                incompleteColor: Colors.grey,
                textStyle: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}