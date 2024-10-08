import 'package:flutter/material.dart';
import 'package:km_car/common/constants/routes.dart';
import 'package:km_car/common/constants/text_style.dart';
import 'package:km_car/common/widgets/add_button.dart';
import 'package:km_car/common/widgets/show_card.dart';
import 'package:km_car/features/add_info/data/orm/model.dart';
import 'package:km_car/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDb _db;

  @override
  void initState() {
    super.initState();

    _db = db; 
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KMCar',
          style: AppTextStyle.bigText.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Trip>>(
        future: _db.getTrips(),
        builder: (context, snapshot) {
          final List<Trip>? trips = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          // Caso exista registro de viagem será exibido usando o card abaixo.
          if (snapshot.connectionState == ConnectionState.done) {
            if (trips != null) {
              if (trips.isNotEmpty) {
                return ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return Column(
                        children: [
                          const SizedBox(height: 2.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7.0, vertical: 7.0),
                            child: ShowCard(
                              trip: trip,
                            ),
                          ),
                        ],
                      );
                    });
              }
            }
          }
          // Caso não hajam viagens sera retornado a mensagem abaixo.
          return const SizedBox(
            width: double.infinity,
            height: 140,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_outlined,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text('Não há viagens!'),
                ],
              )
            )
          );
        },
      ),
      // Botão para adicionar novos registros usado bottomNavigationBar para que fique sempre no final da tela.
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: AddButton(
          onPressed: () => Navigator.pushNamed(
            context,
            NamedRoute.addInfo,
          ),
          text: "Adicionar registro",
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
