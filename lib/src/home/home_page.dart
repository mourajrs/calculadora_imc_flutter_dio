import 'package:dio_lab_flutter_imc/src/home/home_controller.dart';
import 'package:dio_lab_flutter_imc/src/home/models/imc.dart';
import 'package:dio_lab_flutter_imc/src/repositories/hive_repositoy.dart';
import 'package:flutter/material.dart';

import '../utils/formatter.dart';
import '../utils/validator.dart';
import '../widgets/calculate_button.dart';
import '../widgets/field_custon.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final _weigth = TextEditingController(text: '0.00');
  final _heigth = TextEditingController(text: '0.00');
  final _controller = HomeController(IMC(), HiveRepository(), <String>[]);

  @override
  void dispose() {
    _weigth.dispose();
    _heigth.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    _controller.imcList = await _controller.getList('imcList');
    updateList();
  }

  void updateList() {
    setState(() {
      _weigth.text = '0.00';
      _heigth.text = '0.00';
    });
  }

  Future<void> setList(List<String> list) async {
    await _controller.setList('imcList', list);
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  FieldCuston(
                    controller: _weigth,
                    label: 'Peso (Kg)*',
                    formatter: const [
                      Formatter(
                        asFixed: 2,
                      ),
                    ],
                    validator: Validator.notLessThen(
                      'Informe seu peso.',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FieldCuston(
                    controller: _heigth,
                    label: 'Altura (m)*',
                    textInputAction: TextInputAction.done,
                    formatter: const [
                      Formatter(
                        asFixed: 2,
                      ),
                    ],
                    validator: Validator.notLessThen(
                      'Informe sua altura.',
                      minimumValue: 0.1,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CalculateButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final imc = _controller.calculate(
                          weigth: double.parse(_weigth.text),
                          heigth: double.parse(_heigth.text),
                        );

                        _controller.imcList.add(imc);
                        await setList(_controller.imcList);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            showCloseIcon: true,
                            closeIconColor: Colors.red,
                            backgroundColor: Colors.white,
                            content: Text(
                              'Necessário informar todos os campos para continuar!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('CALCULAR'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.imcList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _controller.imcList[index],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () async {
                                _controller.imcList.removeAt(index);
                                await setList(_controller.imcList);
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
