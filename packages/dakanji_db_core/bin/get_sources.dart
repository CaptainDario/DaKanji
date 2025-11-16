
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github/github.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;


Future<(String downloadInfo, String fileName)> getSourceFromGHRelease(String owner, String repo,
  String assetNameStartsWith, String assetNameEndsWith,
  Directory outputDir) async {
  GitHub github = GitHub();

  RepositorySlug slug = RepositorySlug(owner, repo);
  final latestTag = await github.repositories.getLatestRelease(slug);
  final assets = latestTag.assets ?? [];
  final targetAsset = assets.firstWhere(
    (asset) =>
        asset.name != null &&
        asset.name!.startsWith(assetNameStartsWith) &&
        asset.name!.endsWith(assetNameEndsWith),
    orElse: () => throw Exception('Asset not found'),
  );
  print('Downloading ${targetAsset.name} from $owner/$repo release ${latestTag.tagName}...');
  final downloadPath = p.join(outputDir.path, targetAsset.name!);
  final response = await Dio().download(
    targetAsset.browserDownloadUrl!,
    downloadPath,
    onReceiveProgress: (count, total) {
      if (total != -1) {
        final progress = (count / total * 100).toStringAsFixed(2);
        stdout.write('\rDownloading... $progress%');
      }
    },
  );

  print('\n✅ Download complete! Saved to $downloadPath');

  return (
    'Downloaded ${targetAsset.name} from $owner/$repo release ${latestTag.tagName} at ${DateTime.now()}...',
    targetAsset.name!
  );
}

Future<(String downloadInfo, String fileName)> getSourceFromUri(Uri url, Directory outputDir) async {

  // Get the filename from the URL
  final fileName = url.pathSegments.last;

  print('Downloading $fileName from $url...');

  // Make the HTTP GET request
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // Write the response body to a local file
    final file = File(p.join(outputDir.path, fileName));
    await file.writeAsBytes(response.bodyBytes);
    print('✅ Download complete! Saved to ${file.path}');
  } else {
    print('Error: Failed to download file. Status code: ${response.statusCode}');
  }

  return (
    'Downloaded $fileName from $url at ${DateTime.now()}...',
    fileName
  );
}