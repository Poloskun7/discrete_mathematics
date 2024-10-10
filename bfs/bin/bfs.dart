import 'dart:io';
import 'dart:collection';

enum Colors {
  black,
  white
}

  //Алгоритм BFS
  List<int> bfs(startVertex, List<List<int>> list, List<Colors> used, Queue<int> queue, List<int> result) {
    used[startVertex] = Colors.black; //Помечаем текущую вершину в черный цвет
    result.add(startVertex + 1);
    queue.add(startVertex); //Добавляем текущую вершину в очередь

    //Пока очередь не пуста
    while (queue.isNotEmpty) {
      final currentVertex = queue.removeFirst(); //Удаляем из очереди первую вершину

      //Перебираем смежные вершины белого цвета
      for (int neighbor = 0; neighbor < list[currentVertex].length; neighbor++) {
        if (list[currentVertex][neighbor] == 1 && used[neighbor] != Colors.black) {
          used[neighbor] = Colors.black; //Помечаем вершину в черный цвет
          result.add(neighbor + 1);
          queue.add(neighbor); //Добавляем вершину в очередь
        }
      }
    }
    return result;
  }

Future<List<List<int>>> readGraphFromFile(String filename) async {
  final file = File(filename);
  final lines = await file.readAsLines();
  final matrix = <List<int>>[];

  for (var line in lines) {
    final row = line.split(' ').map(int.parse).toList();
    matrix.add(row);
  }

  return matrix;
}

void main() async {
  final list = await readGraphFromFile('bin/file');

  final List<Colors> used = List.filled(list.length, Colors.white);
  final queue = Queue<int>();
  List<int> result = [];

  int startVertex = 3;

  print('\nBFS starting from vertex $startVertex:');
  print('\n${bfs(startVertex - 1, list, used, queue, result)}');
}
