// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// ignore: constant_identifier_names
const DATABASENAME = "trees.db";

class Tree {
  final int id;
  final String primaryName;
  final String scientificName;
  final String botanicalDescription;
  final String fieldCharacteristics;
  final String ecologyAndDistribution;

  Tree(
      {required this.id,
      required this.primaryName,
      required this.scientificName,
      required this.botanicalDescription,
      required this.fieldCharacteristics,
      required this.ecologyAndDistribution});

  Tree.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        primaryName = res["primary_name"],
        scientificName = res["scientific_name"],
        botanicalDescription = res["botanical_description"],
        fieldCharacteristics = res["field_characteristics"],
        ecologyAndDistribution = res["ecology_and_distribution"];
}

class DatabaseHandler {
  initializeDB() async {
    var databasesPath = await getDatabasesPath();
    const _databaseName = DATABASENAME;
    var path = join(databasesPath, _databaseName);

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", _databaseName));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
    // open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<Map<String, dynamic>>> retrieveAllTrees() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('tree');
    db.close();
    return (queryResult);
  }

  Future<List<Tree>> allTrees() async {
    var _allTrees = await retrieveAllTrees();
    List<Tree> res = [];

    for (int i = 0; i < _allTrees.length; i++) {
      res.add(Tree.fromMap(_allTrees[i]));
    }
    return res;
  }
}
