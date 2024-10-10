import 'dart:io';

enum Colors {
  white, 
  gray,
  black
}

//Алгоритм DFS
List<int> dfs(int vertex, List<List<int>> list, List<Colors> used, List<int> result) {
  used[vertex] = Colors.gray; //Помечаем текущую вершину в серый цвет
  result.add(vertex + 1); 
  
  //Перебираем все смежные вершины белого цвета
  for (int neighbor = 0; neighbor < list.length; neighbor++) { 
    if (list[vertex][neighbor] == 1 && used[neighbor] == Colors.white) {
      dfs(neighbor, list, used, result); //Вызываем DFS
    }
  }
  
  used[vertex] = Colors.black; //Помечаем текущую вершину в черный цвет 
  return result;
}

Future<List<List<int>>> readGraphFromFile(String filename) async {
  var file = File(filename);
  List<List<int>> matrix = [];

  var lines = await file.readAsLines();
  for (var line in lines) {
    var row = line.split(' ').map(int.parse).toList();
    matrix.add(row);
  }
  return matrix;
}

Future<void> main() async {
  final list = await readGraphFromFile('bin/file');
  List<Colors> used = List.filled(list.length, Colors.white);
  List<int> result = [];
  
  final startVertex = 2;

  print('\nDFS starting from vertex $startVertex:');
  print('\n${dfs(startVertex - 1, list, used, result)}');
}
