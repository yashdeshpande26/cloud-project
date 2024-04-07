import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const EMICalculator());
}

class EMICalculator extends StatelessWidget {
  const EMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FinanceEz',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 11, 11),
            ),
          ),
          centerTitle: true,
        ),
        body: const EMICalculatorWidget(),
      ),
    );
  }
}

class EMICalculatorWidget extends StatefulWidget {
  const EMICalculatorWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EMICalculatorWidgetState createState() => _EMICalculatorWidgetState();
}

class _EMICalculatorWidgetState extends State<EMICalculatorWidget> {
  double loanAmount = 100000;
  double interestRate = 8;
  double loanTenure = 5;
  double totalInterest = 0;
  double totalPayment = 0;

  void calculateEMI() {
    double principal = loanAmount;
    double monthlyInterestRate = interestRate / 1200;
    int totalPayments = (loanTenure * 12).toInt();

    double emi = (principal * monthlyInterestRate) /
        (1 - pow(1 + monthlyInterestRate, -totalPayments.toDouble()));

    totalInterest = (emi * totalPayments) - principal;
    totalPayment = principal + totalInterest;
  }

  @override
  Widget build(BuildContext context) {
    calculateEMI();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Amount of Loan (In rupees):',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  loanAmount = double.tryParse(value.replaceAll(',', '')) ?? 0;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
                suffixText: '1,000 - 1,000,000,000',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Interest Rate (In percentage):',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  interestRate = double.tryParse(value) ?? 0;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter rate',
                border: OutlineInputBorder(),
                suffixText: '1 - 20',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Loan Tenure (In years):',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  loanTenure = double.tryParse(value) ?? 0;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter tenure',
                border: OutlineInputBorder(),
                suffixText: '1 - 30',
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Total Interest Amount Payable:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    totalInterest.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Total Payment (Principal + Interest):',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    totalPayment.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
