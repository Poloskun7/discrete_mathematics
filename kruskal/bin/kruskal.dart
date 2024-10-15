import 'dart:io';
import 'dart:convert';

// Класс для представления ребра
class Edge {
  int first, second, weight;
  Edge(this.first, this.second, this.weight);
}



  // Алгоритм Краскала
  List<Edge> kruskal(int startVertex, List<List<Edge>> list) {
    List<Edge> mst = <Edge>[];

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

  int startVertex = 0;

  List<Edge> mst = kruskal(startVertex, list);

  print("\nМинимальное остовное дерево из вершины $startVertex с помощью алгоритма Краскала");
  int sum = 0;
  for (var edge in mst) {
    sum += edge.weight;
    print('Ребро: ${edge.first + 1} - ${edge.second + 1} Вес: ${edge.weight}');
  }
  print("Минимальная сумма : $sum");
}