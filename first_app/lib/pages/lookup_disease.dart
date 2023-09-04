// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:first_app/services/diseases.dart';

class LookUpDisease extends StatefulWidget {
  const LookUpDisease({super.key});

  @override
  State<LookUpDisease> createState() => _LookUpDiseaseState();
}

class _LookUpDiseaseState extends State<LookUpDisease> {

  late List<Diseases> diseasesDisplay = List.from(Resources.diseaseFullList);

  void updateFilter(String value){
    setState((){
      diseasesDisplay = Resources.diseaseFullList.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  @override
  Widget build(BuildContext context) {

    Color ? yellowApp = Color(0xfffbc02d);
    Color ? blackApp = Color(0xff212121);
    return Scaffold(
      appBar: AppBar(
        title: Text("Input the disease"),
        backgroundColor: yellowApp,
        foregroundColor: blackApp,
        elevation: 0,
      ),
      backgroundColor: blackApp,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => updateFilter(value),
              style: TextStyle(color: blackApp, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: blackApp,
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: diseasesDisplay.isEmpty ? Text("Not Found", style: TextStyle(color: yellowApp, fontSize: 20),) :
              ListView.builder(
                itemBuilder: (context, index){
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      onTap: (){
                        Navigator.of(context).pushNamed('/result', arguments: diseasesDisplay[index]);
                      },
                      title: Text(diseasesDisplay[index].name, style: TextStyle(color: Color(0xffd6d6d6))),
                      tileColor: Color(0xff424242),
                      leading: Icon(Icons.arrow_forward_rounded, color:yellowApp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
                itemCount: diseasesDisplay.length,
              ),
            ),

          ],
        )
      ),

    );
  }
}
