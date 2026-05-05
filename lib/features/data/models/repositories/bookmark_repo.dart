import 'package:isar/isar.dart';
import '../bookmark_model.dart';
import '../../../../core/di/injector.dart';

class BookmarkRepo {
  final Isar isar = sl<Isar>();

  Future<void> addBookmark(String title) async {
    final bookmark = Bookmark()
      ..title = title
      ..savedAt = DateTime.now();
    
    await isar.writeTxn(() async {
      await isar.bookmarks.put(bookmark);
    });
  }

  Future<void> removeBookmark(int id) async {
    await isar.writeTxn(() async {
      await isar.bookmarks.delete(id);
    });
  }

  Stream<List<Bookmark>> watchBookmarks() {
    return isar.bookmarks.where().watch(fireImmediately: true);
  }
}