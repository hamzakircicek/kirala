import 'package:flutter/material.dart';
class dty extends StatefulWidget {
  var url;
  dty({this.url});
  @override
  _dtyState createState() => _dtyState();
}

class _dtyState extends State<dty> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[ Container(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.url),fit: BoxFit.cover,
              )
            ),

        ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.3),
          ),
          Positioned(
            top: 475,
            right: 10,
            left: 10,
            child: Container(
              width: 430,
              height: 200,
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
          Positioned(
              top: 410,
              left: 10,
              child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(15),
            ),
          ))
        ]
    );
  }
}

