import 'package:flutter/material.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
      home: const Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inchController = TextEditingController();

  var result = '';

  var resultColor= Colors.black;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.deepPurple,
        title: const Center(
            child: Text(
                'BMI Calculator ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
        ),

    ),

      body:  Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
          
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      '𝙱𝙼𝙸 𝙼𝚎𝚊𝚜𝚞𝚛𝚖𝚎𝚗𝚝 𝙵𝚘𝚛 𝚈𝚘𝚞',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
            
                  const SizedBox(
                    height: 30,
                  ),
            
                  TextField(
                    controller: wtController,
                    decoration: const InputDecoration(
                      label: Text('Enter Your Weight ( in Kgs )'),
                      prefixIcon: Icon(Icons.line_weight),
                    ),
                    keyboardType: TextInputType.number,
                  ),
            
                  const SizedBox(
                    height: 20,
                  ),
            
                  TextField(
                    controller: ftController,
                    decoration: const InputDecoration(
                      label: Text('Enter Your Height ( in Feet )'),
                      prefixIcon: Icon(Icons.height),
                    ),
                    keyboardType: TextInputType.number,
                  ),
            
                  const SizedBox(
                      height: 20,
                  ),
            
                  TextField(
                    controller: inchController,
                    decoration: const InputDecoration(
                      label: Text('Enter Your Height ( in Inch )'),
                      prefixIcon: Icon(Icons.height),
                    ),
                    keyboardType: TextInputType.number,
                  ),
          
                  const SizedBox(
                    height: 34,
                  ),
            
                  ElevatedButton(style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                    onPressed: () {
                        var wt = wtController.text;
                        var ft = ftController.text;
                        var inch = inchController.text;
            
                    if(wt!= '' && ft!= '' && inch!= '') {
                      //BMI Calculation
                      var iwt = int.parse(wt);
                      var ift = int.parse(ft);
                      var iInch = int.parse(inch);
            
                      var tInch = (ift*12) + iInch;
            
                      var tCm = tInch*2.54;
            
                      var tM = tCm/100;
            
                      var bmi = iwt/(tM*tM);
            
                      var msg = ' ';
            
                      if(bmi>25 && bmi<30) {
                        resultColor = Colors.orange;
                        msg = 'You are OverWeight !! 😔 ';
                      }else if(bmi<18) {
                        resultColor = Colors.red;
                        msg = 'You are UnderWeight !! 🥺 ';
                      }else if(bmi>18 && bmi<=25) {
                        resultColor = Colors.green;
                        msg = 'You are Healthy.. 😊 ';
                      }else {
                        resultColor = Colors.deepOrangeAccent;
                        msg = 'You are obese !!!';
                      }
            
                      setState(() {
                        result = '$msg \n Your Bmi is ${bmi.toStringAsFixed(3)}';
                      });
            
            
                    }else {
                      setState(() {
                        result = 'Please fill all the required blanks!!';
                      });
                    }
            
                      },
                    child: const Text('Calculate',style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),),
                  ),
            
                  const SizedBox(height: 22),
            
                  Text(result,style: TextStyle(
                    fontSize: 17,
                    color: resultColor,
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),

    );

  }

  @override
  void dispose() {
    wtController.dispose();
    ftController.dispose();
    inchController.dispose();
    super.dispose();
  }
}

