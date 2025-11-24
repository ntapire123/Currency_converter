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

// Stateful widget for the currency converter screen
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
    double fromRate = _hardcodedRates[_fromCurrency]!;
    double toRate = _hardcodedRates[_toCurrency]!;
    setState(() {
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
                _inputAmount = double.tryParse(value) ?? 0.0;
                _convertCurrency();
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
                _fromCurrency = value!;
                _convertCurrency();
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
                _toCurrency = value!;
                _convertCurrency();
              },
            ),
            SizedBox(height: 30),

            // Simple result text
            Text(
              'Result: ${_result.toStringAsFixed(2)} $_toCurrency',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}