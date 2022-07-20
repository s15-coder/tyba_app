import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tyba_app/bloc/places/places_bloc.dart';
import 'package:tyba_app/widgets/auth_text_field.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const _SearchBarBody();
  }
}

class _SearchBarBody extends StatefulWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  @override
  State<_SearchBarBody> createState() => _SearchBarBodyState();
}

class _SearchBarBodyState extends State<_SearchBarBody> {
  final TextEditingController controller = TextEditingController();
  Timer? timer;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final placesBloc = BlocProvider.of<PlacesBloc>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () async {},
        child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 70,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10)
                ]),
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.65,
                    child: AuthTextField(
                      controller: controller,
                      hintText: 'Escribe una ciudad',
                      prefixIcon: FontAwesomeIcons.search,
                      onChanged: (value) {
                        timer?.cancel();
                        if (value.isNotEmpty) {
                          timer = Timer.periodic(const Duration(seconds: 2),
                              (timer) async {
                            await placesBloc.getPlaces(city: value);
                            timer.cancel();
                          });
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  if (controller.text.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 30,
                      ),
                      onPressed: () {
                        timer?.cancel();
                        placesBloc.clearFeature();
                        controller.clear();
                        setState(() {});
                      },
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
