import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeListCard extends StatelessWidget {
  final Map<String, dynamic> recipeData;

  const RecipeListCard({super.key, required this.recipeData});

  @override
  Widget build(BuildContext context) {
    final time = recipeData['time'].toString().contains('Minutes')
        ? recipeData['time'].toString()
        : '${recipeData['time']} Minutes';
    final calories =
        recipeData['cal']?.toString() ??
        recipeData['calories']?.toString() ??
        '0 Cal';
    return Align(
      alignment: AlignmentGeometry.center,
      child: Container(
        height: 110,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recipeData['title']!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          size: 14,
                          color: Color(0xff212020),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff212020),
                            fontFamily: 'League Spartan',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          FontAwesomeIcons.fire,
                          size: 14,
                          color: Color(0xff212020),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          calories.contains('Cal') ? calories : '$calories Cal',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff212020),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(20),
              ),
              child: Builder(
                builder: (_) {
                  final imagePath = recipeData['image']!.toString();
                  final isNetwork = imagePath.startsWith('http://') ||
                      imagePath.startsWith('https://');
                  if (isNetwork) {
                    return Image.network(
                      imagePath,
                      width: 150,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : Container(
                              width: 150,
                              color: Colors.grey.shade800,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade800,
                        width: 150,
                        height: double.infinity,
                        child: const Icon(Icons.image, color: Colors.white54),
                      ),
                    );
                  }
                  return Image.asset(
                    imagePath,
                    width: 150,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey,
                      width: 150,
                      height: double.infinity,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
