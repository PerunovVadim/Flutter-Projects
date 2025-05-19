import 'package:api_requests/models/nasa.dart';

abstract class NasaState {}

class NasaLoadingState extends NasaState{}

class NasaLoadedState extends NasaState{
  Nasa data;
  NasaLoadedState({required this.data});
}

class NasaErrorState extends NasaState{}