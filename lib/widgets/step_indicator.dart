import 'package:flutter/material.dart';

/// Widget StepIndicator - Indicador de Progreso por Pasos
/// 
/// Muestra un indicador visual de progreso a través de múltiples pasos
/// con círculos numerados, líneas conectores y textos descriptivos.
/// 
/// Ejemplo de uso:
/// ```dart
/// StepIndicator(
///   currentStep: 2,
///   totalSteps: 5,
///   steps: ['Paso 1', 'Paso 2', 'Paso 3', 'Paso 4', 'Paso 5'],
///   completedColor: Colors.green,
///   incompleteColor: Colors.grey,
/// )
/// ```
class StepIndicator extends StatelessWidget {
  /// Paso actual en el que se encuentra el usuario (índice base 0)
  /// Ejemplo: currentStep: 0 = primer paso, currentStep: 1 = segundo paso
  final int currentStep;

  /// Número total de pasos en el proceso
  final int totalSteps;

  /// Lista de textos descriptivos para cada paso
  /// Debe tener exactamente [totalSteps] elementos
  final List<String> steps;

  /// Color para los pasos completados (verde por defecto)
  final Color completedColor;

  /// Color para los pasos pendientes (gris por defecto)
  final Color incompleteColor;

  /// Altura de la línea conectora entre pasos
  final double lineHeight;

  /// Tamaño del diámetro de los círculos de los pasos
  final double stepSize;

  /// Margen superior entre el círculo y el texto descriptivo
  final double textTopMargin;

  /// Estilo personalizado para el texto descriptivo de cada paso
  /// Si es null, usa estilo por defecto: fontSize: 12, color del paso
  final TextStyle? textStyle;

  /// Estilo personalizado para los números dentro de los círculos
  /// Si es null, usa estilo por defecto: blanco, bold, 48% del stepSize
  final TextStyle? numberStyle;

  /// Mostrar u ocultar los números dentro de los círculos de los pasos
  final bool showStepNumber;

  /// Multiplicador para calcular el ancho de las líneas basado en la longitud del texto
  final double lineWidthMultiplier;

  /// Ancho opcional para el contenedor principal
  /// Si es null, ocupa todo el ancho disponible y permite scroll horizontal
  final double? width;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.steps,
    this.completedColor = const Color(0xFF25FF89),
    this.incompleteColor = const Color(0xFFAAAAAF),
    this.lineHeight = 10,
    this.stepSize = 25,
    this.textTopMargin = 60,
    this.textStyle,
    this.numberStyle,
    this.showStepNumber = true,
    this.lineWidthMultiplier = 9.2,
    this.width,
  }) : assert(
         steps.length == totalSteps,
         'La cantidad de textos debe ser igual al número total de pasos',
       );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Si no se proporciona width, ocupará el máximo disponible
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Alineación inicial para scroll horizontal
          children: List.generate(totalSteps, (index) {
            // Determina si el paso actual está completado (incluyendo el paso actual)
            final bool isCompleted = index <= currentStep;
            // Verifica si es el último paso para aplicar bordes redondeados
            final bool isLast = index == totalSteps - 1;

            // Color del paso basado en si está completado o no
            Color stepColor = isCompleted ? completedColor : incompleteColor;

            return Stack(
              alignment: Alignment.center,
              children: [
                // Línea de progreso que conecta los pasos
                Container(
                  height: lineHeight,
                  width: _calculateLineWidth(steps[index]),
                  decoration: ShapeDecoration(
                    color: isCompleted ? completedColor : incompleteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: index == 0
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            )
                          : isLast
                          ? const BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )
                          : BorderRadius.circular(0),
                    ),
                  ),
                ),

                // Círculo que representa el paso individual
                Container(
                  width: stepSize,
                  height: stepSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(stepSize / 2), // Círculo perfecto
                    color: stepColor,
                  ),
                  child: showStepNumber
                      ? Center(
                          child: Text(
                            (index + 1).toString(), // Número del paso (1-based para el usuario)
                            style:
                                numberStyle ??
                                TextStyle(
                                  fontSize: stepSize * 0.48, // Tamaño proporcional al círculo
                                  color: Colors.white, // Color blanco directo para mejor contraste
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      : null,
                ),

                // Texto descriptivo del paso
                Padding(
                  padding: EdgeInsets.only(top: textTopMargin),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // Ancho máximo basado en el ancho de línea + tamaño del paso
                      maxWidth: _calculateLineWidth(steps[index]) + stepSize,
                    ),
                    child: Text(
                      steps[index],
                      style:
                          textStyle ??
                          TextStyle(fontSize: 12, color: stepColor), // Color coherente con el estado
                      textAlign: TextAlign.center,
                      maxLines: 2, // Máximo 2 líneas para textos largos
                      overflow: TextOverflow.ellipsis, // Puntos suspensivos si el texto es muy largo
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  /// Calcula el ancho de la línea conectora basado en la longitud del texto
  /// Usa un multiplicador diferente para textos muy largos (>20 caracteres)
  double _calculateLineWidth(String text) {
    final double multiplier = text.length > 20 ? 6.5 : lineWidthMultiplier;
    return multiplier * text.length;
  }
}