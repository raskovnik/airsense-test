part of 'data_cubit.dart';
// This file defines the available states for the homepage
sealed class DataState {}

final class DataInitial extends DataState {}

final class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final dynamic data;

  DataLoaded(this.data);
}

class DataError extends DataState {
  final String message;

  DataError(this.message);
}