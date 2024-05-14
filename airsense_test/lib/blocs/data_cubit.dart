import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:d_chart/d_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());

  Future<void> fetchData() async {
    emit(DataLoading());

    try {
      final currentDate = DateTime.now();
      final dateTo = currentDate.toIso8601String();
      final dateFrom =
          currentDate.subtract(Duration(days: 7)).toIso8601String();

      const String url = "https://airsense.site/databydevid/";
      final requestData = [
        {
          "dev_id": "00000000000000bb",
          "dateFrom": dateFrom,
          "dateTo": dateTo,
        }
      ];

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestData),
      );

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
        } catch (e) {
          print('An error occurred while converting JSON data: $e');
        }

        emit(DataLoaded(temperatureDataList));
      } else {
        throw Exception("Failed to load data");
      }
    } catch (error) {
      emit(DataError(error.toString()));
    }
  }
}
