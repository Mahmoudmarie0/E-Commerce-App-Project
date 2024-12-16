import 'package:ecommerceproject/models/products-model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BestSellingChart extends StatelessWidget {
  final List<Product> products;

  BestSellingChart({required this.products});

  @override
  Widget build(BuildContext context) {
    // Sort products by sales in descending order
    final sortedProducts = products..sort((a, b) => b.sales.compareTo(a.sales));

    return Scaffold(
      appBar: AppBar(title: Text('Best Selling Products')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BarChart(
          BarChartData(
            barGroups: sortedProducts
                .map(
                  (product) => BarChartGroupData(
                x: sortedProducts.indexOf(product),
                barRods: [
                  BarChartRodData(
                    toY: product.sales.toDouble(),
                    color: Colors.blueAccent,
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
            )
                .toList(),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < sortedProducts.length) {
                      return Text(
                        sortedProducts[index].name,
                        style: TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    return Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true),
          ),
        ),
      ),
    );
  }
}
