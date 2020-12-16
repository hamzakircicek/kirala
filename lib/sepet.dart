import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
class sepetim extends StatefulWidget {



  @override
  _sepetimState createState() => _sepetimState();
}

final FirebaseFirestore _firestore= FirebaseFirestore.instance;
class _sepetimState extends State<sepetim> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('sepet').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.data == null) return CircularProgressIndicator();
          return Scaffold(


            body: ListView(

                children:

                snapshot.data.docs
                    .map((doc) => Container(
                  color: Colors.white,
                  child:
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15,right: 5,left: 5),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                  BorderRadius.circular(40),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(doc['kullanici']),
                                    Text("Tarih"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 195,
                              ),
                              IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {


                                  })
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Stack(
                                children:[ Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 170,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            doc['resim'],
                                          ),
                                          fit: BoxFit.cover,
                                        )),
                                  ),

                                ),

                                ]
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                height: 150,

                                child: ListView(



                                  children: [

                                    Text("Ürün Adı: ",
                                      style: GoogleFonts.alata(fontSize:15, color: Colors.grey),),
                                    Text(doc['ad'], style: GoogleFonts.alata(fontSize:15)),

                                    SizedBox(height: 10,),
                                    Text("Lokasyon: ",
                                      style: GoogleFonts.alata(fontSize:15, color: Colors.grey),),
                                    Text(doc['lokasyon'], style: GoogleFonts.alata(fontSize:15)),

                                    SizedBox(height: 10,),
                                    Text("Fiyat: ",
                                      style: GoogleFonts.alata(fontSize:15, color: Colors.grey),),
                                    Text(doc['fiyat'], style: GoogleFonts.alata(fontSize:15)),

                                    SizedBox(height: 10,),
                                    Text("Açıklama: ",
                                      style: GoogleFonts.alata(fontSize:15, color: Colors.grey),),
                                    Text(doc['aciklama'], style: GoogleFonts.alata(fontSize:15))




                                  ],
                                ),
                              ),
                            ),


                          ]),
                          SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.all(15),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(

                                  onTap: ()async { await _firestore.collection('sepet').doc(doc.id).delete();
                                  Toast.show("Ürün Sepetten Kaldırıldı", context, duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);

                                  },

                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.red.withOpacity(0.7),
                                      ),
                                      child: Icon(Icons.delete,color: Colors.white,size: 20,),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.green.withOpacity(0.7),
                                    ),
                                    child: Icon(Icons.arrow_forward_ios, color: Colors.white,size: 20,),
                                  ),
                                ),
                              ],
                            ),
                          )




                        ]),
                      ),


                    ),


                  ),


                ),
                )
                    .toList()),
          );
        });
  }
}