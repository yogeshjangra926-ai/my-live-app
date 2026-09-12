import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

const int yourAppID = 123456789; 
const String yourAppSign = "abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789";

final String localUserID = Random().nextInt(10000).toString();

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController liveIDController = TextEditingController(text: "room_101");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Stream App"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your User ID: $localUserID", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: liveIDController,
              decoration: const InputDecoration(
                labelText: "Live Room ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LivePage(
                            liveID: liveIDController.text.trim(),
                            isHost: true,
                          ),
                        ),
                      );
                    },
                    child: const Text("Go Live (Host)", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LivePage(
                            liveID: liveIDController.text.trim(),
                            isHost: false,
                          ),
                        ),
                      );
                    },
                    child: const Text("Watch (Viewer)", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({
    super.key,
    required this.liveID,
    required this.isHost,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: yourAppID,
        appSign: yourAppSign,
        userID: localUserID,
        userName: "User_$localUserID",
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}

