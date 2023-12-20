import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  final Function(String) onSearchChanged;

  const Searchbar({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: TextField(
        style: TextStyle(color: Colors.black),
        controller: _searchTextController,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: 'Search by Batch number...',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ), // Set hint text color
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black),
            // Change the color as needed
          ),
        ),
        onChanged: (value) => widget.onSearchChanged(value),
      ),
    );
  }
}
