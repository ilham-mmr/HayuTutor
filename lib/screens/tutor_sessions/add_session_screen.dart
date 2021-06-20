import 'package:flutapp/mixins/tutor_session_validator.dart';
import 'package:flutapp/models/tutor_session.dart';
import 'package:flutapp/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddSessionScreen extends StatefulWidget {
  @override
  _AddSessionScreenState createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen>
    with TutorSessionValidator {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String subject;
  String duration;
  String location;
  String price;
  String date = 'Select Date';
  String time = 'Select Time';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Add Tutoring Session'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                  'assets/images/add_tutor_session.svg',
                  height: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.subject),
                          labelText: 'Subject',
                          hintText: 'English',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        validator: validateSubject,
                        onSaved: (newValue) => subject = newValue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.timelapse),
                          labelText: 'Duration',
                          hintText: 'e.g 120 (in minutes)',
                          suffixText: 'Minutes',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        validator: validateDuration,
                        onSaved: (newValue) => duration = newValue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.location_city),
                          labelText: 'Location',
                          hintText: 'e.g Zoom / House',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        validator: validateLocation,
                        onSaved: (newValue) => location = newValue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixText: 'RM',
                          labelText: 'Price',
                          hintText: ' e.g 100',
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        validator: validatePrice,
                        onSaved: (newValue) => price = newValue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$date',
                            style: date != 'Select Date'
                                ? null
                                : TextStyle(color: Colors.red),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async {
                                final DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        colorScheme:
                                            ColorScheme.light().copyWith(
                                          primary: Colors.cyan[800],
                                        ),
                                      ),
                                      child: child,
                                    );
                                  },
                                );
                                setState(() {
                                  date = picked.toLocal().toString();
                                  date = date.split(' ')[0];
                                });
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$time',
                            style: time != 'Select Time'
                                ? null
                                : TextStyle(color: Colors.red),
                          ),
                          IconButton(
                            icon: Icon(Icons.timer,
                                color: Theme.of(context).primaryColor),
                            onPressed: () async {
                              final TimeOfDay picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light().copyWith(
                                        primary: Colors.cyan[800],
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                              );
                              setState(() {
                                time =
                                    '${picked.hour.toString()}:${picked.minute.toString()}';
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      isLoading
                          ? CircularProgressIndicator()
                          : Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  _submit(context);
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    if (_formKey.currentState.validate() &&
        date != 'Select Date' &&
        time != 'Select Time') {
      _formKey.currentState.save();
      int id = UserPreferences.getId();
      print('$id,$subject, $duration, $location, $price, $date, $time');
      setState(() {
        isLoading = true;
      });
      bool isAdded =
          await Provider.of<TutorSessionProvider>(context, listen: false)
              .addTutorSession(
        userId: id,
        date: date,
        duration: duration,
        location: location,
        price: price,
        subject: subject,
        time: time,
      );
      setState(() {
        isLoading = false;
      });
      if (!isAdded) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add tutor session')));
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully added a tutor session')));
      _formKey.currentState.reset();
    }
  }
}
