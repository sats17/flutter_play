import 'dart:convert';

import '../service/csv_service.dart';
import 'package:flutter/material.dart';
import '../models/csv_row.dart';
import 'package:http/http.dart' as http;

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  State<FileUploadScreen> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUploadScreen> {
  final CsvService _csvService = CsvService();

  String? fileName;
  List<CsvRow> rows = [];
  List<dynamic>? headerRow;

  Future<void> pickCSVFile() async {
    final result = await _csvService.pickAndParseCSV();

    if (result == null) return;

    setState(() {
      fileName = result["fileName"];
      headerRow = result["header"];
      rows = result["rows"];
    });

    await validateAndUpdateRow();
    
  }

  Future<void> validateAndUpdateRow() async {

    List<Map<String, dynamic>> payload = rows.map((row) {
      Map<String, dynamic> rowMap = {
        'id': row.id
      };
      
      // Pack the rest of the dynamic data into the payload body
      for (int i = 1; i < row.data.length; i++) {
        rowMap[headerRow![i].toString()] = row.data[i];
      }
      return rowMap;
    }).toList();

    setState(() {
      for (var row in rows) {
        row.isLoading = true;
      }
    });

    final url = Uri.parse("http://127.0.0.1:8080/api/validate-customers");
    final request = http.Request("POST", url);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'text/event-stream';
    request.body = jsonEncode(payload);

    try {
      final client = http.Client();
      final response = await client.send(request);

      // 4. Read incoming Server-Sent Events line-by-line asynchronously
      response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen((String line) {
        
        // SSE lines carrying data are always prefixed with "data:"
        if (line.startsWith("data:")) {
          final jsonString = line.substring(5).trim();
          
          if (jsonString.isNotEmpty) {
            final Map<String, dynamic> eventData = jsonDecode(jsonString);
            final int validatedId = eventData['id'];
            final bool isValidated = eventData['validated'] ?? false;

            if (isValidated) {
              // 5. Match the server update to the corresponding UI row and stop loading
              setState(() {
                final matchingRow = rows.firstWhere((row) => row.id == validatedId);
                matchingRow.isLoading = false;
              });
            }
          }
        }
      }, onDone: () {
        client.close();
        debugPrint("Validation streaming complete.");
      }, onError: (error) {
        client.close();
        debugPrint("Error during stream processing: $error");
      });

    } catch (e) {
      debugPrint("Network failure connecting to API: $e");
    }


    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CSV Upload")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickCSVFile,
              child: const Text("Select CSV File"),
            ),
            const SizedBox(height: 20),

            Text(fileName ?? "No file selected"),

            const SizedBox(height: 20),

            if (rows.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        const DataColumn(label: Text("Status")),
                        ...headerRow!.map(
                          (col) => DataColumn(
                            label: Text(col.toString()),
                          ),
                        ),
                      ],
                      rows: rows.map((row) {
                        return DataRow(
                          cells: [
                            DataCell(
                              row.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Icon(Icons.check,
                                      color: Colors.green),
                            ),
                            ...row.data.map(
                              (cell) => DataCell(Text(cell.toString())),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}