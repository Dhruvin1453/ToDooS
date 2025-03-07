import 'package:flutter/material.dart';
import 'package:todoo/todo_item.dart';
import 'package:todoo/todo.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});





  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final todolist = Todo.todolist();
  TextEditingController notescontroller = TextEditingController();
  List<Todo> _searchlist = Todo.todolist();
  void _addnotes(){

    setState(() {
      String notes = notescontroller.text;

      if(!notes.isEmpty){
        todolist.add(Todo(id:DateTime.now().millisecondsSinceEpoch.toString(), details: notes));
        notescontroller.clear();
      }
    });
  }

  void _tododelete(Todo todo){
    setState(() {
      todolist.remove(todo);
    });
  }

  void _todochangechek(Todo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

@override
  void initState() {
    _searchlist = todolist;
    super.initState();
  }

 void _filter(String enteredKeyword){

    List<Todo> result = [];
    if(enteredKeyword.isEmpty){
      result = todolist;
    }
    else{
      result = todolist.where((item) => (item.details ?? '').toLowerCase().contains(enteredKeyword.toLowerCase())).toList();

    }

    setState(() {
      _searchlist = result;
    });
 }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        elevation: 4,
        shadowColor: Colors.black54,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu,color: Colors.white,size: 30,),
             Text(
              "Daily Goals",  // Change this to any title from above
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
            CircleAvatar(child: Image.asset("asset/user.png"))
          ],
        ),
      ),

      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              child: TextField(
                onChanged: _filter,
                decoration: InputDecoration(
                 hintText: "Search",
                    hintStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
                    prefixIcon: Icon(Icons.search,color: Colors.black,),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)))
                ),
              ),
             ),

            Padding(
              padding: const EdgeInsets.only(right: 250,top: 20),
              child: Text(
                "All ToDos",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white, // Matches theme
                ),
              ),
            ),

           Expanded(
             child: ListView.builder(
                 itemCount: _searchlist.length,
                 itemBuilder: (context,index){
                   return TodoItem(
                     todo: _searchlist[index],
                     onDelete: () => _tododelete(_searchlist[index]),
                     onToggle: () => _todochangechek(_searchlist[index]),
                   );
                 }
             ),
           )



        ],
      ),


      bottomNavigationBar: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextField(
                      controller: notescontroller,
                      decoration: InputDecoration(
                        hintText: "Add Notes",
                          hintStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                    ),
                  ),
                ),

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: IconButton(onPressed: _addnotes, icon:Icon(Icons.add),style:IconButton.styleFrom(padding: EdgeInsets.symmetric(vertical:20,horizontal: 20),backgroundColor: Colors.black87,foregroundColor: Colors.white),),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
