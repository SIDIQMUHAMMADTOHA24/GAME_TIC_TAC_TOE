import 'package:flutter/material.dart';

import '../../bussines_logic/export.dart';
import '../../bussines_logic/tap/tap_bloc.dart';

class MainPages extends StatelessWidget {
  const MainPages({super.key});

  @override
  Widget build(BuildContext context) {
    TapBloc tapBloc = context.read<TapBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Tou'),
        centerTitle: true,
      ),
      body: BlocBuilder<TapBloc, Map<String, dynamic>>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'X : ${state['counterX']}',
                    style: TextStyle(
                        fontSize: 65,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  Text(
                    'O : ${state['counterO']}',
                    style: TextStyle(
                        fontSize: 65,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: state['listData'].length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    String font = state['listData'][index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          tapBloc.add(UpdateTap(index: index));
                          tapBloc.add(OnLogic(context: context));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            font,
                            style: TextStyle(
                                color: font.contains('X')
                                    ? Colors.yellow
                                    : Colors.blue,
                                fontSize: 65,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
