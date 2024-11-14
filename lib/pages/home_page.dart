import 'package:flutter/material.dart';
import 'package:pir_chart/widgets/custom_badge.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int touchedIndex =0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _appBar(),
      body: _buildUI(),
    );
  }
  PreferredSizeWidget _appBar(){
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Pie Chart",
      ),
    );
  }
  Widget _buildUI(){
    return Center(
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse){
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse==null ||
                    pieTouchResponse.touchedSection==null){
                  touchedIndex=-1;
                  return;
                }
                touchedIndex=
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          sections: piechartSection(),
          sectionsSpace: 2,
          centerSpaceRadius: 0,
        ),
      ),
    );
  }
  List<PieChartSectionData> piechartSection() {
    List<Color> sectionColors=[
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.green,
    ];
    List<IconData> sectionIcons = [
      Icons.business,
      Icons.shopping_bag,
      Icons.local_grocery_store,
      Icons.house,
    ];

    return List.generate(
      4,
        (i) {
          double value = (i+1)*10;
          final isTouched = i ==touchedIndex;
          final radius= isTouched ? 150.0:100.0;
          final fontSize = isTouched ? 24.0:16.0;
          final widgetSize= isTouched ? 60.0:40.0;
          return PieChartSectionData(
            color:  sectionColors[i],
            value: value,
            title: '$value%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(
                  0xffffffff,
              ),
            ),
            badgeWidget: CustomBadge(
                icon: sectionIcons[i],
                size: widgetSize,
                borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: 0.98,
          );
        },
    );
  }

}