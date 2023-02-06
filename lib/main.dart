import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/add_expenses.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: [
                              Text(
                                'Welcome!',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Dinesh Saran',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.settings_rounded,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
             
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: user.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if(streamSnapshot.hasData)
                    return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 20,top: 10),
                            child: Column(
                              children: [
                                Text(documentSnapshot['Date']),
                                Text ( documentSnapshot['Time']),
                              ],
                            ),
                          ),
                          title:Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(documentSnapshot["Amount"],),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(documentSnapshot['Category']),
                          ),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(documentSnapshot["Status"]),
                          ),

                        ),
                      );
                    });
                    else{
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddExpenses()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
