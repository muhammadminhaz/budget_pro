import 'package:budgetpro/data/data.dart';
import 'package:budgetpro/models/expense_model.dart';
import 'package:budgetpro/screens/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:budgetpro/widgets/bar_chart.dart';
import 'package:budgetpro/models/category_model.dart';
import 'package:budgetpro/helpers/color_helper.dart';

class Home extends StatefulWidget {



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _buildCategory(Category category, double totalAmountSpent)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(category: category)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.deepPurple,
                  offset: Offset(0, 2),
                  blurRadius: 6
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(category.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Text('\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints){
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) / category.maxAmount;
                double barWidth = percent * maxBarWidth;
                if(barWidth < 0)
                  {
                    barWidth = 0;
                  }
                return Stack(
                  children: <Widget>[
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    Container(
                      height: 20,
                      width: barWidth,
                      decoration: BoxDecoration(
                          color: getColor(context, percent),
                          borderRadius: BorderRadius.circular(12)
                      ),
                    )
                  ],
                );
              },

            )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            forceElevated: true,
            leading: IconButton(icon: Icon(Icons.settings), iconSize: 30, onPressed: (){}),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Budget Pro'),
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.add), iconSize: 30, onPressed: (){})
            ],
          ),
          SliverList(
            // ignore: missing_return
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              if(index == 0) {
                return Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                          color: Colors.deepPurple,
                          offset: Offset(0, 2),
                          blurRadius: 6.0
                      )
                      ],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: BarChart(weeklySpending),
                );
              }
              else
                {
                  final Category category = categories[index - 1];
                  double totalAmountSpent = 0;
                  category.expenses.forEach((Expense expense){
                    totalAmountSpent += expense.cost;
                  });
                  return _buildCategory(category, totalAmountSpent);
                }
            },
              childCount: 1 + categories.length

            ),
          )
        ],
      ),
    );
  }
}
