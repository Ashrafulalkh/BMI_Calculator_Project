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
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
      home: Home(),
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
        backgroundColor: Colors.deepPurple,
        title: const Center(
            child: Text(
                'Your BMI',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
        ),

    ),

      body:  Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'BMI',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
        
              const SizedBox(
                height: 20,
              ),
        
              TextField(
                controller: wtController,
                decoration: const InputDecoration(
                  label: Text('Enter Your Weight (in Kgs)'),
                  prefixIcon: Icon(Icons.line_weight),
                ),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(
                height: 11,
              ),
        
              TextField(
                controller: ftController,
                decoration: const InputDecoration(
                  label: Text('Enter Your Height (in Feet)'),
                  prefixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(
                  height: 11
              ),
        
              TextField(
                controller: inchController,
                decoration: const InputDecoration(
                  label: Text('Enter Your Height (in Inch)'),
                  prefixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),

              ElevatedButton(style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
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

                  if(bmi>25) {
                    resultColor = Colors.orange;
                    msg = 'You are OverWeight!!';
                  }else if(bmi<18) {
                    resultColor = Colors.red;
                    msg = 'You are UnderWeight!!';
                  }else {
                    resultColor = Colors.green;
                    msg = 'You are Healthy';
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
                child: const Text('Calculate',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 10),

              Text(result,style: TextStyle(
                fontSize: 18,
                color: resultColor,
              ),),
            ],
          ),
        ),
      ),

    );
  }
}

