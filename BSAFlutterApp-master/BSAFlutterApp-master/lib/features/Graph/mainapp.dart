import 'package:financial_analyzer/features/Graph/linechart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LineChartPage(),
    );
  }
}

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Debt-to-Income Ratio',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rating: Excellent | Performance: Very High |\nRisk Level: Minimal',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.6,
                child: SizedBox(
                  height: 400,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showTicks: false,
                        showLabels: true,
                        interval: 20,
                        showFirstLabel: true,  // Ensures "0" is shown
                        showLastLabel: true,   // Ensures "100" is shown
                        startAngle: 180,
                        endAngle: 0,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.2,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        ranges: <GaugeRange>[
                          GaugeRange(
                            startValue: 0,
                            endValue: 20,
                            color: Colors.green[800],
                            startWidth: 35,
                            endWidth: 35,
                          ),
                          GaugeRange(
                            startValue: 20,
                            endValue: 40,
                            color: Colors.green,
                            startWidth: 35,
                            endWidth: 35,
                          ),
                          GaugeRange(
                            startValue: 40,
                            endValue: 60,
                            color: Colors.yellow,
                            startWidth: 35,
                            endWidth: 35,
                          ),
                          GaugeRange(
                            startValue: 60,
                            endValue: 80,
                            color: Colors.orange,
                            startWidth: 35,
                            endWidth: 35,
                          ),
                          GaugeRange(
                            startValue: 80,
                            endValue: 100,
                            color: Colors.red,
                            startWidth: 35,
                            endWidth: 35,
                          ),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: 20),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: const [
                LegendItem('Excellent (0-20%)', Colors.green),
                LegendItem('Great (20-40%)', Color(0xFF66BB6A)),
                LegendItem('Good (40-60%)', Colors.yellow),
                LegendItem('Fair (60-80%)', Colors.orange),
                LegendItem('Poor (80-100%)', Colors.red),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const LegendItem(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}