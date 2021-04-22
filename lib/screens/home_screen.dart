import 'package:flutapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        // leading: Container(),
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart_rounded), onPressed: () {}),
        ],
      ),
      drawer: Drawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Theme.of(context).accentColor,
                ),
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hello, ',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500),
                          ),
                          Consumer<User>(
                            builder: (BuildContext context, user, _) {
                              return Container(
                                child: Text(
                                  "${user.fullname.split(' ')[0]}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      "assets/images/welcome.svg",
                      height: 50,
                      width: 20,
                    ),
                  ),
                ]),
              ),
              Center(
                heightFactor: 3,
                child: SvgPicture.asset(
                  "assets/images/welcome.svg",
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
