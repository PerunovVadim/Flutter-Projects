abstract class MainScreenState {}

class MainScreenStateInput extends MainScreenState{}

class MainScreenStateCalculate extends MainScreenState{
  final double velocity;
  MainScreenStateCalculate({required this.velocity});
}