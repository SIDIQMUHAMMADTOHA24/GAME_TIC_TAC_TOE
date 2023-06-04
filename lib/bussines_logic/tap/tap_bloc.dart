import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'tap_event.dart';
part 'tap_state.dart';

class TapBloc extends Bloc<TapEvent, Map<String, dynamic>> {
  TapBloc()
      : super({
          'listData': ['', '', '', '', '', '', '', '', ''],
          'isSelected': false,
          'isWin': false,
          'isSerries': false,
          'counterX': 0,
          'counterO': 0
        }) {
    on<UpdateTap>((event, emit) {
      List<String> listData = state['listData'];
      int index = event.index;
      bool isSelected = state['isSelected'];
      //! ini handle jika index yang belum diklik akan terisi dengan X dan O, dan ketika sudah terisi maka tidak akan terisi/terganti, sebagai contoh ketika nilai sudah X maka X tidak akan berubah menjadi O begitu juga sebaliknya
      if (state['isSelected'] && state['listData'][index] == '') {
        listData[index] = 'O';
      } else if (!state['isSelected'] && state['listData'][index] == '') {
        listData[index] = 'X';
      }

      //! ini untuk menghandle jika index di klik maka akan menampilkan nilai X lalu ketika index lain di klik maka akan menampilkan nilai O, ini perlu di handle karena ketika mengklik nilai sebelumnya X maka nilai setelahnya akan bernilai X begitupun juga O
      if (listData[index].contains('X')) {
        isSelected = true;
      }
      if (listData[index].contains('O')) {
        isSelected = false;
      }
      Map<String, dynamic> updatedTapIndex = {
        'listData': listData,
        'isSelected': isSelected,
        'isWin': state['isWin'],
        'isSerries': state['isSerries'],
        'counterX': state['counterX'],
        'counterO': state['counterO']
      };
      emit(updatedTapIndex);
    });

    //
    on<OnLogic>((event, emit) {
      List<String> listData = state['listData'];
      int valueX = listData.where((element) => element == 'X').length;
      int valueO = listData.where((element) => element == 'O').length;
      String comparison = valueX > valueO ? 'X' : 'O';
      BuildContext context = event.context;
      bool isWin = state['isWin'];
      bool isSerries = state['isSerries'];

      List<List<int>> winningCombinations = [
        // Rows
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        // Columns
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        // Crosses
        [0, 4, 8], [2, 4, 6]
      ];

      for (List<int> combination in winningCombinations) {
        int a = combination[0];
        int b = combination[1];
        int c = combination[2];

        if (listData[a] == listData[b] &&
            listData[a] == listData[c] &&
            listData[a] != '') {
          isWin = true;
          //! untuk menambahkan nilai X jika manang
          if (comparison.contains('X') && isWin) {
            emit({
              ...state,
              'counterX': state['counterX'] + 1,
            });
          }
          //! untuk menambahkan nilai O jika manang
          if (comparison.contains('O') && isWin) {
            emit({
              ...state,
              'counterO': state['counterO'] + 1,
            });
          }

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                comparison,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color:
                        comparison.contains('X') ? Colors.yellow : Colors.blue),
              ),
              content: const Text(
                'Win',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Replay',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ))
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
          //! untuk mengubah nilai semua list menjadi list[''.sebanyak 9]
          if (isWin) {
            for (var i = 0; i < listData.length; i++) {
              listData[i] = '';
            }
          }
          isWin = false;
        }
      }

      //! jika semua list sudah terisi namun tidak ada yang menang
      if (listData.every((element) => element.isNotEmpty)) {
        isSerries = true;
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              'X : O',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            content: const Text(
              'Serries',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Replay',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ))
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
        //! untuk mengubah nilai semua list menjadi list[''.sebanyak 9]
        if (isSerries) {
          for (var i = 0; i < listData.length; i++) {
            listData[i] = '';
          }
        }
        isSerries = false;
      }
    });
  }
}
