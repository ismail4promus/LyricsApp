import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lyrics_provider.dart';
import '../widgets/lyric_card.dart';

class LyricsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lyrics List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Lyrics',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (query) => context.read<LyricsProvider>().filterLyrics(query),
            ),
          ),
          Expanded(
            child: Consumer<LyricsProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.filteredLyricsList.length,
                  itemBuilder: (context, index) {
                    return LyricCard(lyric: provider.filteredLyricsList[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
