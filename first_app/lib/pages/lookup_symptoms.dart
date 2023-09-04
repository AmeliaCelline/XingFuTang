// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:first_app/services/diseases.dart';

class Model extends StatefulWidget {
  const Model({super.key});

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  // List <String> indexToDisease = ['Drug Reaction', 'Malaria', 'Allergy', 'Hypothyroidism', 'Psoriasis', 'GERD', 'Chronic cholestasis', 'hepatitis A', 'Osteoarthristis', '(vertigo) Paroymsal  Positional Vertigo', 'Hypoglycemia', 'Acne', 'Diabetes ', 'Impetigo', 'Hypertension ', 'Peptic ulcer diseae', 'Dimorphic hemmorhoids(piles)', 'Common Cold', 'Chicken pox', 'Cervical spondylosis', 'Hyperthyroidism', 'Urinary tract infection', 'Varicose veins', 'AIDS', 'Paralysis (brain hemorrhage)', 'Typhoid', 'Hepatitis B', 'Fungal infection', 'Hepatitis C', 'Migraine', 'Bronchial Asthma', 'Alcoholic hepatitis', 'Jaundice', 'Hepatitis E', 'Dengue', 'Hepatitis D', 'Heart attack', 'Pneumonia', 'Arthritis', 'Gastroenteritis', 'Tuberculosis'];
  late final Interpreter interpreter;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future <void> loadModel() async{
    interpreter = await Interpreter.fromAsset('assets/model/knn_model.tflite');
  }

  @override
  void dispose() {
    interpreter.close();
    super.dispose();
  }

  int generate(List<List<int>> input){
    List<List<double>> output = List<List<double>>.generate(1, (row) => List<double>.generate(41, (col) => 0));
    interpreter.run(input,output);
    double max = 0;
    int maxIndex =0;
    for (int i = 0; i < output[0].length ; i++){
      if (output[0][i] > max){
        max = output[0][i];
        maxIndex = i;
      }
    }
    return(maxIndex);
  }

  Color ? yellowApp = Color(0xfffbc02d);
  Color ? blackApp = Color(0xff212121);


  List<List<int>> input = List<List<int>>.generate(1, (row) => List<int>.generate(132, (col) => 0));
  List <Symptoms> chosen = [];
  List <Symptoms> notChosen = List.from(ResourcesSymptoms.symptomsFullList);
  late List <Symptoms> notChosenDisplay = List.from(notChosen);

  int counter = 0;


  @override
  Widget build(BuildContext context) {

    void updateFilter(String value){
      setState((){
        notChosenDisplay = notChosen.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
      });
    }
    
    
    void removed(Symptoms obj){
      setState(() {
        input[0][obj.index] = 0;
        notChosen.add(obj);
        notChosenDisplay.add(obj);
        chosen.removeWhere((symptom) => symptom.index == obj.index);

        counter-=1;
      });
    }

    void picked(Symptoms obj){
      if (counter < 17) {
        setState(() {
          input[0][obj.index] = 1;

          notChosen.removeWhere((symptom) => symptom.index == obj.index);
          notChosenDisplay.removeWhere((symptom) => symptom.index == obj.index);
          chosen.add(obj);

          counter += 1;
        });
      }
    }



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Select Symptoms"),
        backgroundColor: yellowApp,
        foregroundColor: blackApp,
        elevation: 0,
      ),
      backgroundColor: blackApp,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Text('Chosen: $counter/17',
                        style: TextStyle(
                          fontFamily: 'Quantico',
                          fontSize: 20,
                          color: yellowApp,
                        ),
                      ),
                      SizedBox(height:5),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing:5,
                        runSpacing: 3,
                        children: chosen.map((i){

                          return Chip(
                            onDeleted: () => removed(i),
                            deleteIcon: Icon(Icons.close),
                            backgroundColor: yellowApp,
                            label: Text(i.name),
                          );
                        }).toList(),
                      ),
                    Text('Symptoms:',
                      style: TextStyle(
                        fontFamily: 'Quantico',
                        fontSize: 20,
                        color: yellowApp,
                      ),
                    ),
                    SizedBox(height:10),
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
                        isDense: true,
                      ),
                    ),
                    SizedBox(height:10),
                    counter == 17 ? Text('can only choose 17',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ):
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing:5,
                      runSpacing: 3,
                      children: notChosenDisplay.map((i){
                        return ActionChip(
                          onPressed: () => picked(i),
                          backgroundColor: Colors.white,
                          label: Text(i.name),
                        );
                      }).toList(),

                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: ElevatedButton(
                    autofocus: true,
                    style: ElevatedButton.styleFrom(
                      //padding: EdgeInsets.fromLTRB(30, 0, 30, 0   ),
                      backgroundColor: Colors.blue,
                      foregroundColor: blackApp,
                      disabledBackgroundColor: Colors.grey,
                      disabledForegroundColor: Colors.black,
                    ),
                    onPressed: counter == 0 ? null: (){
                      int diseaseIndex = generate(input);
                      Navigator.of(context).pushNamed('/result', arguments: Resources.diseaseFullList[diseaseIndex] );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Enter  "),
                        Icon(Icons.arrow_forward_rounded),
                      ],
                    )
                  ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
