// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';

// Create an MQTT client
// MqttServerClient client = MqttServerClient('your-mqtt-broker-url', 'your-client-id');

// // Set up event handlers for the client
// client.onConnected = onConnected;
// client.onDisconnected = onDisconnected;
// client.onSubscribed = onSubscribed;
// client.onUnsubscribed = onUnsubscribed;
// client.onSubscribeFail = onSubscribeFail;

// // Connect to the MQTT broker
// client.connect('your-username', 'your-password');

// // Define event handler functions
// void onConnected() {
//   print('Connected to MQTT broker');
// }

// void onDisconnected() {
//   print('Disconnected from MQTT broker');
// }

// void onSubscribed(String topic) {
//   print('Subscribed to topic: $topic');
// }

// void onUnsubscribed(String topic) {
//   print('Unsubscribed from topic: $topic');
// }

// void onSubscribeFail(String topic) {
//   print('Failed to subscribe to topic: $topic');
// }