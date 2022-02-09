import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prabandhak/helpers/network/api_helper.dart';
import 'package:prabandhak/helpers/snackbar_helper.dart';
import 'package:prabandhak/models/user.dart';
import 'package:prabandhak/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CreateSession extends StatefulWidget {
  const CreateSession({Key? key}) : super(key: key);

  @override
  State<CreateSession> createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  String name = '';
  String startTime = DateTime.now().toString(),
      endTime = DateTime.now().toString();
  int price =
      0; //Right now price is zero for every event in further updates we can let the user charge an amount for this.
  late List<String> speaker;

  int ticketSold = 0;
  int totalTickets = 50; //By default this value is 50 user can change it.
  String description = 'This is description';
  int topic = 1;
  File? image;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    speaker = [user.uID];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Create new Session'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  GestureDetector(
                    child: ClipRRect(
                      child: image == null
                          ? Image.asset('assets/wow-such-empty.jpg')
                          : Image.file(image!),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onTap: pickImage,
                  ),
                  TextFormField(
                    decoration: decoration('Topic'),
                    initialValue: name,
                    onFieldSubmitted: (value) => TextInputAction.next,
                    validator: (value) => value == null || value.isEmpty
                        ? 'This field is required'
                        : null,
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    fieldLabelText: 'Start Time',
                    onChanged: (val) => startTime = val,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'choose valid time.';
                      return null;
                    },
                    onSaved: (val) => print(val),
                    onFieldSubmitted: (value) => TextInputAction.next,
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    fieldLabelText: 'End time',
                    onChanged: (val) => endTime = val,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'choose valid time.';
                      return null;
                    },
                    onSaved: (val) => print(val),
                    onFieldSubmitted: (value) => TextInputAction.next,
                  ),
                  TextFormField(
                    onFieldSubmitted: (value) => TextInputAction.next,
                    maxLines: 1,
                    decoration: decoration('Tickets available'),
                    keyboardType: TextInputType.number,
                    initialValue: totalTickets.toString(),
                    validator: (value) => value != null && value.isNotEmpty
                        ? (int.parse(value) <= 0
                            ? 'Tickets cannot be less than or equal to 0.'
                            : null)
                        : 'This field can not be empty.',
                    onChanged: (value) => totalTickets = int.parse(value),
                  ),
                  TextFormField(
                    maxLines: 8,
                    decoration: decoration('Description'),
                    keyboardType: TextInputType.multiline,
                    initialValue: '',
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : 'This field can not be empty.',
                    onChanged: (value) => description = value,
                  ),
                  ElevatedButton(
                    onPressed: () => submitForm(),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    try {
      var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      setState(() {
        this.image = File(image.path);
      });
    } catch (_) {
      return;
    }
  }

  submitForm() async {
    Map<String, dynamic> map = {
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'price': price.toString(),
      'speakers': speaker.toString(),
      'ticketsSold': ticketSold.toString(),
      'totalTickets': totalTickets.toString(),
      'description': description,
      'topic': topic.toString(),
      'image': await MultipartFile.fromPath('image', image!.path,
              filename: image!.path.split('/').last)
          .toString(),
    };
    print(map);
    bool result = await ApiHelper.createNewSession(map) ?? false;

    if (result) {
      Navigator.pop(context);
      showMessageSnackBar(context, 'Session created successfully');
      return;
    }
    showMessageSnackBar(context, 'Something went wrong. Please try again');
  }

  InputDecoration decoration(String label) => InputDecoration(
        label: Text(
          label,
        ),
      );
}
