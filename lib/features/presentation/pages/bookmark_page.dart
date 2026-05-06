import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utd_store/core/theme/app_color.dart';
import '../../../core/di/injector.dart';
import '../../data/models/repositories/bookmark_repo.dart';


class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = sl<BookmarkRepo>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmark',
          style: GoogleFonts.montserrat(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.bold
          ),
          ),
        centerTitle: true,
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
                    color:Color(0xFFA5A3D6),
                  ),

                  const SizedBox(height: 10),

                  //teks
                  Text(
                    "Belum ada produk yang ditambahkan ke bookmark",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA5A3D6),
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0x45EBD3F8),
                      ),
                    ),
                    child: ListTile(
                      //nama prod
                      title: Text(
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      //timestamp
                      subtitle: Text(
                        'Disimpan pada $time',
                        style: GoogleFonts.inter(
                          color: AppColor.textSecondary,
                          fontSize: 12
                        ),  
                      ),

                      //delete
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final repo = sl<BookmarkRepo>();
                          repo.removeBookmark(item.id);
                        },
                      ),
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
