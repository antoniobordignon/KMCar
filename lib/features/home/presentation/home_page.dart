import 'package:flutter/material.dart';
import 'package:km_car/common/constants/routes.dart';
import 'package:km_car/common/constants/text_style.dart';
import 'package:km_car/common/widgets/add_button.dart';
import 'package:km_car/common/widgets/card.dart';
import 'package:km_car/features/home/presentation/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var controller = HomePageController();
    return Scaffold(
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    const SizedBox(height: 30.0),
                    Text('KMCar',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bigText.copyWith(
                        color: Colors.black,
                      )
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
                      child: ShowCard(
                        km: '150 km',
                        driver: 'João Silva',
                        destination: 'Praia de Copacabana',
                        photo: 'assets/images/test.jpg',
                      ),
                    )
                  ],
                ),
              ),
              Padding(
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
            ],
          );
        },
      ),
    );
  }
}