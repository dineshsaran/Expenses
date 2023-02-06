import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  var AmountControler = TextEditingController();
  var CategoryControler = TextEditingController();
  final CollectionReference user =
  FirebaseFirestore.instance.collection('User');
  List<String> items = <String>['Debit','Credit'];
  String dropdownValue = 'Credit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.grey.withOpacity(.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Add Expenses',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
            ],),
             SizedBox(height: 80,),
             SizedBox(
                 width: 320,
                 child: TextField(
                   controller: AmountControler,
                   decoration: InputDecoration(
                     prefix: Padding(
                       padding: const EdgeInsets.only(right:120),
                       child: Text(''),
                     ),
                     label: Center(child: Text('Amount')),
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                     enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                     disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                     focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                     filled: true,
                     fillColor: Colors.white
                   ),
                 )),
            SizedBox(height: 30,),
            SizedBox(
                width: 320,
                child: TextField(
                  controller: CategoryControler,
                  decoration: InputDecoration(
                      prefix: Padding(
                        padding: const EdgeInsets.only(right:120),
                        child: Text(''),
                      ),
                      label: Center(child: Text('Category')),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide:BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Colors.white
                  ),
                )),
            SizedBox(height: 30,),
             Center(
               child: Container(
                 width: 320,
                 height: 60,
                 decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                 child: Center(
                   child: DropdownButton(
                     focusColor: Colors.white,
                     value: dropdownValue,
                     items: items.map<DropdownMenuItem<String>>(
                       (String value) {
                         return DropdownMenuItem(child: Text(value),value: value,);
                       }
                   ).toList(), onChanged: (String? newValue) {
                     setState(() {
                       dropdownValue = newValue!;
                     });
                   },),
                 ),
               ),
             ),

            SizedBox(height: 100,),
            SizedBox(
                width: 320,
                height: 50,
                child: ElevatedButton(onPressed: ()async{
                 String amount = AmountControler.text;
                 String category = CategoryControler.text;

                  await FirebaseFirestore.instance.collection('User').doc(DateFormat('dd MMMM yyyy hh:mm:ss aa').format(DateTime.now())).set(
                      { 'Amount':amount,'Category':category, 'Status':dropdownValue, 'Date': DateFormat('dd MMMM yyyy')
                          .format(DateTime.now()), 'Time':DateFormat('hh:mm aa').format(DateTime.now())}).then((value) => Navigator.pop(context));

                }, child: Text('SAVE')))
          ],
        ),
      ),
    );
  }
}
