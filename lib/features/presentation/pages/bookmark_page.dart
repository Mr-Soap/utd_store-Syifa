import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injector.dart';
import '../../data/models/repositories/bookmark_repo.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = sl<BookmarkRepo>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: StreamBuilder(
        stream: repo.watchBookmarks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 290,
                    color: Color.fromARGB(255, 165, 163, 214),
                  ),

                  const SizedBox(height: 10),

                  //teks
                  Text(
                    "Belum ada produk yang ditambahkan ke bookmark",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 165, 163, 214),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              final time =
                  "${item.savedAt.hour.toString().padLeft(2, '0')}:${item.savedAt.minute.toString().padLeft(2, '0')}";

              return Column(
                children: [
                  ListTile(
                    //nama prod
                    title: Text(item.title),

                    //timestamp
                    subtitle: Text('Disimpan pada $time'),

                    //delete
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        final repo = sl<BookmarkRepo>();
                        repo.removeBookmark(item.id);
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(
                      thickness: 0.8,
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
