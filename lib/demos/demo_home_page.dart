import 'package:flutter/material.dart';
import 'package:flutter_step_indicator/demos/document_process_demo.dart';
import 'package:flutter_step_indicator/demos/ecommerce_demo.dart';
import 'package:flutter_step_indicator/demos/onboarding_demo.dart';
import 'package:flutter_step_indicator/demos/travel_booking_demo.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int _selectedDemo = 0;

  final List<Widget> _demos = [
    const ECommerceDemo(),
    const OnboardingDemo(),
    const DocumentProcessDemo(),
    const TravelBookingDemo(),
  ];

  final List<String> _demoTitles = [
    'Proceso de Compra',
    'Registro de Usuario',
    'Proceso Documental',
    'Reserva de Viaje',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Indicator Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Selector de demos
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _demoTitles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 12.0,
                  ),
                  child: ChoiceChip(
                    label: Text(_demoTitles[index]),
                    selected: _selectedDemo == index,
                    onSelected: (selected) {
                      setState(() {
                        _selectedDemo = index;
                      });
                    },
                    selectedColor: Colors.blue[100],
                    labelStyle: TextStyle(
                      color: _selectedDemo == index
                          ? Colors.blue[800]
                          : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(child: _demos[_selectedDemo]),
        ],
      ),
    );
  }
}
