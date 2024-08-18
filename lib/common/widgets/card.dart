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
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('Quilometragem:'),
                const SizedBox(width: 5.0),
                Text(
                  km,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Motorista:'),
                const SizedBox(width: 5.0),
                Text(driver),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Destino:'),
                const SizedBox(width: 5.0),
                Text(destination),
              ],
            ),
            const SizedBox(height: 15.0),
            Center(
              child:photo.isNotEmpty
              ? Image.asset(
                photo,
                width: 300,
                height: 150,
                fit: BoxFit.cover,
              )
              : const Text('Sem imagem disponível'),
            ),
          ],
        ),
      ),
    );
  }
}
