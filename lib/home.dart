import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
  
class _HomePageState extends State<HomePage> {
  @override
  List<String> tasks = List.generate(0, (index)=> 'Item $index');  // initialising an empty list of string to store the tasks
  String inputText = "";
  // int count = 0;
  final TextEditingController taskController = TextEditingController();
  int selectedIndex = -1;
  @override
  void dispose(){
    taskController.dispose();
    super.dispose();
  }

  void update(){ // should add new task instead of modifying existing value
    setState(() {
      inputText = taskController.text;
      // tasks[count-1]=inputText;  // overwrites the existing item
      if(inputText.isNotEmpty){
        tasks.add(inputText);
      }
      taskController.clear(); // will clear the TextField on clicking the save button
    });
  }
  void deleteTile(int index){
    setState(() {
      tasks.removeAt(index);
    });
  }
  void update2(){
    String newtask = taskController.text;
    tasks[selectedIndex]=newtask;
    taskController.clear();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("TODO APP",style: TextStyle(color: Colors.orange,fontStyle:FontStyle.italic),),backgroundColor: Colors.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),),
      backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.orange),
                  controller: taskController,
                  decoration:InputDecoration(hintText: "Add Task",hintStyle: TextStyle(color: Colors.orange),focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.orange),borderRadius: BorderRadius.circular(15)),),
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(onPressed: 
                  (){
                    setState(() {
                      // count += 1;
                      update();
                    });
                  }, 
                  style: OutlinedButton.styleFrom(backgroundColor:const Color.fromARGB(255, 255, 225, 1)),
                  child:const Text("Add Task",style: TextStyle(fontWeight: FontWeight.bold),)),
                  // SizedBox(width: 10,),
                  OutlinedButton(onPressed: 
                  (){
                    setState(() {
                      // count += 1;
                      update2();
                      selectedIndex=-1;
                    });
                  }, 
                  style: OutlinedButton.styleFrom(backgroundColor: Color.fromARGB(255, 255, 225, 1)),
                  child:const Text("Update Task",style: TextStyle(fontWeight: FontWeight.bold),)),
                ],
              ),
              const SizedBox(height: 10,),
              ListView.builder(
                physics:const ScrollPhysics(parent: null),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  minVerticalPadding: 3,
                  shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                  title: Text(tasks[index]),
                  subtitle: Text(tasks[index]),
                  tileColor: index.isEven ?const Color.fromARGB(255, 156, 255, 64) : Colors.orange,
                  leading: IconButton(onPressed: (){
                    taskController.text = tasks[index];
                      setState(() {
                        // tasks[index] = taskController.text;
                        selectedIndex = index;
                      });
                  }, icon:const Icon(Icons.edit)),
                  trailing: IconButton(onPressed: ()=>deleteTile(index), icon: Icon(Icons.delete)),
                ),
              ) ;
                    },
                    itemCount: tasks.length,  // Important point
                  ),
            ],
          ),
        ));
  }
}
