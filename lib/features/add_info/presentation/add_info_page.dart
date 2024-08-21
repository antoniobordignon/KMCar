// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:km_car/common/constants/routes.dart';
import 'package:km_car/common/widgets/add_button.dart';
import 'package:km_car/common/widgets/input_text.dart';
import 'package:km_car/common/constants/text_style.dart';
import 'package:km_car/features/add_info/data/orm/model.dart';
import 'package:km_car/features/add_info/presentation/add_info_page_controller.dart';
import 'package:km_car/service/implement/permission_service_impl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:drift/drift.dart' as drift;
class AddInfoPage extends StatefulWidget {
  const AddInfoPage({super.key});

  @override
  State<AddInfoPage> createState() => _AddInfoPageState();
}

//camera authorization
class _AddInfoPageState extends State<AddInfoPage> {
  final  _kmController = TextEditingController();
  final  _driverController = TextEditingController();
  final  _destinationController = TextEditingController();
  final  _photoController = TextEditingController();
  final AddInfoPageController controller = AddInfoPageController();
  late AppDb _db;

  Future<void> _handleAddButtonPress() async {
    final status = await getCameraPermission();
    if (mounted) {
      if (status.isGranted) {
        controller.pickImage(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera permission is denied. Please allow camera access.'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    _kmController.dispose();
    _driverController.dispose();
    _destinationController.dispose();
    _photoController.dispose();
    super.dispose();
  }

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
                    InputText(
                      controller: _kmController,
                      labelText: "Quilometragem",
                      keyboardType: TextInputType.number,                     
                    ),
                    InputText(
                      controller: _driverController,
                      labelText: "Motorista",
                    ),
                    InputText(
                      controller: _destinationController,
                      labelText: "Destino",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                      child: Column(
                        children: [
                          AddButton(
                            onPressed: _handleAddButtonPress,
                            text: "Adicionar foto da quilometragem",
                            icon: const Icon(Icons.add_a_photo_outlined),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Image.file(File('/data/user/0/com.wizardsmoney.km_car/app_flutter/1723952905054.png')), 
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                child: AddButton(
                  onPressed: () async {
                    final int kilometragem = int.tryParse(_kmController.text) ?? 0;
                    final entity = TripsCompanion(
                      kilometragem: drift.Value(kilometragem),
                      motorista: drift.Value(_driverController.text),
                      destino: drift.Value(_destinationController.text),
                    );
                    await _db.insertTrip(entity);

                    Navigator.pushNamedAndRemoveUntil(
                    context, NamedRoute.home, (route) => false);
                  },
                  text: "Salvar",
                  icon: const Icon(Icons.save_alt),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
}