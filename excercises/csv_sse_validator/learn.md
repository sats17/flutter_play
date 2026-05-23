# Flutter CSV Upload & Validation App

## Project Goal

This project is a beginner-to-intermediate Flutter application that allows users to:

1. Upload a CSV file
2. Read and display CSV data in Flutter
3. Send CSV data to a backend API
4. Validate data on the backend
5. Show validation results/errors in the UI

The purpose of this project is to learn:

* Flutter UI development
* File handling
* CSV parsing
* API integration
* Backend communication
* Validation workflows
* State management basics

---

# Tech Stack

## Frontend

* Flutter
* Dart

## Backend (Planned)

* Node.js + Express OR FastAPI

## Packages

* file_picker
* csv
* http

---

# Learning Roadmap

---

# Phase 1 — Basic Flutter Setup

## Goal

Create a simple Flutter app with an upload button.

## Topics to Learn

* MaterialApp - Done
* Scaffold - Done
* Widgets -Done
* Column / Row
* ElevatedButton
* setState()

## Tasks

* Create Flutter project
* Run app
* Add upload button to screen

---

# Phase 2 — File Upload

## Goal

Allow users to select CSV files from device storage.

## Package

file_picker

## Tasks

* Install file_picker package
* Open file picker
* Restrict selection to CSV files
* Print selected file path

## Learning Outcomes

* async/await
* Future
* File access

---

# Phase 3 — CSV Parsing

## Goal

Read CSV content into Flutter memory.

## Package

csv

## Tasks

* Read file contents
* Parse CSV rows
* Convert CSV into List<List<dynamic>>

## Example Data

```dart
[
  ['name', 'age'],
  ['john', 20],
  ['sam', 25]
]
```

## Learning Outcomes

* File reading
* UTF-8 decoding
* Dart lists

---

# Phase 4 — Display CSV Data

## Goal

Display CSV rows in a table layout.

## Widgets

* DataTable
* ListView
* SingleChildScrollView

## Tasks

* Create table columns
* Render rows dynamically
* Handle scrolling

## Learning Outcomes

* Dynamic UI rendering
* Table layouts
* List rendering

---

# Phase 5 — State Management

## Goal

Manage app state properly.

## Initial Approach

* setState()

## Future Learning

* Provider
* Riverpod

## Tasks

* Store parsed CSV data
* Update UI dynamically

---

# Phase 6 — API Integration

## Goal

Send CSV data to backend API.

## Package

http

## Tasks

* Create POST request
* Send JSON data
* Receive API response

## Learning Outcomes

* REST APIs
* JSON encoding
* HTTP requests

---

# Phase 7 — Backend Development

## Goal

Build backend API for CSV validation.

## Recommended Backend Options

* Node.js + Express
* FastAPI
* Laravel

## Backend Responsibilities

* Receive CSV data
* Validate rows
* Return validation results

---

# Phase 8 — CSV Validation

## Goal

Validate uploaded CSV data.

## Example Validations

* Empty fields
* Invalid email format
* Duplicate records
* Incorrect data types

## Example Response

```json
{
  "valid": false,
  "errors": [
    {
      "row": 3,
      "message": "Invalid email"
    }
  ]
}
```

---

# Phase 9 — Show Validation Errors

## Goal

Display backend validation errors in Flutter UI.

## Ideas

* Highlight rows in red
* Show error column
* Display snackbar alerts

## Learning Outcomes

* Conditional rendering
* Error handling
* Dynamic styling

---

# Phase 10 — Improvements

## Future Features

* Loading spinner
* Upload progress
* Retry support
* Drag & drop upload
* Search/filter
* Pagination
* Export invalid rows

---

# Suggested Folder Structure

```text
lib/
│
├── main.dart
│
├── screens/
│   └── file_upload_screen.dart
│
├── models/
│   └── csv_row_model.dart
│
├── services/
│   ├── csv_service.dart
│   └── validation_service.dart
│
├── widgets/
│   ├── csv_table.dart
│   ├── status_cell.dart
│   └── upload_button.dart
│
└── utils/
    └── constants.dart
```

---

# Weekly Learning Plan

## Week 1

Learn:

* Flutter basics
* Widgets
* Layouts

Build:

* Empty page
* Upload button

---

## Week 2

Learn:

* File picker
* CSV parsing

Build:

* Read CSV file
* Print rows

---

## Week 3

Learn:

* Tables
* Dynamic rendering
* State updates

Build:

* Display CSV in table

---

## Week 4

Learn:

* APIs
* JSON
* HTTP requests

Build:

* Send CSV to backend

---

## Week 5

Learn:

* Validation
* Error handling

Build:

* Display validation results

---

# MVP (Minimum Viable Product)

The first working version should:

* Upload CSV
* Parse CSV
* Display rows
* Send rows to backend
* Receive validation response
* Show validation errors

---

# Important Notes

## Keep It Simple

Do not over-engineer early.

Avoid:

* Complex architecture
* Advanced state management
* Overly large folder structures

Focus on:

1. Making it work
2. Understanding concepts
3. Improving gradually

---

# Useful Resources

## Flutter

* https://flutter.dev

## Packages

* https://pub.dev/packages/file_picker
* https://pub.dev/packages/csv
* https://pub.dev/packages/http

## Backend

* https://expressjs.com
* https://fastapi.tiangolo.com

## API Testing

* https://www.postman.com

---

# Current Progress Checklist

## Setup

* [ ] Flutter project created
* [ ] Upload button added

## File Upload

* [ ] CSV picker working
* [ ] File path printed

## CSV Parsing

* [ ] CSV loaded
* [ ] Rows parsed

## UI

* [ ] Data table created
* [ ] Rows displayed

## API

* [ ] POST request working
* [ ] Backend connected

## Validation

* [ ] Backend validation added
* [ ] Errors displayed in UI

---

# Final Goal

Build a complete CSV upload and validation workflow using Flutter + Backend APIs while learning practical application development concepts step by step.
