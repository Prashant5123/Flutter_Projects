import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartPage extends StatelessWidget {
  const LineChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: SfCartesianChart(
                
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                enablePinching: true,
                ),
                title: const ChartTitle(text: 'Average Monthly Balance'),
                primaryXAxis: const CategoryAxis(
                  title: AxisTitle(text: 'Month'),
                  majorGridLines: MajorGridLines(width: 0), 
                ),
                primaryYAxis: const NumericAxis(
                  title: AxisTitle(text: 'Balance (in ₹)'),
                  majorGridLines: MajorGridLines(width: 0), 
  axisLine: AxisLine(width: 0), 
  
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries>[
                  LineSeries<MonthlyData, String>(
                    dataSource: _getChartData(),
                    xValueMapper: (MonthlyData data, _) => data.month,
                    yValueMapper: (MonthlyData data, _) => data.sales,
                    // markerSettings: const MarkerSettings(isVisible: true),
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  
                  ),
                ],
                legend: const Legend(isVisible: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<MonthlyData> _getChartData() {
    return [
      MonthlyData('Jan', 3000),
      MonthlyData('Feb', 4500),
      MonthlyData('Mar', 2800),
      MonthlyData('Apr', 5000),
      MonthlyData('May', 4000),
      MonthlyData('Jun', 5500),
      MonthlyData('Jul', 3500),
      MonthlyData('Aug', 600),
      MonthlyData('Sep', 4800),
      MonthlyData('Oct', 7000),
      MonthlyData('Nov', 6500),
      MonthlyData('Dec', 8000),
    ];
  }
}

class MonthlyData {
  final String month;
  final double sales;

  MonthlyData(this.month, this.sales);
}