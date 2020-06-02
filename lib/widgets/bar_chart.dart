import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {

  final List<double> expenses;
  BarChart(this.expenses);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double price){
      if(price > mostExpensive)
        {
          mostExpensive = price;
        }
    });

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5,),
          Text('Weekly Spending', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){}),
              Text('This week', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.1),),
              IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){}),

            ],

          ),
          SizedBox(height: 3,),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Bar(
                  label: 'Su',
                  amountSpent: expenses[0],
                  mostExpensive: mostExpensive
              ),
              Bar(
                  label: 'Mo',
                  amountSpent: expenses[1],
                  mostExpensive: mostExpensive
              ),
              Bar(
                  label: 'Tu',
                  amountSpent: expenses[2],
                  mostExpensive: mostExpensive
              ),
              Bar(
                  label: 'We',
                  amountSpent: expenses[3],
                  mostExpensive: mostExpensive
              ),
              Bar(
                  label: 'Th',
                  amountSpent: expenses[4],
                  mostExpensive: mostExpensive
              ),
              Bar(
                  label: 'Fr',
                  amountSpent: expenses[5],
                  mostExpensive: mostExpensive
              ),
              Bar(
                  label: 'Sa',
                  amountSpent: expenses[6],
                  mostExpensive: mostExpensive
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {

  final String label;
  final double amountSpent;
  final double mostExpensive;
  final double _maxBarHeight = 150;

  Bar({this.label, this.amountSpent, this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent/mostExpensive * _maxBarHeight;
    return Column(
      children: <Widget>[
        Text('\$${amountSpent.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w600),),
        SizedBox(height: 6,),
        Container(
          height: barHeight,
          width: 18,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8)
          ),
        ),
        SizedBox(height: 6,),
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
      ],
    );
  }
}

