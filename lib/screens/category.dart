import 'package:budgetpro/helpers/color_helper.dart';
import 'package:budgetpro/models/expense_model.dart';
import 'package:budgetpro/widgets/radial_painter.dart';
import 'package:flutter/material.dart';
import 'package:budgetpro/models/category_model.dart';

class CategoryScreen extends StatefulWidget {

  final Category category;
  CategoryScreen({this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  _buildExpenses(){
    List<Widget> expenseList = [];
    widget.category.expenses.forEach((Expense expense){
      expenseList.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple,
              offset: Offset(0, 2),
              blurRadius: 6
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                expense.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                '-\$${expense.cost.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        ),
      ));
    });
    return Column(children: expenseList);
  }

  @override
  Widget build(BuildContext context) {

    double totalAmountSpent = 0;
    widget.category.expenses.forEach((Expense expense){
      totalAmountSpent += expense.cost;
    });

    final double amountLeft = widget.category.maxAmount - totalAmountSpent;
    final double percent = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), iconSize: 30, onPressed: (){})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple,
                    offset: Offset(0, 2),
                    blurRadius: 6
                  )
                ]
              ),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15
                ),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            _buildExpenses()
          ],
        ),
      ),
    );
  }
}
