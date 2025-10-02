import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> steps;
  final Color completedColor;
  final Color incompleteColor;
  final double lineHeight;
  final double stepSize;
  final double textTopMargin;
  final TextStyle? textStyle;
  final TextStyle? numberStyle;
  final bool showStepNumber;
  final double lineWidthMultiplier;
  final double? width; // Ancho opcional para el contenedor

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
    this.width, // Ancho opcional
  }) : assert(
         steps.length == totalSteps,
         'La cantidad de textos debe ser igual al número total de pasos',
       );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Si no se proporciona width, ocupará el máximo disponible
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Cambiado a start
          children: List.generate(totalSteps, (index) {
            final bool isCompleted = index <= currentStep;
            final bool isLast = index == totalSteps - 1;

            Color stepColor = isCompleted ? completedColor : incompleteColor;

            return Stack(
              alignment: Alignment.center,
              children: [
                // Línea de progreso
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

                // Paso (Círculo) de progreso
                Container(
                  width: stepSize,
                  height: stepSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(stepSize / 2),
                    color: stepColor,
                  ),
                  child: showStepNumber
                      ? Center(
                          child: Text(
                            (index + 1).toString(),
                            style:
                                numberStyle ??
                                TextStyle(
                                  fontSize: stepSize * 0.48,
                                  color: _getNumberColor(stepColor),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      : null,
                ),

                // Texto del paso
                Padding(
                  padding: EdgeInsets.only(top: textTopMargin),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: _calculateLineWidth(steps[index]) + stepSize,
                    ),
                    child: Text(
                      steps[index],
                      style:
                          textStyle ??
                          TextStyle(fontSize: 12, color: stepColor),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  double _calculateLineWidth(String text) {
    final double multiplier = text.length > 20 ? 6.5 : lineWidthMultiplier;
    return multiplier * text.length;
  }

  Color _getNumberColor(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.light ? Colors.black : Colors.white;
  }
}