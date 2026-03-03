import 'package:flutter/material.dart';

class TweetEditScreen extends StatefulWidget {
  const TweetEditScreen({super.key});

  @override
  TweetEditScreenState createState() => TweetEditScreenState();
}

class TweetEditScreenState extends State<TweetEditScreen> {
  final TextEditingController _controller = TextEditingController();
  static const int maxTweetLength = 280;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Tweet'),
        actions: [
          TextButton(
            onPressed: () {
              // Tweet submission logic goes here
              if (_controller.text.isNotEmpty) {
                print('Tweet: ${_controller.text}');
              }
            },
            child: const Text(
              'Tweet',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    child: Icon(Icons.person_outline),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLength: maxTweetLength,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "What's happening?",
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_camera),
                    onPressed: () {
                      // Image picker logic goes here
                    },
                  ),
                  Text(
                    '${maxTweetLength - _controller.text.length}',
                    style: TextStyle(
                      color: _controller.text.length > maxTweetLength
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
