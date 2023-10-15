// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../models/RoutineModel.dart';
//
// class DailyRoutineInputScreen extends StatefulWidget {
//   @override
//   _DailyRoutineInputScreenState createState() => _DailyRoutineInputScreenState();
// }
//
// class _DailyRoutineInputScreenState extends State<DailyRoutineInputScreen> {
//   final TextEditingController _routineController = TextEditingController();
//   List<DailyRoutine> routines = [];
//
//   Future<void> _saveRoutine() async {
//     final routineText = _routineController.text;
//     if (routineText.isNotEmpty) {
//       final currentDate = DateTime.now();
//       final newRoutine = DailyRoutine(date: currentDate, routine: routineText);
//
//       // Load existing routines from SharedPreferences
//       final prefs = await SharedPreferences.getInstance();
//       final encodedRoutines = prefs.getString('routines');
//       List<DailyRoutine> routines = [];
//
//       if (encodedRoutines != null) {
//         final List<dynamic> decodedRoutines = json.decode(encodedRoutines);
//         routines = decodedRoutines.map((json) => DailyRoutine.fromJson(json)).toList();
//       }
//
//       routines.add(newRoutine);
//
//       // Save the updated routines list
//       final encodedNewRoutines = json.encode(routines.map((routine) => routine.toJson()).toList());
//       prefs.setString('routines', encodedNewRoutines);
//
//       setState(() {
//         this.routines.add(newRoutine);
//         _routineController.clear();
//       });
//     }
//   }
//
//   Future<void> _loadRoutines() async {
//     final prefs = await SharedPreferences.getInstance();
//     final encodedRoutines = prefs.getString('routines');
//
//     if (encodedRoutines != null) {
//       final List<dynamic> decodedRoutines = json.decode(encodedRoutines);
//       final List<DailyRoutine> routines = decodedRoutines.map((json) => DailyRoutine.fromJson(json)).toList();
//
//       setState(() {
//         this.routines = routines;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadRoutines();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Journal'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _routineController,
//               decoration: InputDecoration(
//                 hintText: 'Enter Journal',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 _saveRoutine();
//               },
//               child: Text('Save Journal'),
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: routines.length,
//                 itemBuilder: (context, index) {
//                   final routine = routines[index];
//                   return ListTile(
//                     title: Text('${routine.date.toLocal()}'),
//                     subtitle: Text(routine.routine),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }