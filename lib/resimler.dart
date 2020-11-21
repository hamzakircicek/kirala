import 'package:flutter/material.dart';
import 'package:flutter_app/firebase.dart';
import 'package:flutter_app/main.dart';
import 'sepet.dart';
import 'firebase.dart';
class resimac extends StatefulWidget {
  var res;
  int sayac=0;
  int listsyc=1;
  int adet=0;
  double gorunum=0.0;
  double gorunum2=0.0;
  resimac({this.res});


  @override
  _resimacState createState() => _resimacState();
}

class _resimacState extends State<resimac> {
  @override
  Widget build(BuildContext context) {
    int a=widget.sayac;

    return Scaffold(
      body: Stack(children: [
        Hero(
          tag: widget.res,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(widget.res),
                fit: BoxFit.cover,
              ))),
        ),
        Positioned(
          left: 10,
          top: 400,
          child: Center(
            child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.6)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          widget.sayac++;
                          if(widget.sayac!=0 ){
                            widget.gorunum=1.0;
                            widget.gorunum2=1.0;
                          }else{
                            widget.gorunum=0.0;
                            widget.gorunum2=0.0;
                          }


                        });
                      },
                        child: Container(
                            child: Text(
                      "Sepete Ekle",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ))),
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 30,
                    )
                  ]),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ///////////////////////////////////

        Positioned(
          top: 470,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.8)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                                image: AssetImage('assets/9.jpg'),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 250,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //////////////////////////////////////////////
                              ])),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    child: Text("Bu bir Açıklamadır"),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 350,
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>verigonder()/*sepetim(sayac2: widget.sayac, resim: widget.res,)*/));
            },
            child: Stack(
              children:[ Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(40),

                ),
                child: Center(
                  child: Icon(Icons.add_shopping_cart,size: 25, color: Colors.white,),
                )
              ),
                Positioned(
                  left: 30,
                  child: Container(

                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(

                        color: Colors.red.withOpacity(widget.gorunum),
                        borderRadius: BorderRadius.circular(40),

                      ),
                child: Center(
                  child: Text('$a', style: TextStyle(color: Colors.white.withOpacity(widget.gorunum2)),),
                ),

                  ),
                ),
            ]
            ),
          ),
        )
      ]),
    );
  }
}
