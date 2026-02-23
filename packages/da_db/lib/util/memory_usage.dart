import 'dart:io';

void printMemoryUsage() {
 printFullMemoryUsage();
}

void printFullMemoryUsage() {
  // Get the resident set size (RSS) in bytes
  int memoryBytes = ProcessInfo.currentRss;
  
  // Convert to Megabytes for readability
  double memoryMB = memoryBytes / (1024 * 1024);

  print('Current RAM usage: ${memoryMB.toStringAsFixed(2)} MB');
}
