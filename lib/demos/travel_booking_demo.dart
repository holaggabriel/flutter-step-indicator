// Demo 4: Proceso de Reserva de Viaje
import 'package:flutter/material.dart';
import 'package:flutter_step_indicator/widgets/step_indicator.dart';

class TravelBookingDemo extends StatefulWidget {
  const TravelBookingDemo({super.key});

  @override
  State<TravelBookingDemo> createState() => _TravelBookingDemoState();
}

class _TravelBookingDemoState extends State<TravelBookingDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reserva de Viaje',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Planifica tu próximo viaje paso a paso',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),

          StepIndicator(
            currentStep: _currentStep,
            totalSteps: 5,
            steps: const ["Destino", "Fechas", "Hotel", "Vuelo", "Confirmar"],
            completedColor: Colors.purple,
            incompleteColor: Colors.grey[300]!,
            textStyle: const TextStyle(fontSize: 12),
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
                child: const Text('Anterior'),
              ),
              ElevatedButton(
                onPressed: _currentStep < 4
                    ? () {
                        setState(() {
                          _currentStep++;
                        });
                      }
                    : null,
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getStepTitle(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(_getStepDescription()),
        const SizedBox(height: 20),
        Expanded(
          child: Center(
            child: Icon(_getStepIcon(), size: 80, color: Colors.purple[300]),
          ),
        ),
      ],
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Selecciona tu Destino';
      case 1:
        return 'Elige las Fechas';
      case 2:
        return 'Reserva tu Hotel';
      case 3:
        return 'Selecciona tu Vuelo';
      case 4:
        return 'Confirma tu Viaje';
      default:
        return '';
    }
  }

  String _getStepDescription() {
    switch (_currentStep) {
      case 0:
        return 'Elige el destino de tus sueños para tu próximo viaje.';
      case 1:
        return 'Selecciona las fechas de ida y vuelta para tu viaje.';
      case 2:
        return 'Encuentra el alojamiento perfecto para tu estadía.';
      case 3:
        return 'Selecciona los vuelos que mejor se adapten a tu itinerario.';
      case 4:
        return 'Revisa todos los detalles y confirma tu reserva.';
      default:
        return '';
    }
  }

  IconData _getStepIcon() {
    switch (_currentStep) {
      case 0:
        return Icons.location_on;
      case 1:
        return Icons.calendar_today;
      case 2:
        return Icons.hotel;
      case 3:
        return Icons.flight;
      case 4:
        return Icons.check_circle;
      default:
        return Icons.help;
    }
  }
}
