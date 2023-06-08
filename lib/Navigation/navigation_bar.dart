// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import '../widgets/colors.dart';
//
// import '../History/History.dart';
// import '../Profile/ProfileVolunteer.dart';
// import '../Screens_volunteer/VolunteerDashboard.dart';
//
// class NavBar extends StatefulWidget {
//   static const id = 'navigation_bar';
//
//   @override
//   State<NavBar> createState() => _NavBarState();
// }
//
// class _NavBarState extends State<NavBar> {
//   late List<Map<String, dynamic>> _pages;
//
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     _pages = [
//       {'page': VolunteerDashboard(), 'title': 'Home'},
//       {'page': Profile(), 'title': 'Profile'},
//       {'page': History(), 'title': 'History'},
//     ];
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DrawerHeader(
//         child: null,
//       ),
//       backgroundColor: const Color(0xffF8FBFF),
//       bottomNavigationBar: CustomNavigationBar(
//         iconSize: 30.0,
//         selectedColor: ColorConstants.kPrimaryColor,
//         strokeColor: ColorConstants.kPrimaryColor,
//         unSelectedColor: Color(0xffbcbcbc),
//         backgroundColor: Colors.white,
//         items: [
//           CustomNavigationBarItem(
//             icon: Icon(Icons.home),
//             //  title: Text('Home'),
//           ),
//           CustomNavigationBarItem(
//             icon: Icon(Icons.history_outlined),
//             //  title: Text('History'),
//           ),
//           CustomNavigationBarItem(
//             icon: Icon(Icons.calculate_outlined),
//             //  title: Text('zakat calculator'),
//           ),
//           CustomNavigationBarItem(
//             icon: Icon(Icons.person_outline_outlined),
//             // title: Text('Profile'),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       body: _pages[_selectedIndex]['page'],
//     );
//   }
// }
