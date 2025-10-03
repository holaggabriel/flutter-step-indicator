// Demo 3: Proceso Documental
import 'package:flutter/material.dart';
import 'package:flutter_step_indicator/widgets/step_indicator.dart';

class DocumentProcessDemo extends StatefulWidget {
  const DocumentProcessDemo({super.key});

  @override
  State<DocumentProcessDemo> createState() => _DocumentProcessDemoState();
}

class _DocumentProcessDemoState extends State<DocumentProcessDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Proceso de Aprobación Documental',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Flujo de revisión y aprobación de documentos',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),

          StepIndicator(
            currentStep: _currentStep,
            totalSteps: 4,
            steps: const ["Subir", "Revisar", "Aprobar", "Archivar"],
            completedColor: Colors.orange,
            incompleteColor: Colors.grey[300]!,
            lineHeight: 8,
          ),

          const SizedBox(height: 40),

          Expanded(child: _buildStepContent()),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    final statusColors = [
      Colors.grey,
      Colors.blue,
      Colors.orange,
      Colors.green,
    ];
    final statusIcons = [
      Icons.pending,
      Icons.visibility,
      Icons.thumb_up,
      Icons.archive,
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              statusIcons[_currentStep],
              color: statusColors[_currentStep],
            ),
            title: Text(_getStepTitle()),
            subtitle: Text(_getStepSubtitle()),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.description, size: 60, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _currentStep < 3
                  ? () {
                      setState(() {
                        _currentStep++;
                      });
                    }
                  : null,
              child: Text(_getButtonText()),
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Documento Pendiente';
      case 1:
        return 'En Revisión';
      case 2:
        return 'Listo para Aprobación';
      case 3:
        return 'Documento Archivado';
      default:
        return '';
    }
  }

  String _getStepSubtitle() {
    switch (_currentStep) {
      case 0:
        return 'El documento está listo para ser revisado';
      case 1:
        return 'El documento está siendo analizado';
      case 2:
        return 'Esperando aprobación final';
      case 3:
        return 'Proceso completado exitosamente';
      default:
        return '';
    }
  }

  String _getButtonText() {
    switch (_currentStep) {
      case 0:
        return 'Comenzar Revisión';
      case 1:
        return 'Enviar a Aprobación';
      case 2:
        return 'Aprobar y Archivar';
      case 3:
        return 'Proceso Completado';
      default:
        return '';
    }
  }
}
