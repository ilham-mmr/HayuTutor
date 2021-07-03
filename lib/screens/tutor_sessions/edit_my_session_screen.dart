import 'package:flutapp/mixins/tutor_session_validator.dart';
import 'package:flutapp/models/tutor_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditMySessionScreen extends StatefulWidget {
  final TutorSession tutorSession;
  EditMySessionScreen({this.tutorSession});
  @override
  _EditMySessionScreenState createState() => _EditMySessionScreenState();
}

class _EditMySessionScreenState extends State<EditMySessionScreen>
    with TutorSessionValidator {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String subject;
  String duration;
  String location;
  String price;
  String date = 'Select Date';
  String time = 'Select Time';

  DateTime sessionDate;
  TimeOfDay sessionTime;

  TutorSession tutorSession;
  @override
  void initState() {
    initDateAndTime();
    super.initState();
  }

  void initDateAndTime() {
    tutorSession = widget.tutorSession;
    List<String> theDate = tutorSession.date.split('-');
    List<String> theTime = tutorSession.time.split(':');

    sessionDate = DateTime(
        int.parse(theDate[0]), int.parse(theDate[1]), int.parse(theDate[2]));
    sessionTime =
        TimeOfDay(hour: int.parse(theTime[0]), minute: int.parse(theTime[1]));

    time = '${sessionTime.hour.toString()}:${sessionTime.minute.toString()}';
    date = date = sessionDate.toLocal().toString();
    date = date.split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Edit My Tutoring Session'),
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
                        initialValue: tutorSession.subject,
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
                        initialValue: tutorSession.duration.toString(),
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
                        initialValue: tutorSession.location,
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
                        initialValue: tutorSession.price.toString(),
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
                                  initialDate: sessionDate,
                                  firstDate: sessionDate,
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
                                initialTime: sessionTime,
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
                                  _update(context);
                                },
                                child: Text(
                                  'Update',
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

  void _update(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      TutorSession updatedTutorSession = TutorSession(
          date: date,
          duration: double.parse(duration),
          fullName: tutorSession.fullName,
          location: location,
          picture: tutorSession.picture,
          price: double.parse(price),
          sessionId: tutorSession.sessionId,
          subject: subject,
          time: time,
          tutorId: tutorSession.tutorId);

      setState(() {
        isLoading = true;
      });
      bool isUpdated =
          await Provider.of<TutorSessionProvider>(context, listen: false)
              .updateTutorSession(updatedTutorSession);
      setState(() {
        isLoading = false;
      });
      if (!isUpdated) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update tutor session')));
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully updated a tutor session')));
      Navigator.of(context).pop();
    }
  }
}
