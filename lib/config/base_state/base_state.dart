import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final T? data;
  const BaseState({this.isLoading = false, this.data, this.errorMessage});

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
