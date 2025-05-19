import "package:api_requests/cubit/nasa_cubit.dart";
import "package:api_requests/cubit/nasa_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Перунов Вадим Дмитриевич ИВТ-22')),
      body: _build(),
    );
  }

  Widget _build(){
    return BlocBuilder<NasaCubit, NasaState>(
            builder: (context, state) {
              if (state is NasaLoadingState) {
                BlocProvider.of<NasaCubit>(context).loadData();
                return const Center(child: CircularProgressIndicator());
              }
              if (state is NasaLoadedState) {
                return ListView.builder(
                  itemCount: state.data.photos!.length,
                  itemBuilder: (context, index) {
                    print(state.data.photos![index].imgSrc!);
                   return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Image.network(state.data.photos![index].imgSrc!),
                      );// Container
                    
                  },
                ); // ListView.builder
              }

              if (state is NasaErrorState) {
                return const Center(child: Text("Произошла ошибка"));
              }
              return const Center(child: Text("Неизвестное состояние"));
            }
  );
  }

  
  }

