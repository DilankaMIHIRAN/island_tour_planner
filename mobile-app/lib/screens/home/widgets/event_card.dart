import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class EventCard extends StatelessWidget {
  final String image;
  final void Function()? onTap;

  const EventCard({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.1,
        width: size.width * 10,
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(26)),
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
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(26)),
              child: Image.network(
                image,
                height: size.height * 0.2,
                width: size.width * 0.9,
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
            )
          ],
        ),
      ),
    );
  }
}
