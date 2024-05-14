import 'package:airsense_test/repositories/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_state.dart';

// responsible for state management in the homepage
class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial());

  Future<void> fetchData() async {
    emit(DataLoading());
    DataRepository dataRepository = DataRepository();
      try {
        final deviceData = await dataRepository.fetchData();
        emit(DataLoaded(deviceData));
      } catch (e) {
        emit(DataError(e.toString()));
      }
  }
}