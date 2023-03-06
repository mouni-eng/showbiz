import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/models/notification_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDatbaseHelper {
  NotificationDatbaseHelper._();

  static final NotificationDatbaseHelper db = NotificationDatbaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'NotifyProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
      CREATE TABLE $notifyTable (
        $title TEXT NOT NULL,
        $subtitle TEXT NOT NULL)
        ''');
    });
  }

  Future<void> insert(NotificationModel model) async {
    var dbClient = await database;
    await dbClient.insert(
      notifyTable,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NotificationModel>> getAllNotification() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(notifyTable);
    List<NotificationModel> products =
        maps.isNotEmpty ? maps.map((e) => NotificationModel.fromJson(e)).toList() : [];
    return products;
  }
}
