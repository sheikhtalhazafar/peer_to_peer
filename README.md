# peer

A new Flutter project.

## Getting Started

The PeerTextSyncProvider class in Dart is a Flutter provider that manages text synchronization across peers using UDP broadcasting. It maintains a text state and clipboard text, allowing updates and broadcasts to peers. The class initializes a UDP socket to listen for incoming text updates and broadcasts text changes to a specified port. It also saves the text to local storage using SharedPreferences and clears the text on exit. The provider notifies listeners of any text changes, ensuring the UI stays updated.

To use this app on two devices, ensure both devices are connected to the same network. When you write something in the text field on one device, tap the copy icon on the other device, then tap the paste icon. The text you have written will appear in the text field on the other device.

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
