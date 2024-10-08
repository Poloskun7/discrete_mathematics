import 'dart:io';
import 'package:collection/collection.dart';

// Структура для рёбер графа
class Edge {
  int vertex;
  int weight;
  Edge(this.vertex, this.weight);
}

class Graph {
final List<List<Edge>> adjacencyList;

Graph(this.adjacencyList);

// Алгоритм Прима
  List<Edge> primsAlgorithm(int startVertex) {
    int numVertices = adjacencyList.length;
    List<bool> visited = List<bool>.filled(numVertices, false);
    List<Edge> mst = [];
    PriorityQueue<Edge> pq =
        PriorityQueue<Edge>((a, b) => a.weight.compareTo(b.weight));

    void addEdges(int vertex) {
      visited[vertex] = true;
      for (var edge in adjacencyList[vertex]) {
        if (!visited[edge.vertex]) {
          pq.add(edge);
        }
      }
    }

    addEdges(startVertex);

    while (mst.length < numVertices - 1 && pq.isNotEmpty) {
      Edge edge = pq.removeFirst();
      if (!visited[edge.vertex]) {
        mst.add(edge);
        addEdges(edge.vertex);
      }
    }

    return mst;
  }
}

// Функция чтения матрицы смежности из файла
  Future<List<List<int>>> readGraphFromFile(String filename) async {
    final file = File(filename);
    List<String> lines = await file.readAsLines();
    List<List<int>> matrix = [];

    for (var line in lines) {
      List<int> row = line.split(' ').map(int.parse).toList();
      matrix.add(row);
    }

    return matrix;
  }

// Преобразование матрицы в список смежности
  List<List<Edge>> convertMatrixToAdjacencyList(List<List<int>> matrix) {
    List<List<Edge>> adjacencyList = [];

    for (int i = 0; i < matrix.length; i++) {
      List<Edge> edges = [];
      for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] != 0) {
          edges.add(Edge(j, matrix[i][j]));
        }
      }
      adjacencyList.add(edges);
    }

    return adjacencyList;
  }

void main() async {
  List<List<int>> matrix = await readGraphFromFile('bin/file');
  List<List<Edge>> adjacencyList = convertMatrixToAdjacencyList(matrix);

  final graph = Graph(adjacencyList);
  List<Edge> mst = graph.primsAlgorithm(0);

  print("Минимальное остовное дерево:");
  for (var edge in mst) {
    print('Вершина: ${edge.vertex}, Вес: ${edge.weight}');
  }
}
