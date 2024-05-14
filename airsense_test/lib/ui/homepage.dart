import 'package:airsense_test/blocs/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:d_chart/d_chart.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Test App')),
      ),

      body: RefreshIndicator( // pulling down refreshes the ui
        onRefresh: () async {
          BlocProvider.of<DataCubit>(context).fetchData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          // using a bloc builder to build different ui based on the current state
          child: BlocBuilder<DataCubit, DataState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                    const Center(child: CircularProgressIndicator()),
                    const Center(child: Text("Loading data for device 00000000000000bb"))
                  ],
                );
              } else if (state is DataLoaded) {
                final currentDate = DateTime.now();
                final dateTo = DateFormat('yyyy-MM-dd HH:mm:ss').format(currentDate);
                final dateFrom = DateFormat('yyyy-MM-dd HH:mm:ss').format(currentDate.subtract(const Duration(days: 7)));
                final temperatureGroupList = [
                  TimeGroup(id: '1', data: state.data)
                ];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Center(child: Text("Temperature Graph for $dateFrom - $dateTo")),
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: DChartLineT(groupList: temperatureGroupList,
                      )
                      ),
                    ],
                  ),
                );
              } else if (state is DataError) {
                return const Center(child: Text("Error loading data"));
              } else {
                return Container();
              }
            }
          ),
        ),
      )
    );
  }

}
