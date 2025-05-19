
import 'package:data_store/cubit/history_screen_state.dart';
import 'package:data_store/database/database_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreenCubit extends Cubit<HistoryScreenStateList> {
  HistoryScreenCubit() : super(HistoryScreenStateList(data:null));

  void getHistory() async{
    
    var history = DatabaseProvider.db.getHistory();
    emit(HistoryScreenStateList(data: await history));

    
  }
  
}
