import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/colors.dart';


class GridViewContainer extends StatelessWidget {
  final VoidCallback onPressed;
  final MaterialColor color;
  final bool? isSmall;
  final IconData icon;
  final String title;
  final String subtitle;
  const GridViewContainer(
      {Key? key,
        required this.onPressed,
        required this.color,
        this.isSmall = false,
        required this.icon,
        required this.title,
        required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color[400],
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 4,
              offset: const Offset(2, 6),
            )
          ],
          gradient: AppColors.getDarkLinearGradient(color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: isSmall! ? Alignment.centerLeft : Alignment.center,
              child: Icon(
                icon,
                size: isSmall! ? 60 : 120,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
