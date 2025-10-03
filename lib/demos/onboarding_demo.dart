// Demo 2: Proceso de Onboarding
import 'package:flutter/material.dart';
import 'package:flutter_step_indicator/widgets/step_indicator.dart';

class OnboardingDemo extends StatefulWidget {
  const OnboardingDemo({super.key});

  @override
  State<OnboardingDemo> createState() => _OnboardingDemoState();
}

class _OnboardingDemoState extends State<OnboardingDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Registro de Nuevo Usuario',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Proceso completo de creación de cuenta',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),

          StepIndicator(
            currentStep: _currentStep,
            totalSteps: 3,
            steps: const ["Datos Básicos", "Verificación", "Personalización"],
            completedColor: Colors.blue,
            incompleteColor: Colors.grey[300]!,
            stepSize: 35,
          ),

          const SizedBox(height: 40),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildStepContent(),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _currentStep > 0
                    ? () {
                        setState(() {
                          _currentStep--;
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.grey[800],
                ),
                child: const Text('Atrás'),
              ),
              ElevatedButton(
                onPressed: _currentStep < 2
                    ? () {
                        setState(() {
                          _currentStep++;
                        });
                      }
                    : null,
                child: Text(_currentStep == 2 ? 'Completar' : 'Continuar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información Personal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nombre completo'),
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verificación de Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Hemos enviado un código de verificación a tu email.'),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Código de verificación',
                hintText: 'Ingresa el código de 6 dígitos',
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.email),
              label: const Text('Reenviar código'),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personaliza tu Experiencia',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Selecciona tus intereses:'),
            const SizedBox(height: 15),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  [
                        'Tecnología',
                        'Deportes',
                        'Música',
                        'Arte',
                        'Ciencia',
                        'Viajes',
                      ]
                      .map(
                        (interest) => FilterChip(
                          label: Text(interest),
                          selected: false,
                          onSelected: (bool value) {},
                        ),
                      )
                      .toList(),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
