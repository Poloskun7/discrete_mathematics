import 'dart:io';

class Graph {
  List<List<int>> matrix;

  Graph(this.matrix);

  Set<int> dfs(int start) {
    Set<int> visited = {};
    _dfsRecursive(start, visited);
    return visited;
  }

  void _dfsRecursive(int vertex, Set<int> visited) {
    visited.add(vertex);

    for (int neighbor = 0; neighbor < matrix[vertex].length; neighbor++) {
      if (matrix[vertex][neighbor] == 1 && !visited.contains(neighbor)) {
        _dfsRecursive(neighbor, visited);
      }
    }
  }
}

Future<List<List<int>>> readGraphFromFile(String filename) async {
  var file = File(filename);
  List<List<int>> matrix = [];

  // Чтение файла построчно
  var lines = await file.readAsLines();
  for (var line in lines) {
    var row = line.split(' ').map(int.parse).toList();
    matrix.add(row);
  }
  return matrix;
}

Future<void> main() async {
  final matrix = await readGraphFromFile('bin/file');
  final graph = Graph(matrix);

  print("DFS starting from vertex 0:");
  print('\n${graph.dfs(0)}');
}
