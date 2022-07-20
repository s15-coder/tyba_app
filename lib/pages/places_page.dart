import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_app/bloc/places/places_bloc.dart';
import 'package:tyba_app/pages/profile_page.dart';
import 'package:tyba_app/widgets/search_bar.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);
  static const String routeName = "PlacesPage";

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  @override
  void initState() {
    super.initState();
    // final taskBloc = BlocProvider.of<TaskBloc>(context);
    // taskBloc.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(
            context,
            ProfilePage.routeName,
          ),
          icon: const Icon(Icons.settings),
        ),
        title: Text('Lugares'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const PlacesList(),
          const SearchBar(),
        ],
      ),
    );
  }
}

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        if (state.fetchingData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.features.isEmpty) {
          return const Center(
            child: Text('No hay restaurantes para mostar'),
          );
        }
        return Container(
          height: size.height * .9,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.13,
              ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      final place = state.features[index];
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: Text(place.text),
                          subtitle: Text(place.placeName),
                        ),
                      );
                    },
                    itemCount: state.features.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
