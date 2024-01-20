import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ManifestUpload extends StatefulWidget {
  const ManifestUpload({
    Key? key,
    required this.studentId,
    required this.weekNumber,
  }) : super(key: key);

  final String studentId;
  final String weekNumber;
  @override
  State<ManifestUpload> createState() => _ManifestUploadState();
}

class _ManifestUploadState extends State<ManifestUpload> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  List<String> options = ['Added', 'Not Added'];
  String? selectedProgress, selectedFeedback, reviewStatus = 'Task Incomplete';
  TextEditingController advisorController = TextEditingController();
  TextEditingController reviewerController = TextEditingController();
  TextEditingController typingClubController = TextEditingController();
  TextEditingController seminarController = TextEditingController();
  TextEditingController practicalController = TextEditingController();
  TextEditingController theoryController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController pendingTopicsController = TextEditingController();
  TextEditingController reviewNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadExistingData();
  }

  void loadExistingData() async {
    try {
      DocumentSnapshot weekSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.studentId)
          .collection('weeks')
          .doc(widget.weekNumber)
          .get();

      if (weekSnapshot.exists) {
        Map<String, dynamic>? data =
            weekSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            reviewNameController.text = data['reviewName']?.toString() ?? '';
            advisorController.text = data['advisorName']?.toString() ?? '';
            reviewerController.text = data['reviewerName']?.toString() ?? '';
            selectedDate = data['reviewDate'] != null
                ? (data['reviewDate'] is Timestamp
                    ? (data['reviewDate'] as Timestamp).toDate()
                    : DateTime.parse(data['reviewDate'].toString()))
                : null;
            selectedProgress = data['progress']?.toString() ?? '';
            selectedFeedback = data['feedback']?.toString() ?? '';
            reviewStatus =
                data['reviewstatus']?.toString() ?? 'Task Incomplete';
            pendingTopicsController.text =
                data['pendingTopics']?.toString() ?? '';
            practicalController.text = data['practicalMark']?.toString() ?? '';
            theoryController.text = data['theoryMark']?.toString() ?? '';
            totalController.text = data['totalMark']?.toString() ?? '';
            seminarController.text = data['seminar']?.toString() ?? '';
            typingClubController.text = data['typingClub']?.toString() ?? '';
          });
        }
      }
    } catch (e) {
      print('Error loading week data: $e');
    }
  }

  Widget buildTextField(String label, String validatorText,
      TextEditingController controller, TextInputType keyboardType) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.poppins().fontFamily),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
        style: TextStyle(
            color: Colors.black,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontSize: 18),
        validator: (value) => value?.isEmpty ?? true ? validatorText : null,
      ),
    );
  }

  Widget buildDropdownButton(String? value, Function(String?) onChanged,
      List<String> items, String labelText) {
    // Add a default value to the list to handle the case where value is null
    if (value != null && !items.contains(value)) {
      items.insert(0, value);
    }

    return Expanded(
      child: SizedBox(
        height: 50,
        child: DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily),
                  ),
                ),
              )
              .toList(),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
                color: Colors.black,
                fontFamily: GoogleFonts.poppins().fontFamily),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
          ),
          style: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.poppins().fontFamily),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }

  Widget buildDateSelector() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() => selectedDate = pickedDate);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedDate != null
                    ? DateFormat('EEEE, dd MMM yyyy').format(selectedDate!)
                    : 'Review Date',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 13,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 100),
                child: Icon(Icons.calendar_today_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Manifest Update',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 20, bottom: 10),
                  child: Row(
                    children: [
                      buildTextField('Week Name :', 'Please enter week Name :',
                          reviewNameController, TextInputType.text),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      buildTextField(
                          'Advisor Name:',
                          'Please enter Advisor Name',
                          advisorController,
                          TextInputType.text),
                      const SizedBox(width: 10),
                      buildTextField(
                          'Reviewer Name',
                          'Please enter a Reviewer Name',
                          reviewerController,
                          TextInputType.text),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                buildDateSelector(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                    children: [
                      buildTextField(
                          'TypingClub :',
                          'Please enter Typingclubscore',
                          typingClubController,
                          TextInputType.number),
                      const SizedBox(width: 10),
                      buildDropdownButton(
                          selectedProgress,
                          (value) => setState(() => selectedProgress = value),
                          options,
                          'Progress:')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                    children: [
                      buildTextField(
                          'Seminar topic',
                          'Please enter seminar score',
                          seminarController,
                          TextInputType.text),
                      const SizedBox(width: 10),
                      buildDropdownButton(
                          selectedFeedback,
                          (value) => setState(() => selectedFeedback = value),
                          options,
                          'FeedBack :'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                    children: [
                      buildTextField(
                          'Practical mark',
                          'Please enter Practical mark :',
                          practicalController,
                          TextInputType.number),
                      const SizedBox(width: 10),
                      buildTextField(
                          'Theory mark',
                          'Please enter theory mark :',
                          theoryController,
                          TextInputType.number),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                    children: [
                      buildTextField(
                          'Total mark ;',
                          'Please enter total mark :',
                          totalController,
                          TextInputType.number),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, right: 0),
                ),
                Row(
                  children: [
                    buildRadio('Task complete', Colors.green),
                    buildRadio('Task Incomplete', Colors.red),
                  ],
                ),
                Row(
                  children: [
                    buildRadio('Need Improvement', Colors.yellow),
                    buildRadio('Week Repeat', Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    buildRadio('Task Critical', Colors.orange),
                    
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, right: 200),
                  child: Text(
                    'Pending Topics',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: buildMultilineTextField(
                      'pending topics', pendingTopicsController),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 50),
                  child: Container(
                    width: isSmallScreen ? 280 : 380,
                    height: isSmallScreen ? 50 : 60,
                    padding: EdgeInsets.all(isSmallScreen ? 5 : 10),
                    margin: EdgeInsets.only(top: isSmallScreen ? 5 : 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF090B0B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        savingResult();
                        print('saving'); // Add parenthesse to invoke the method
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF090B0B),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 14 : 16,
                          color: Colors.white,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadio(String value, Color activeColor) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: reviewStatus,
          onChanged: (value) => setState(() => reviewStatus = value),
          activeColor: activeColor,
        ),
        Text(value, style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget buildMultilineTextField(
      String label, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      style: TextStyle(
          color: Colors.black, fontFamily: GoogleFonts.poppins().fontFamily),
      maxLines: 3,
      controller: controller,
    );
  }

  void savingResult() async {
    if ((_formKey.currentState?.validate() ?? false)) {
      print('going to save');
      String advisorName = advisorController.text;
      String reviewerName = reviewerController.text;
      String typingClub = typingClubController.text;
      String seminarTopic = seminarController.text;
      String pendingTopics = pendingTopicsController.text;
      String reviewName = reviewNameController.text;
      Timestamp reviewDate = selectedDate != null
          ? Timestamp.fromDate(selectedDate!)
          : Timestamp.now();

      // Save data to Firestore
      await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.studentId)
          .collection('weeks')
          .doc(widget.weekNumber)
          .set({
        'reviewName': reviewName,
        'advisorName': advisorName,
        'reviewerName': reviewerName,
        'reviewDate': reviewDate, // Store as Timestamp
        'typingClub': typingClub,
        'progress': selectedProgress ?? '',
        'seminar': seminarTopic,
        'feedback': selectedFeedback ?? '',
        'practicalMark': practicalController.text,
        'theoryMark': theoryController.text,
        'totalMark': totalController.text,
        'pendingTopics': pendingTopics,
        'reviewstatus': reviewStatus,
      });

      // Optionally, you can show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully')),
      );
      Navigator.pop(context);
    }
  }
}
