import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PeerTextSyncProvider with ChangeNotifier {
  String _text = '';
  String _clipboardText = ''; // Variable to hold clipboard text
  late RawDatagramSocket _socket;
  final String broadcastAddress = '255.255.255.255';
  final int port = 9876;

  String get text => _text;

    String get clipboardText => _clipboardText;

  void copyToClipboard() {
    _clipboardText = _text;
  }

  set text(String value) {
    _text = value;
    print('Text updated to: $_text');
    _saveTextToLocalStorage(_text);
    notifyListeners();
    broadcastText(_text); // Broadcast updated text to peers
  }

  Future<void> initialize() async {
    print('Initializing PeerTextSyncProvider...');
    await startListening();
  }

  Future<void> startListening() async {
    try {
      _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
      _socket.broadcastEnabled = true;

      print('Listening on UDP port $port...');

      _socket.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          final datagram = _socket.receive();
          if (datagram != null) {
            final receivedText = utf8.decode(datagram.data);
            print('Received Text: $receivedText');
            if (receivedText.isNotEmpty && receivedText != _text) {
              _text = receivedText;
              _saveTextToLocalStorage(_text);
              notifyListeners();
            }
          }
        }
      });
    } catch (e) {
      print('Failed to start listening: $e');
    }
  }

  Future<void> broadcastText(String text) async {
    if (_socket == null) {
      print('Socket not initialized.');
      return;
    }
    try {
      final data = utf8.encode(text);
      _socket.send(data, InternetAddress(broadcastAddress), port);
      print('Broadcasting Text: $text');
    } catch (e) {
      print('Failed to broadcast text: $e');
    }
  }

  Future<void> _saveTextToLocalStorage(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('m3uurl', text);
    print('Saved text to local storage: $text');
  }

  Future<void> clearTextOnExit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('m3uurl');
    broadcastText(''); // Broadcast empty text to clear others.
    print('Cleared text on exit.');
  }

  void dispose() {
    _socket.close();
    print('PeerTextSyncProvider disposed.');
    super.dispose();
  }
}


// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PeerTextSyncProvider with ChangeNotifier {
//   String _text = '';
//   late RawDatagramSocket _socket;
//   final String broadcastAddress = '255.255.255.255';
//   final int port = 9876;

//   String get text => _text;

//   set text(String value) {
//     _text = value;
//     print('Text updated to: $_text');
//     _saveTextToLocalStorage(_text);
//     notifyListeners();
//     broadcastText(_text); // Broadcast updated text to peers
//   }

//   Future<void> initialize() async {
//     print('Initializing PeerTextSyncProvider...');
//     await startListening();
//   }

//   Future<void> startListening() async {
//     try {
//       _socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
//       _socket.broadcastEnabled = true;

//       print('Listening on UDP port $port...');

//       _socket.listen((RawSocketEvent event) {
//         if (event == RawSocketEvent.read) {
//           final datagram = _socket.receive();
//           if (datagram != null) {
//             final receivedText = utf8.decode(datagram.data);
//             print('Received Text: $receivedText');
//             if (receivedText.isNotEmpty && receivedText != _text) {
//               _text = receivedText;
//               _saveTextToLocalStorage(_text);
//               notifyListeners();
//             }
//           }
//         }
//       });
//     } catch (e) {
//       print('Failed to start listening: $e');
//     }
//   }

//   Future<void> broadcastText(String text) async {
//     if (_socket == null) {
//       print('Socket not initialized.');
//       return;
//     }
//     try {
//       final data = utf8.encode(text);
//       _socket.send(data, InternetAddress(broadcastAddress), port);
//       print('Broadcasting Text: $text');
//     } catch (e) {
//       print('Failed to broadcast text: $e');
//     }
//   }

//   Future<void> _saveTextToLocalStorage(String text) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('m3uurl', text);
//     print('Saved text to local storage: $text');
//   }

//   Future<void> clearTextOnExit() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('m3uurl');
//     broadcastText(''); // Broadcast empty text to clear others.
//     print('Cleared text on exit.');
//   }

//   void dispose() {
//     _socket.close();
//     print('PeerTextSyncProvider disposed.');
//     super.dispose();
//   }
// }
