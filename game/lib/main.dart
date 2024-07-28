import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(PuzzleGame());

class PuzzleGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Puzzle Game',
      home: PuzzleHome(),
    );
  }
}

class PuzzleHome extends StatefulWidget {
  @override
  _PuzzleHomeState createState() => _PuzzleHomeState();
}

class _PuzzleHomeState extends State<PuzzleHome> {
  late List<int> _tiles;
  late int _emptyTileIndex;

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
  }

  void _initializePuzzle() {
    _tiles = List.generate(9, (index) => index);
    _tiles.shuffle();
    _emptyTileIndex = _tiles.indexOf(8);
  }

  void _swapTiles(int index) {
    setState(() {
      _tiles[_emptyTileIndex] = _tiles[index];
      _tiles[index] = 8;
      _emptyTileIndex = index;
    });
  }

  bool _isAdjacent(int index) {
    int row = index ~/ 3;
    int col = index % 3;
    int emptyRow = _emptyTileIndex ~/ 3;
    int emptyCol = _emptyTileIndex % 3;
    return (row == emptyRow && (col - emptyCol).abs() == 1) ||
           (col == emptyCol && (row - emptyRow).abs() == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Puzzle Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                if (_tiles[index] == 8) {
                  return Container(
                    color: Colors.grey,
                  );
                }
                return GestureDetector(
                  onTap: () {
                    if (_isAdjacent(index)) {
                      _swapTiles(index);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(4.0),
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        '${_tiles[index] + 1}',
                        style: TextStyle(fontSize: 32.0, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _initializePuzzle,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
