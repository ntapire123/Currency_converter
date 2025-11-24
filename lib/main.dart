import 'package:flutter/material.dart';

// Entry point for the project
void main() {
  runApp(MyApp());
}

// Root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverterApp(),
    );
  }
}

class CurrencyConverterApp extends StatefulWidget {
  @override
  _CurrencyConverterAppState createState() => _CurrencyConverterAppState();
}

class _CurrencyConverterAppState extends State<CurrencyConverterApp> {
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _inputAmount = 0.0;
  double _result = 0.0;

  final List<String> _currencies = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'CAD',
    'AUD',
    'NEP',
  ];

  final Map<String, double> _hardcodedRates = {
    'USD': 1.0,
    'EUR': 0.93,
    'GBP': 0.79,
    'JPY': 149.50,
    'CAD': 1.36,
    'AUD': 1.53,
    'NEP': 92.48,
  };

  void _convertCurrency() {
    setState(() {
      double fromRate = _hardcodedRates[_fromCurrency]!;
      double toRate = _hardcodedRates[_toCurrency]!;
      _result = (_inputAmount / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter - Task 1'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Amount input
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  _inputAmount = double.tryParse(value) ?? 0.0;
                  _convertCurrency();
                });
              },
            ),
            SizedBox(height: 20),

            // From currency dropdown
            DropdownButtonFormField<String>(
              value: _fromCurrency,
              decoration: InputDecoration(
                labelText: 'From Currency',
                border: OutlineInputBorder(),
              ),
              items: _currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromCurrency = value!;
                  _convertCurrency();
                });
              },
            ),
            SizedBox(height: 20),

            // To currency dropdown
            DropdownButtonFormField<String>(
              value: _toCurrency,
              decoration: InputDecoration(
                labelText: 'To Currency',
                border: OutlineInputBorder(),
              ),
              items: _currencies.map((currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toCurrency = value!;
                  _convertCurrency();
                });
              },
            ),
            SizedBox(height: 30),

            // Styled converted amount container
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    'Converted Amount',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_result.toStringAsFixed(2)} $_toCurrency',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Exchange rate info container
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Exchange Rate: 1 $_fromCurrency = '
                '${(_hardcodedRates[_toCurrency]! / _hardcodedRates[_fromCurrency]!).toStringAsFixed(4)} '
                '$_toCurrency',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}