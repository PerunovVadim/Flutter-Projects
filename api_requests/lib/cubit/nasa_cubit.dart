
import 'package:api_requests/cubit/nasa_state.dart';
import 'package:api_requests/models/nasa.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_requests/requests/nasa_api_request.dart';

class NasaCubit extends Cubit<NasaState>{
  NasaCubit() : super(NasaLoadingState());

  Future<void> loadData() async{
    try{
      Map<String, dynamic> apiData = await getNasaData();
      Nasa nasaData = Nasa.fromJson(apiData);
      emit(NasaLoadedState(data: nasaData));
      return;
    }catch(e){
      emit(NasaErrorState());
      return;
    }
  }
}