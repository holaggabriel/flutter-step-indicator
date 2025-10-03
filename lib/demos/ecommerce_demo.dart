// Demo 1: Proceso de E-commerce
import 'package:flutter/material.dart';
import 'package:flutter_step_indicator/widgets/step_indicator.dart';

class ECommerceDemo extends StatefulWidget {
  const ECommerceDemo({super.key});

  @override
  State<ECommerceDemo> createState() => _ECommerceDemoState();
}

class _ECommerceDemoState extends State<ECommerceDemo> {
  int _currentStep = 2; // Cambié a 2 para mostrar directamente el paso de pago
  int _selectedPaymentMethod = 0; // Por defecto Tarjeta de Crédito

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Proceso de Compra Online',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Simulación de un flujo de compra típico en e-commerce',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // Step Indicator
            StepIndicator(
              currentStep: _currentStep,
              totalSteps: 4,
              steps: const ["Carrito", "Envío", "Pago", "Confirmación"],
              completedColor: Colors.green,
              incompleteColor: Colors.grey,
              lineHeight: 6,
            ),

            const SizedBox(height: 40),

            // Contenido contextual con Scroll
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getStepTitle(_currentStep),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getStepDescription(_currentStep),
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 20),

                    // Contenido scrollable
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Producto simulado / Formulario según paso
                            if (_currentStep == 0) _buildProductCard(),
                            if (_currentStep == 1) _buildShippingForm(),
                            if (_currentStep == 2) _buildPaymentForm(),
                            if (_currentStep == 3) _buildConfirmation(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Controles de navegación
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
                  onPressed: _currentStep < 3
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
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Revisa tu Carrito';
      case 1:
        return 'Información de Envío';
      case 2:
        return 'Método de Pago';
      case 3:
        return '¡Pedido Confirmado!';
      default:
        return '';
    }
  }

  String _getStepDescription(int step) {
    switch (step) {
      case 0:
        return 'Revisa los productos en tu carrito antes de proceder al pago.';
      case 1:
        return 'Ingresa la dirección donde deseas recibir tu pedido.';
      case 2:
        return 'Selecciona tu método de pago preferido.';
      case 3:
        return 'Tu pedido ha sido procesado exitosamente.';
      default:
        return '';
    }
  }

  Widget _buildProductCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.smartphone, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smartphone XYZ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$599.99',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Cantidad: 1', style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShippingForm() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Dirección',
            prefixIcon: Icon(Icons.home),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Ciudad',
            prefixIcon: Icon(Icons.location_city),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Código Postal',
            prefixIcon: Icon(Icons.markunread_mailbox),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'País',
            prefixIcon: Icon(Icons.public),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentForm() {
    return Column(
      children: [
        // Método 1: Tarjeta de Crédito
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 0;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _selectedPaymentMethod == 0
                  ? Colors.green[50]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedPaymentMethod == 0
                    ? Colors.green
                    : Colors.grey[300]!,
                width: _selectedPaymentMethod == 0 ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.credit_card,
                  color: _selectedPaymentMethod == 0
                      ? Colors.green
                      : Colors.grey[700],
                  size: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tarjeta de Crédito',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedPaymentMethod == 0
                              ? Colors.green[800]
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Paga con tu tarjeta de crédito o débito',
                        style: TextStyle(
                          color: _selectedPaymentMethod == 0
                              ? Colors.green[600]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedPaymentMethod == 0)
                  Icon(Icons.check_circle, color: Colors.green, size: 24),
              ],
            ),
          ),
        ),

        // Método 2: PayPal
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 1;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _selectedPaymentMethod == 1
                  ? Colors.blue[50]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedPaymentMethod == 1
                    ? Colors.blue
                    : Colors.grey[300]!,
                width: _selectedPaymentMethod == 1 ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.paypal,
                  color: _selectedPaymentMethod == 1
                      ? Colors.blue
                      : Colors.grey[700],
                  size: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PayPal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedPaymentMethod == 1
                              ? Colors.blue[800]
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Paga de forma segura con tu cuenta PayPal',
                        style: TextStyle(
                          color: _selectedPaymentMethod == 1
                              ? Colors.blue[600]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedPaymentMethod == 1)
                  Icon(Icons.check_circle, color: Colors.blue, size: 24),
              ],
            ),
          ),
        ),

        // Método 3: Transferencia Bancaria
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 2;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _selectedPaymentMethod == 2
                  ? Colors.orange[50]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedPaymentMethod == 2
                    ? Colors.orange
                    : Colors.grey[300]!,
                width: _selectedPaymentMethod == 2 ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance,
                  color: _selectedPaymentMethod == 2
                      ? Colors.orange
                      : Colors.grey[700],
                  size: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transferencia Bancaria',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedPaymentMethod == 2
                              ? Colors.orange[800]
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Realiza una transferencia desde tu banco',
                        style: TextStyle(
                          color: _selectedPaymentMethod == 2
                              ? Colors.orange[600]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedPaymentMethod == 2)
                  Icon(Icons.check_circle, color: Colors.orange, size: 24),
              ],
            ),
          ),
        ),

        // Método 4: Efectivo en Punto de Pago
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = 3;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _selectedPaymentMethod == 3
                  ? Colors.purple[50]
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _selectedPaymentMethod == 3
                    ? Colors.purple
                    : Colors.grey[300]!,
                width: _selectedPaymentMethod == 3 ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.money,
                  color: _selectedPaymentMethod == 3
                      ? Colors.purple
                      : Colors.grey[700],
                  size: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Efectivo en Punto de Pago',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedPaymentMethod == 3
                              ? Colors.purple[800]
                              : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Paga en efectivo en tiendas participantes',
                        style: TextStyle(
                          color: _selectedPaymentMethod == 3
                              ? Colors.purple[600]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedPaymentMethod == 3)
                  Icon(Icons.check_circle, color: Colors.purple, size: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmation() {
    return Column(
      children: [
        Icon(Icons.check_circle, color: Colors.green[400], size: 60),
        const SizedBox(height: 16),
        const Text(
          '¡Gracias por tu compra!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Tu pedido #12345 ha sido confirmado y será enviado pronto.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green),
          ),
          child: Column(
            children: [
              Text(
                'Método de pago seleccionado:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getSelectedPaymentMethodName(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getSelectedPaymentMethodName() {
    switch (_selectedPaymentMethod) {
      case 0:
        return 'Tarjeta de Crédito';
      case 1:
        return 'PayPal';
      case 2:
        return 'Transferencia Bancaria';
      case 3:
        return 'Efectivo en Punto de Pago';
      default:
        return 'Tarjeta de Crédito';
    }
  }
}
