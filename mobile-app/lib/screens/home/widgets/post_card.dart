import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.40,
      height: size.height * 0.40,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.010,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.0),
              offset: const Offset(0.0, 0.0),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size.width * 0.40,
              height: size.height * 0.40,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.network(
                  'https://www.lovidhu.com/uploads/posts/2021/03//sigiria-sri-lanka-945x630.jpg',
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                },
                ),
              ),
            ),
            const Text(
              "Sigiriya",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
