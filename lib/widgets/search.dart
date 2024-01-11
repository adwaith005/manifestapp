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
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: _searchTextController,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: 'Search ',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
        onChanged: (value) => widget.onSearchChanged(value),
      ),
    );
  }
}