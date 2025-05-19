abstract class HistoryScreenState {}

class HistoryScreenStateList extends HistoryScreenState{
  List<Map<String,dynamic>>? data;

  HistoryScreenStateList({required this.data});
}
