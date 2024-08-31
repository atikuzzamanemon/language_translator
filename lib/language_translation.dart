import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() => _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {

  var languages = ['Bangla','English'];
  var originalLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();

    });

    if(src == '--' || dest== '--'){
      setState(() {
        output = "Fail to Translate";
      });
    }

  }

  String getLanguageCode(String language){
    if(language == "English"){
      return "en";

    }else if (language == "Bangla"){
      return "bn";
    }
    return "--";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text('Translator'),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                focusColor: Colors.white,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                hint: Text(
                  originalLanguage, style: TextStyle(color: Colors.white),
                ),
                dropdownColor: Colors.white,
                icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem){
                      return DropdownMenuItem<String>(child: Text(dropDownStringItem),
                      value: dropDownStringItem,);
                    }).toList(),
                    onChanged: (String ?value){
                  setState(() {
                    originalLanguage = value!;
                  });

                    },
                  ),
                  SizedBox(width: 40,),
                  Icon(Icons.arrow_right_alt_outlined, color: Colors.white,size: 40,),
                  SizedBox(width: 40,),

                  DropdownButton<String>(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage, style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem){
                      return DropdownMenuItem<String>(child: Text(dropDownStringItem),
                        value: dropDownStringItem,);
                    }).toList(),
                    onChanged: (String ?value){
                      setState(() {
                        destinationLanguage = value!;
                      });

                    },
                  ),
                ],

              ),
              SizedBox(height: 40,),
              Padding(padding: EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Please Enter Your Text..",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                ),
                controller: languageController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please Enter Your Text to Translate';
                  }
                  return null;
                },
              ),

              ),
              Padding(padding: EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff2b3c5a)),
                onPressed: (){
                  translate(getLanguageCode(originalLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());
                },
                child: Text("Translate"),
              ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "\n$output",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
