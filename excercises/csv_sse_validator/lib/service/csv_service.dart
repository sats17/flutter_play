import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import '../models/csv_row.dart';

class CsvService {
  Future<Map<String, dynamic>?> pickAndParseCSV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );

    if (result == null) return null;

    Uint8List? fileBytes = result.files.single.bytes;
    String csvString = String.fromCharCodes(fileBytes!);

    List<List<dynamic>> csvData =
        const CsvToListConverter().convert(csvString);

    int count = 0;
    List<CsvRow> rows = csvData.skip(1).map((row) {
      return CsvRow(id: count++, data: row, isLoading: true);
    }).toList();

    return {
      "fileName": result.files.single.name,
      "header": csvData[0],
      "rows": rows,
    };
  }
}