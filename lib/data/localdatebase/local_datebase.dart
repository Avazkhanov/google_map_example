import 'package:google_map_example/data/localdatebase/place_model_constants.dart';
import 'package:google_map_example/data/models/place_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _init("google_map.db");
    return _database!;
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''CREATE TABLE ${PlaceModelConstants.tableName} (
      ${PlaceModelConstants.id} $idType,
      ${PlaceModelConstants.placeName} $textType,
      ${PlaceModelConstants.placeCategory} $textType,
      ${PlaceModelConstants.latlng} $textType,
      ${PlaceModelConstants.entrance} $textType,
      ${PlaceModelConstants.flatNumber} $intType,
      ${PlaceModelConstants.orientAddress} $textType,
      ${PlaceModelConstants.stage} $textType
    )''');

  }

  static Future<PlaceModel> insertPlace(PlaceModel placeModel) async {
    final db = await databaseInstance.database;
    int savedTaskID =
        await db.insert(PlaceModelConstants.tableName, placeModel.toJson());
    return placeModel.copyWith(id: savedTaskID);
  }

  static Future<List<PlaceModel>> getAllPlace() async {
    final db = await databaseInstance.database;
    String orderBy = "${PlaceModelConstants.id} DESC"; //"_id DESC"
    List json = await db.query(PlaceModelConstants.tableName, orderBy: orderBy);
    return json.map((e) => PlaceModel.fromJson(e)).toList();
  }

  static Future<int> deletePlace(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      PlaceModelConstants.tableName,
      where: "${PlaceModelConstants.id} = ?",
      whereArgs: [id],
    );
    return deletedId;
  }
}
