part of 'data_cubit.dart';
// This file defines the available states for the homepage
sealed class DataState {}

// initial state when the page is loaded
final class DataInitial extends DataState {}

// loading state as the required data is being fetched
final class DataLoading extends DataState {}

// success state after data was loaded successfully
class DataLoaded extends DataState {
  final dynamic data;

  DataLoaded(this.data);
}

// failed state after an error occurred
class DataError extends DataState {
  final String message;

  DataError(this.message);
}