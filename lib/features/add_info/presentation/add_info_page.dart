import 'dart:io';

import 'package:flutter/material.dart';
import 'package:km_car/common/constants/routes.dart';
import 'package:km_car/common/widgets/add_button.dart';
import 'package:km_car/common/widgets/input_text.dart';
import 'package:km_car/common/constants/text_style.dart';
import 'package:km_car/features/add_info/presentation/add_info_page_controller.dart';


class AddInfoPage extends StatefulWidget {
  const AddInfoPage({super.key});

  @override
  State<AddInfoPage> createState() => _AddInfoPageState();
}

class _AddInfoPageState extends State<AddInfoPage> {
  final AddInfoPageController controller = AddInfoPageController();

  @override
  Widget build(BuildContext context) {

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
                    Text(
                      'Adicionar Viagem',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bigText.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const InputText(
                      labelText: "Quilometragem",                     
                    ),
                    const InputText(
                      labelText: "Motorista",
                      keyboardType: TextInputType.name,
                    ),
                    const InputText(
                      labelText: "Destino",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      child: AddButton(
                        onPressed: () => controller.pickImage(context),
                        text: "adicionar foto da quilometragem",
                        icon: const Icon(Icons.add_a_photo_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.file(File('/data/user/0/com.wizardsmoney.km_car/app_flutter/1723952905054.png')), 
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                child: AddButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, NamedRoute.home, (route) => false),
                  text: "Salvar",
                  icon: const Icon(Icons.save_alt),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
