import 'package:flutter/material.dart';
import 'package:maps_example/model/repository.dart';
import 'package:maps_example/model/route_entity.dart';
import 'package:maps_example/screens/google_map_page.dart';

class MainScreen extends StatefulWidget {
  final RoutesRepository routesRepository;
  const MainScreen({Key? key, required this.routesRepository}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<RouteEntity> _routesList=[];
String updateText = 'no update';
  Future<void> _getRoutes() async {
    _routesList = await widget.routesRepository.getAllRoutes();
    setState(() {
      _routesList = _routesList;
    });
  }



  Future<void> _removeRoute(int id) async {
    await widget.routesRepository.removeRoute(id);
    _getRoutes();
  }


  @override
  void initState() {
    _getRoutes();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Маршруты"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoogleMapPage(
                routesRepository: widget.routesRepository,
              ),
            ),
          ).then((value) => _getRoutes()).then((value) => setState(() {
            updateText = 'update';
          }));


        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: StatefulBuilder(
              builder: (context, setState) => _routesList.isEmpty
                  ? const Center(
                      child: Text("Нет маршрутов"),
                    )
                  : ListView.builder(
                    itemCount: _routesList.length,
                    itemBuilder: (BuildContext context, int index) => _buildRouteItem(index),
                  ),),
          ),
          Expanded(child: Text(updateText))
        ],
      ),
      
    );
  }

  Widget _buildRouteItem(int index) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: ListTile(
              title: Text(_routesList[index].startAddress),
              subtitle:_routesList[index].endLat!= null? Text(_routesList[index].endAddress??''):Text(''),
              //title: Text(_routesList[index].startLat.toString() + " " + _routesList[index].startLng.toString()),
             //  subtitle: Text(_routesList[index].endLat!= null?_routesList[index].endLat.toString() + " " + _routesList[index].endLng.toString():''),
              onTap: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleMapPage(
                      routeEntity: _routesList[index],
                      routesRepository: widget.routesRepository,
                      //updateRoute: _updateRoute,
                      //removeRoute: _removeRoute,
                    ),
                  ),

                ).then((value) => _getRoutes());
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _removeRoute(_routesList[index].id);
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
