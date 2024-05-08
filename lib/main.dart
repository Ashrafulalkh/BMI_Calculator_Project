import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
          prefixIconColor: Colors.deepPurple,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
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
  var ageController = TextEditingController();

  double? result = 0;

  var resultColor= Colors.black;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            ageController.clear();
            ftController.clear();
            wtController.clear();
            inchController.clear();
          }, icon: const Icon(Icons.replay,color: Colors.white,)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert,color: Colors.white,)),
        ],
        elevation: 10,
        backgroundColor: Colors.deepPurple,
        title:const Text(
                'BMI Calculator',
              style: TextStyle(
                color: Colors.white,
              ),
            ),

          ),


      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                          controller: ageController,
                          decoration: const InputDecoration(
                            label: Text('Enter Your Age'),
                            prefixIcon: Icon(Icons.monitor_heart),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.56,
                      child: TextFormField(
                        controller: wtController,
                        decoration: const InputDecoration(
                          label: Text('Enter Your Weight ( in Kgs )'),
                          prefixIcon: Icon(Icons.line_weight),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.63,
                      child: TextFormField(
                        controller: ftController,
                        decoration: const InputDecoration(
                          label: Text('Enter Your Height ( in Feet )'),
                          prefixIcon: Icon(Icons.height),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: TextField(
                        controller: inchController,
                        decoration: const InputDecoration(
                          label: Text('Inch'),
                          prefixIcon: Icon(Icons.height),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                ElevatedButton(style: ElevatedButton.styleFrom(
                  elevation: 15,
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  onPressed: () {
                      var wt = wtController.text;
                      var ft = ftController.text;
                      var inch = inchController.text;


                    //BMI Calculation
                    double? iwt = double.tryParse(wt) ?? 0;
                    double? ift = double.tryParse(ft) ?? 0;
                    double? iInch = double.tryParse(inch) ?? 0;

                    double? tInch = (ift*12) + iInch;

                    double? tCm = tInch*2.54;

                    double? tM = tCm/100;

                    result = iwt/(tM*tM);


                    setState(() {});

                    },

                  child: const Text('Calculate',style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),),
                ),

                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 340,
                  child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(minimum: 15, maximum: 46,
                            ranges: <GaugeRange>[
                              GaugeRange(startValue: 15, endValue: 18.5, color:Colors.red),
                              GaugeRange(startValue: 18.5,endValue: 25,color: Colors.green),
                              GaugeRange(startValue: 25,endValue: 35,color: Colors.yellow),
                              GaugeRange(startValue: 35,endValue: 40,color: Colors.orange),
                              GaugeRange(startValue: 40,endValue: 46,color: Colors.deepOrange),],
                            pointers: <GaugePointer>[
                              NeedlePointer(value: result?.toDouble() ?? 0)],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(widget: Text((result?.toStringAsFixed(3)).toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                                  angle: 90, positionFactor: 0.5
                              )]
                        )]),
                ),

                 const Divider(),
                
                 Row(
                  children: [
                    Text('Very Severely Underweight',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) <= 15.99 ? Colors.red : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('<= 15.9',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) <= 15.9 ? Colors.red : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),
                 Row(
                  children: [
                    Text('Severely Underweight',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 16  && (result?.toDouble() ?? 0) <= 16.99? Colors.red : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('16.0 - 16.9',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 16  && (result?.toDouble() ?? 0) <= 16.99? Colors.red : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),
                 Row(
                  children: [
                    Text('Underweight',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 17  && (result?.toDouble() ?? 0) <= 18.49? Colors.red : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('17.0 - 18.4',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 17  && (result?.toDouble() ?? 0) <= 18.49? Colors.red : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),
                 Row(
                  children: [
                    Text('Normal',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 18.5  && (result?.toDouble() ?? 0) <= 24.99? Colors.green : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('18.5 - 24.9',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 18.5  && (result?.toDouble() ?? 0) <= 24.99? Colors.green: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),
                 Row(
                  children: [
                    Text('Overweight',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 25  && (result?.toDouble() ?? 0) <= 29.99? Colors.yellow : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('25.0 - 29.9',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 25  && (result?.toDouble() ?? 0) <= 29.99? Colors.yellow : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),
                 Row(
                  children: [
                    Text('Obese Class I',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 30  && (result?.toDouble() ?? 0) <= 34.99? Colors.yellow : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('30.0 - 34.9',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 30  && (result?.toDouble() ?? 0) <= 34.99? Colors.yellow : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),
                 Row(
                  children: [
                    Text('Obese Class II',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 35  && (result?.toDouble() ?? 0) <= 39.99? Colors.orange : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('35.0 - 39.9',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 35  && (result?.toDouble() ?? 0) <= 39.99? Colors.orange : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),
                 Row(
                  children: [
                    Text('Obese Class III',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 40 || (result?.toDouble() ?? 0) >= 45 ? Colors.orange : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),),

                    const Spacer(),

                     Text('>= 45.0',style: TextStyle(
                      fontSize: 17,
                      color: (result?.toDouble() ?? 0) >= 40 || (result?.toDouble() ?? 0) >=45 ? Colors.orange : Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),)
                  ],
                ),

                const Divider(),

                const Text('Normal Weight: 60 Kg To 80 Kg',
                  textAlign:TextAlign.center,
                  style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepOrange,
                ),)

              ],
            ),
          ),
      ),
    );

  }

  @override
  void dispose() {
    ageController.dispose();
    wtController.dispose();
    ftController.dispose();
    inchController.dispose();
    super.dispose();
  }
}

