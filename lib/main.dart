import 'package:counter_app_cubit/cubit/counter_cubit_state.dart';
import 'package:counter_app_cubit/cubit/style_sheet.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterCubit())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(title: 'Counter App'),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<CounterCubit, CounterCubitState>(
        builder: (context,state){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              (state is CounterValueUpdated) ? Text(state.counter.toString(),
                style: StyleSheet.titleTextStyle,) : Text("0", style: StyleSheet.titleTextStyle),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: FloatingActionButton(
                      onPressed: (){
                        context.read<CounterCubit>().counterIncrease();
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: FloatingActionButton(
                      onPressed: (){
                        context.read<CounterCubit>().counterDecrease();
                      },
                      child: const Icon(Icons.remove),
                    ),
                  ),
                ],
              )


            ],
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
