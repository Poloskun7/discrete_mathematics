import 'dart:io';
import 'dart:convert';

// Класс для представления ребра
class Edge {
  int source, destination, weight;
  Edge(this.source, this.destination, this.weight);
}

// Класс для представления графа с алгоритмом Краскала
class Graph {
  int vertices;
  List<Edge> edges = [];

  Graph(this.vertices);

  // Метод для добавления ребра в список рёбер
  void addEdge(int u, int v, int w) {
    edges.add(Edge(u, v, w));
  }

  // Метод для нахождения представителя множества (поиск сжатия путей)
  int find(List<int> parent, int i) {
    if (parent[i] == i) {
      return i;
    }
    return parent[i] = find(parent, parent[i]);
  }

  // Метод для объединения двух множеств (объединение по рангу)
  void union(List<int> parent, List<int> rank, int x, int y) {
    int xroot = find(parent, x);
    int yroot = find(parent, y);

    if (rank[xroot] < rank[yroot]) {
      parent[xroot] = yroot;
    } else if (rank[xroot] > rank[yroot]) {
      parent[yroot] = xroot;
    } else {
      parent[yroot] = xroot;
      rank[xroot]++;
    }
  }

  // Реализация алгоритма Краскала
  void kruskalMST() {
    List<Edge> result = [];  // Список для хранения результата (MST)

    // Сортировка рёбер по возрастанию весов
    edges.sort((a, b) => a.weight.compareTo(b.weight));

    // Инициализация родительских и ранговых массивов
    List<int> parent = List<int>.generate(vertices, (i) => i);
    List<int> rank = List<int>.filled(vertices, 0);

    int e = 0;  // Количество рёбер в MST
    int i = 0;  // Индекс для сортированных рёбер

    // Пока MST не содержит всех вершин
    while (e < vertices - 1) {
      Edge nextEdge = edges[i++];

      int x = find(parent, nextEdge.source);
      int y = find(parent, nextEdge.destination);

      // Если включение этого ребра не образует цикл
      if (x != y) {
        result.add(nextEdge);
        union(parent, rank, x, y);
        e++;
      }
    }

    // Вывод результата
    print("Рёбра в минимальном остовном дереве:");
    for (var edge in result) {
      print("${edge.source} -- ${edge.destination} == ${edge.weight}");
    }
  }
}

void main() async {
  // Чтение файла и создание матрицы смежности
  List<List<int>> adjMatrix = [];
  final file = File('bin/file');
  List<String> lines = await file.readAsLines(encoding: utf8);

  for (var line in lines) {
    adjMatrix.add(line.split(' ').map(int.parse).toList());
  }

  int vertices = adjMatrix.length;
  Graph graph = Graph(vertices);

  // Преобразование матрицы смежности в список рёбер
  for (int i = 0; i < vertices; i++) {
    for (int j = i + 1; j < vertices; j++) {
      if (adjMatrix[i][j] != 0) {
        graph.addEdge(i, j, adjMatrix[i][j]);
      }
    }
  }

  // Выполнение алгоритма Краскала
  graph.kruskalMST();
}