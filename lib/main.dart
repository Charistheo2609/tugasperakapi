import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Info Geolocation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const GeoInfoScreen(),
    );
  }
}

class GeoInfoScreen extends StatefulWidget {
  const GeoInfoScreen({super.key});

  @override
  _GeoInfoScreenState createState() => _GeoInfoScreenState();
}

class _GeoInfoScreenState extends State<GeoInfoScreen> {
  String? city;
  String? region;
  String? country;
  String? ip;
  String? loc;
  String? org;
  String? postal;
  String? timezone;

  @override
  void initState() {
    super.initState();
    fetchGeoInfo();
  }

  Future<void> fetchGeoInfo() async {
    final url = Uri.parse('https://ipinfo.io/161.185.160.93/geo');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        ip = data['ip'];
        city = data['city'];
        region = data['region'];
        country = data['country'];
        loc = data['loc'];
        org = data['org'];
        postal = data['postal'];
        timezone = data['timezone'];
      });
    } else {
      print('Failed to load geolocation data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.green],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'IPinfo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 332,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow('IP Address', ip ?? 'Loading...'),
                    buildInfoRow('City', city ?? 'Loading...'),
                    buildInfoRow('Region', region ?? 'Loading...'),
                    buildInfoRow('Country', country ?? 'Loading...'),
                    buildInfoRow('Location', loc ?? 'Loading...'),
                    buildInfoRow('Origin', org ?? 'Loading...'),
                    buildInfoRow('Postal', postal ?? 'Loading...'),
                    buildInfoRow('Timezone', timezone ?? 'Loading...'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label : ',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}