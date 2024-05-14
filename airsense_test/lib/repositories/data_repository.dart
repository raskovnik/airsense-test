import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:d_chart/d_chart.dart';

// responsible for making requests to the backend and obtaining required data
class DataRepository {
  Future<List<TimeData>> fetchData() async {
    final currentDate = DateTime.now();
    final dateTo = currentDate.toIso8601String();
    final dateFrom = currentDate.subtract(Duration(days: 7)).toIso8601String();

    const String url = "https://airsense.site/databydevid/";

    // create the body parameters
    final requestData = [
      {
        "dev_id": "00000000000000bb",
        "dateFrom": dateFrom,
        "dateTo": dateTo,
      }
    ];

    // make a post request to the api
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestData),
    );

    // if the response is okay, parse the data to obtain the required values
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<TimeData> temperatureDataList = [];
      try {
        temperatureDataList.addAll((jsonData as List<dynamic>).map((item) {
          return TimeData(
            measure: item['temp'],
            domain: DateTime.parse(item['datetime']),
          );
        }).toList());

        return temperatureDataList;
      } catch (e) {
        throw Exception("Could not parse json data: $e");
      }
    } else {

      // throw an error if the status code is not 200
      throw Exception("Could not fetch data, return code ${response.statusCode}");
    }
  }
}
