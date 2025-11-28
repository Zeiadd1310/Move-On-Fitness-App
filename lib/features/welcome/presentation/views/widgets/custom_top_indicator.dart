import 'package:flutter/material.dart';

class CustomTopIndicator extends StatelessWidget {
  final double progress;

  const CustomTopIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70),
      child: Container(
        width: 200,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(50),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.topLeft,
          widthFactor: progress,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomTopIndicator extends StatelessWidget {
//   final double progress;

//   const CustomTopIndicator({super.key, required this.progress});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 50),
//       child: Container(
//         width: 200,
//         height: 6,
//         decoration: BoxDecoration(
//           color: Colors.black12,
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: FractionallySizedBox(
//           alignment: Alignment.centerLeft,
//           widthFactor: progress,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(50),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
