import 'dart:io';

// Класс для представления ребра
class Edge {
  int first, second, weight;
  Edge(this.first, this.second, this.weight);
}

// Класс Union-Find (Disjoint Set Union)
class UnionFind {
  List<int> parent = [];
  List<int> rank = [];

  UnionFind(int size) {
    parent = List<int>.generate(size, (index) => index);
    rank = List<int>.filled(size, 0);
  }
   
  int find(int v) {
    if (v != parent[v]) {
      parent[v] = find(parent[v]);
    }
    return parent[v];
  }

  void union(int v1, int v2) {
    int root1 = find(v1);
    int root2 = find(v2);

    if (root1 != root2) {
      if (rank[root1] > rank[root2]) {
        parent[root2] = root1;
      } else if (rank[root1] < rank[root2]) {
        parent[root1] = root2;
      } else {
        parent[root2] = root1;
        rank[root1]++;
      }
    }
  }
}

// Алгоритм Краскала
List<Edge> kruskal(int vertexCount, List<Edge> edges) {
  List<Edge> mst = <Edge>[];
  UnionFind uf = UnionFind(vertexCount);

  // Сортируем рёбра по возрастанию веса
  edges.sort((a, b) => a.weight.compareTo(b.weight));

  for (Edge edge in edges) {
    if (uf.find(edge.first) != uf.find(edge.second)) {
      mst.add(edge);
      uf.union(edge.first, edge.second);
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

// Преобразование матрицы в список рёбер
List<Edge> convertMatrixToEdgeList(List<List<int>> matrix) {
  List<Edge> edges = [];

  for (int i = 0; i < matrix.length; i++) {
    for (int j = i + 1; j < matrix[i].length; j++) {
      if (matrix[i][j] != 0) {
        edges.add(Edge(i, j, matrix[i][j]));
      }
    }
  }
  return edges;
}

void main() async {
  List<List<int>> matrix = await readGraphFromFile('bin/file');
  List<Edge> edges = convertMatrixToEdgeList(matrix);

  int vertexCount = matrix.length;

  // Применение алгоритма Краскала
  List<Edge> mst = kruskal(vertexCount, edges);

  // Вывод результата
  print("\nМинимальное остовное дерево с помощью алгоритма Краскала:");
  int sum = 0;
  for (var edge in mst) {
    sum += edge.weight;
    print('Ребро: ${edge.first + 1} - ${edge.second + 1} Вес: ${edge.weight}');
  }
  print("Минимальная сумма: $sum");
}