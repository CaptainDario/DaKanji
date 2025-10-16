
import 'dart:io';

import 'package:github/github.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;


Future<String> getSourceFromGHRelease(String owner, String repo,
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
  final downloadUrl = Uri.parse(targetAsset.browserDownloadUrl!);
  final response = await http.get(downloadUrl);

  if (response.statusCode == 200) {
    final file = File(p.join(outputDir.path, targetAsset.name!));
    await file.writeAsBytes(response.bodyBytes);
    print('✅ Download complete! Saved to ${file.path}');
  } else {
    print('Failed to download. Status code: ${response.statusCode}');
  }

  return 'Downloaded ${targetAsset.name} from $owner/$repo release ${latestTag.tagName} at ${DateTime.now()}...';
}

Future<String> getSourceFromUri(Uri url, Directory outputDir) async {

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

  return 'Downloaded $fileName from $url at ${DateTime.now()}...';
}