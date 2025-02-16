import 'package:flutter/material.dart';

void main() {
  runApp(VolumeConverterApp());
}

class VolumeConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Volume Converter',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: VolumeConverterScreen(),
    );
  }
}

class VolumeConverterScreen extends StatefulWidget {
  @override
  _VolumeConverterScreenState createState() => _VolumeConverterScreenState();
}

class _VolumeConverterScreenState extends State<VolumeConverterScreen> {
  final TextEditingController _volumeController = TextEditingController();
  double _convertedVolume = 0.0;

  // Volume conversion rates (relative to Liters)
  final Map<String, double> volumeUnits = {
    'Liters': 1.0,
    'Milliliters': 1000.0,
    'Gallons': 0.264172,
    'Cubic Meters': 0.001,
    'Cubic Feet': 0.0353147,
  };

  String _fromUnit = 'Liters';
  String _toUnit = 'Milliliters';

  void _convertVolume() {
    double volume = double.tryParse(_volumeController.text) ?? 0.0;
    double fromRate = volumeUnits[_fromUnit]!;
    double toRate = volumeUnits[_toUnit]!;

    setState(() {
      _convertedVolume = (volume / fromRate) * toRate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text("Volume Converter"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _volumeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Volume",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Dropdowns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton<String>(
                          value: _fromUnit,
                          onChanged: (value) {
                            setState(() {
                              _fromUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: volumeUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),

                        Icon(Icons.arrow_forward, color: Colors.deepPurple),

                        DropdownButton<String>(
                          value: _toUnit,
                          onChanged: (value) {
                            setState(() {
                              _toUnit = value!;
                            });
                          },
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          items: volumeUnits.keys.map((unit) {
                            return DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: _convertVolume,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Convert",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

            SizedBox(height: 20),

            // Converted Volume Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              color: Colors.deepPurple,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Converted Volume: ${_convertedVolume.toStringAsFixed(4)} $_toUnit",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
