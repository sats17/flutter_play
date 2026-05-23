import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:typed_data';

class FileUploadScreen extends StatefulWidget {

  const FileUploadScreen({super.key});


  @override
  State<StatefulWidget> createState() {
    return FileUploadState();
  }

}

class FileUploadState extends State<FileUploadScreen> {
   String? filePath;
   List<CsvRow> rows = [];
   List<List<dynamic>>? headerRow;

  Future<void> pickCSVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      String path = result.files.single.path!;

      Uint8List? fileBytes = result.files.single.bytes;
      String csvString = String.fromCharCodes(fileBytes!);

      List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

      setState(() {
        filePath = path;
      });

      rows = csvData.skip(1).map((row) {
        return CsvRow(
          data: row,
          isLoading: true, // initial loading state
        );
      }).toList();

      headerRow = [csvData[0]];

      for (int i = 0; i < rows.length; i++) {
        validateRow(i, rows[i]);
      }

    } else {
      print("User canceled file picking");
    }
  }

  Future<void> validateRow(int index, CsvRow row) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API call

    setState(() {
      row.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CSV Upload"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: pickCSVFile,
                child: const Text("Select CSV File")
              ),
              const SizedBox(height: 20),
              Text(
                filePath ?? "No file selected",
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 20),
              if(rows.isNotEmpty) 
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [
                            const DataColumn(label: Text("Status")),
                            ...headerRow![0].map((col) => DataColumn(label: Text(col.toString()))),
                          ],
                          rows: rows.asMap().entries.map((entry) {
                            int index = entry.key;
                            CsvRow row = entry.value;
                            return DataRow(
                              cells: [
                                DataCell(
                                  row.isLoading 
                                    ? const CircularProgressIndicator() 
                                    : const Icon(Icons.check, color: Colors.green)
                                ),
                                ...row.data.map((cell) => DataCell(Text(cell.toString()))),
                              ]
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  )
            ],
          )
        )
      );
  }
  


}

class CsvRow {
  List<dynamic> data;
  bool isLoading;

  CsvRow({
    required this.data,
    this.isLoading = true,
  });
}