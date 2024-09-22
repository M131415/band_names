import 'dart:developer';
import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bandList = [
    Band(id: '1', name: 'El recodo', votes: 1),
    Band(id: '2', name: 'La MS', votes: 3),
    Band(id: '3', name: 'Fuerza Regida', votes: 6),
    Band(id: '4', name: 'Los Angeles Azules', votes: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bandas mas famosas'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: bandList.length,
          itemBuilder: (context, int i) =>_bandTile(bandList[i])
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewBand(),
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        log('${band.name} fue eliminado');
        // todo llamar al servidor para eliminar la banda
      },
      background: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar banda', style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0,2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}',style: const TextStyle(fontSize: 20),),
      ),
    );
  }

  addNewBand(){

    final textCtrl = TextEditingController();

    if( Platform.isAndroid ){
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: const Text('Nueva banda'),
            content: TextField(
              controller: textCtrl,
            ),
            actions: [
              MaterialButton(
                child: const Text('agregar'),
                onPressed: () => onAddNewBand( textCtrl.text),
              ),
              MaterialButton(
                child: const Text('cancelar'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('New band name'),
          content: CupertinoTextField(
            controller: textCtrl,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Agregar'),
              onPressed: () => onAddNewBand(textCtrl.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            ), 
          ],
        );
      },
    );
    }
  }

  void onAddNewBand( String name){
    if (name.length > 1){
      bandList.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      log(name);
      setState(() {});
      Navigator.pop(context);
    }
  }

}