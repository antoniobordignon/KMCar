import 'dart:io';

import 'package:flutter/material.dart';

class ShowCard extends StatelessWidget {
  final String km;
  final String driver;
  final String destination;
  final String photo;

  const ShowCard({
    super.key,
    required this.km,
    required this.driver,
    required this.destination,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'exibirImagemDialog',
          pageBuilder: (context, animation, secondaryAnimation) {
            return Container();
          },
          transitionBuilder: (context, a1, a2, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                child: AlertDialog(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  content: SizedBox(
                    width: 1280,
                    height: 800 * 0.7,
                    child: photo.isNotEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(photo)),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$km KM',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Text('Sem imagem disponível'),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5.0),
                    Text('Quilometragem: $km'),
                    const SizedBox(height: 5.0),
                    Text('Motorista: $driver'),
                    const SizedBox(height: 5.0),
                    Text('Destino: $destination'),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ),
              photo.isNotEmpty
                  ? Image.file(
                      File(photo),
                      width: 100,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : const Text('Sem imagem disponível'),
            ],
          ),
        ),
      ),

      // child: Card(
      //   color: Colors.white,
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisSize: MainAxisSize.min,
      //       children: <Widget>[
      //         Row(
      //           children: <Widget>[
      //             const Text('Quilometragem:'),
      //             const SizedBox(width: 5.0),
      //             Text(
      //               km,
      //               style: const TextStyle(
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: <Widget>[
      //             const Text('Motorista:'),
      //             const SizedBox(width: 5.0),
      //             Text(driver),
      //           ],
      //         ),
      //         Row(
      //           children: <Widget>[
      //             const Text('Destino:'),
      //             const SizedBox(width: 5.0),
      //             Text(destination),
      //           ],
      //         ),
      //         const SizedBox(height: 15.0),
      //         Center(
      //           child: photo.isNotEmpty
      //               ? Image.file(
      //                   File(photo),
      //                   height: 120,
      //                 )
      //               : const Text('Sem imagem disponível'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
