import 'dart:io';
import 'package:collection/collection.dart';

// Структура для рёбер графа
class Edge {
  int vertex;
  int weight;
  Edge(this.vertex, this.weight);
}

// Алгоритм Прима
List<Edge> prims(int startVertex, List<List<Edge>> list, List<bool> used) {
  List<Edge> mst = <Edge>[];
  PriorityQueue<Edge> pq =
      PriorityQueue<Edge>((a, b) => a.weight.compareTo(b.weight));

  void addEdges(int vertex) {
    used[vertex] = true;
    for (var edge in list[vertex]) {
      if (!used[edge.vertex]) {
        pq.add(edge);
      }
    }
  }

  addEdges(startVertex);

  while (mst.length < list.length - 1 && pq.isNotEmpty) {
    Edge edge = pq.removeFirst();
    if (!used[edge.vertex]) {
      mst.add(edge);
      addEdges(edge.vertex);
    }
  }

  return mst;
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
  List<List<Edge>> list = convertMatrixToAdjacencyList(matrix);
  List<bool> used = List<bool>.filled(list.length, false);

  int startVertex = 1;

  List<Edge> mst = prims(startVertex - 1, list, used);

  print("\nМинимальное остовное дерево из вершины $startVertex с помощью алгоритма Прима");
  int sum = 0;
  for (var edge in mst) {
    sum += edge.weight;
    print('Вершина: ${edge.vertex + 1}, Вес: ${edge.weight}');
  }
  print("Минимальная сумма : $sum");
}
