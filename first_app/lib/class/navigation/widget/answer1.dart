import 'package:flutter/material.dart';

class Answer1Screen extends StatelessWidget {
  const Answer1Screen({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Card'),
        backgroundColor: const Color.fromARGB(255, 74, 120, 194),
      ),
      body: Center(
        child: Card(
          child: Padding(
  
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const Icon(Icons.wb_sunny,
                        color: Color.fromARGB(255, 219, 191, 12), size: 48),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nakhon Pathom',
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      '32°C',
                      style: textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Text(
                      'H: 35°',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      '     L: 28°',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}