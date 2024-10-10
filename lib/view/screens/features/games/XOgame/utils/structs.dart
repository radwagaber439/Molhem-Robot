import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box(
      {super.key, required this.i, required this.used, required this.onTap});

  final int i;
  final List<String> used;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(i),
      child: Container(
        color: Colors.black26,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(used[i],
              style: const TextStyle(fontSize: 50, color: Colors.white)),
        ),
      ),
    );
  }
}

class RestartButton extends StatelessWidget {
  const RestartButton({super.key, required this.press});
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: ElevatedButton(onPressed: press, child: const Text("Restart")),
    );
  }
}
