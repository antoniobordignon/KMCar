import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _kmController = TextEditingController();
  final _driverController = TextEditingController();
  final _destinationController = TextEditingController();
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
            content: Text(
              'O acesso à câmera foi negado.'),
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
    super.dispose();
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Nova viagem',
            style: AppTextStyle.bigText.copyWith(
              color: Colors.black,
            ),
          ),
          centerTitle: true),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return Column(
            children: [
              Expanded(
                child: Form(
                  key: _key,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: [
                      const SizedBox(height: 20.0),
                      InputText(
                        controller: _kmController,
                        labelText: "Quilometragem",
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,7}(\.\d{0,3})?'),
                          )
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Campo Obrigatório.';
                          } else if (value == '0') {
                            return 'O valor não pode ser 0.';
                          }
                          return null;
                        },
                      ),
                      InputText(
                        controller: _driverController,
                        labelText: "Motorista",
                        maxLength: 50,
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Campo Obrigatório.';
                          } else if (value == '0') {
                            return 'O valor não pode ser 0.';
                          }
                          return null;
                        },
                      ),
                      InputText(
                        controller: _destinationController,
                        labelText: "Destino",
                        maxLength: 50,
                        validator: (value) {
                          if (value == null ||
                              value.toString().trim().isEmpty) {
                            return 'Campo Obrigatório.';
                          }
                          return null;
                        },
                      ),
                      Visibility(
                        visible: !controller.hasImage,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 16.0),
                          child: Column(
                            children: [
                              AddButton(
                                onPressed: _handleAddButtonPress,
                                text: "Adicionar foto",
                                icon: const Icon(Icons.add_a_photo_outlined),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: controller.hasImage
                            ? Image.file(File(controller.imagePath!))
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: AddButton(
          onPressed: () async {
            if (_key.currentState!.validate()) {
              if (controller.hasImage == true) {
                final double kilometragem =
                    double.tryParse(_kmController.text.replaceAll(',', '.')) ??
                        0.00;
                final entity = TripsCompanion(
                  kilometragem: drift.Value(kilometragem),
                  motorista: drift.Value(_driverController.text),
                  destino: drift.Value(_destinationController.text),
                  imagePath: drift.Value(controller.imagePath),
                );
                await _db.insertTrip(entity);

                Navigator.pushNamedAndRemoveUntil(
                    context, NamedRoute.home, (route) => false);
              } else {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Atenção'),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                                'Por gentileza tire uma foto antes de salvar.'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
          text: "Salvar",
          icon: const Icon(Icons.save_alt),
        ),
      ),
    );
  }
}
