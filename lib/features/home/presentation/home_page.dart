import 'package:flutter/material.dart';
import 'package:km_car/common/constants/routes.dart';
import 'package:km_car/common/widgets/add_button.dart';
import 'package:km_car/common/widgets/show_card.dart';
import 'package:km_car/features/add_info/data/orm/model.dart';

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

    _db = AppDb();
  }  

  @override
  void dispose() {
    _db.close();
    super.dispose();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Trip>>(
        future: _db.getTrips(),
        builder: (context, snapshot) {
          final List<Trip>? trips = snapshot.data;

          if(snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (trips != null) {
            return ListView.builder(
              itemCount: trips.length, 
              itemBuilder: (context, index) {
              final trip = trips[index];

              return Card(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
                      child: ShowCard(
                        km: '${trip.id.toString()}',
                        driver: '${trip.kilometragem.toString()}',
                        destination: '${trip.destino.toString()}',
                        photo: 'assets/images/test.jpg',
                      ),
                    ),
                  ],
                ),
              );
            });
          }
            
          }
          AddButton(
            onPressed: () => Navigator.pushNamed(
              context, 
              NamedRoute.addInfo,
            ),
            text: "Adicionar registro",
            icon: const Icon(Icons.add),
          );
          return const Text('Não há dados para exibir');
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
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