import 'dart:io';
import 'dart:collection';

class Graph {
  final List<List<int>> matrix;

  Graph(this.matrix);

  List<int> bfs(int startVertex) {
    final List<int> visited = [];
    final queue = Queue<int>();

    visited.add(startVertex);
    queue.add(startVertex);

    while (queue.isNotEmpty) {
      final currentVertex = queue.removeFirst();

      for (int neighbor = 0; neighbor < matrix[currentVertex].length; neighbor++) {
        if (matrix[currentVertex][neighbor] == 1 && !visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
    return visited;
  }
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
  final matrix = await readGraphFromFile('bin/file');
  final graph = Graph(matrix);

  print('BFS starting from vertex 0:');
  print('\n${graph.bfs(0)}');
}
