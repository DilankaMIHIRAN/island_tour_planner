import 'package:flutter/material.dart';
import 'package:island_tour_planner/models/popular_destination_model.dart';
import 'package:skeletons/skeletons.dart';

class PopularCard extends StatelessWidget {
  final PopularDestinationModel popularDestination;

  const PopularCard({
    super.key,
    required this.popularDestination,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.40,
      height: size.height * 0.40,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
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
              height: size.height * 0.3,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: Colors.black.withOpacity(0.4),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Image.network(popularDestination.image,
                    height: size.height * 0.3,
                    width: size.width * 0.5,
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
                }),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                padding: EdgeInsets.all(size.width * 0.014),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.all(Radius.circular(size.width * 0.020))
                ),
                child: Text(
                  popularDestination.name.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
