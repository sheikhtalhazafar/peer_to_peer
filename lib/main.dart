import 'package:flutter/material.dart';
import 'package:peer/clip.dart';
import 'package:provider/provider.dart';

class PeerTextSyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peer-to-Peer Text Sync',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => PeerTextSyncProvider()..initialize(),
        child: PeerTextSyncScreen(),
      ),
    );
  }
}

class PeerTextSyncScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PeerTextSyncProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peer-to-Peer Text Sync'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _textController.clear();
              provider.text = ''; // Clear text and broadcast empty string
            },
          ),
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              // Copy the current provider text to the clipboard
              provider.copyToClipboard();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Text copied to clipboard!')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: (text) {
                      provider.text = text; // Update provider when text changes
                    },
                    decoration: InputDecoration(
                      labelText: 'Paste link here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.paste),
                  onPressed: () {
                    _textController.text = provider.clipboardText;
                    provider.text = provider.clipboardText;
                  },
                ),
              ],
            ),
     
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(PeerTextSyncApp());
}




      //  SizedBox(height: 20),
            // Expanded(
            //   child: ListView(
            //     children: [
            //       Text(
            //         'Synchronized Text:',
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       SizedBox(height: 10),
            //       Text(provider.text.isEmpty
            //           ? 'No text received yet'
            //           : provider.text),
            //     ],
            //   ),
            // ),


// import 'package:flutter/material.dart';
// import 'package:peer/clip.dart';
// import 'package:provider/provider.dart';

// class PeerTextSyncApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Peer-to-Peer Text Sync',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ChangeNotifierProvider(
//         create: (_) => PeerTextSyncProvider()..initialize(),
//         child: PeerTextSyncScreen(),
//       ),
//     );
//   }
// }

// class PeerTextSyncScreen extends StatelessWidget {
//   final TextEditingController _textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<PeerTextSyncProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Peer-to-Peer Text Sync'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.clear),
//             onPressed: () {
//               _textController.clear();
//               provider.text = ''; // Clear text and broadcast empty string
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _textController,
//               onChanged: (text) {
//                 provider.text = text; // Update provider when text changes
//               },
//               decoration: InputDecoration(
//                 labelText: 'Paste link here',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: [
//                   Text(
//                     'Synchronized Text on Other Devices:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(provider.text.isEmpty ? 'No text received yet' : provider.text),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(PeerTextSyncApp());
// }
