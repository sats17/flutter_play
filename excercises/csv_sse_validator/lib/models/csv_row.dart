class CsvRow {
  int id;
  List<dynamic> data;
  bool isLoading;

  CsvRow({
    required this.id,
    required this.data,
    this.isLoading = true,
  });
}