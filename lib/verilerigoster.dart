

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'firebase.dart';
import 'detay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'kaydedilenler.dart';

import 'sepet.dart';


class goster extends StatefulWidget {
  String docal;
  var t;

  goster({this.t, this.docal});

  @override
  _gosterState createState() => _gosterState();
}
final FirebaseFirestore _firestore= FirebaseFirestore.instance;
class _gosterState extends State<goster> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.data == null) return CircularProgressIndicator();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Kira'La",
                style: GoogleFonts.oxanium(fontSize: 25),
              ),
              elevation: 0,
              backgroundColor: Colors.brown.shade400,
            actions: [ IconButton(icon: Icon(Icons.search), onPressed: (){}),],),

            body: ListView(

                children: snapshot.data.docs
                    .map((doc) => Container(
                          color: Colors.white,
                          child:
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>dty(url: doc['resim'],)));
                                },
                                child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  child: Container(
                                    margin: EdgeInsets.all(15),
                                    height: 350,
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
                                                Text("Kullanıcı Adı"),
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
                                        Material(
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: 200,
                                            height: 200,
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
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            height: 200,

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
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 0.5,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: 30,

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [

                                          Container(
                                            child: Row(
                                      children: [
                                      IconButton(icon: Icon(Icons.add_alert_outlined), onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>kaydedilen()));

                                                aktarma(doc['ad'], widget.docal, doc['resim'], doc['aciklama'], doc['lokasyon'], doc['fiyat']);


                                            }),

                                          SizedBox(width: 10,),
                                          IconButton(icon: Icon(Icons.add_shopping_cart_outlined), onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>sepetim()));
                                            sepet(doc['ad'], widget.docal, doc['resim'], doc['aciklama'], doc['lokasyon'], doc['fiyat']);
                                          }),
                                  ]
                                ),
                                      ),
                                          Container(
                                            child: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){

                                            }),
                                          )
                                        ],
                                      ),
                                      ),

                                    ]),
                                  ),

                                ),

                            ),
                              ),


                        ),
                )

                    .toList()),
          );
        });
  }
  void aktarma(String ad,String doc, var res, String aciklama,String lokasyon, String fiyat) async{
    try{
      Map<String, dynamic> aktar= Map();
      aktar['ad']=ad;
      aktar['resim']=res;
      aktar['aciklama']=aciklama;
      aktar['lokasyon']=lokasyon;
      aktar['fiyat']=fiyat;

      await _firestore.collection("eklenen").doc(doc).set(aktar, SetOptions(merge: true));
    }
    catch(e){
      debugPrint(e);

    }
  }
  void sepet(String ad,String doc, var res, String aciklama,String lokasyon, String fiyat) async{
    try{
      Map<String, dynamic> aktar= Map();
      aktar['ad']=ad;
      aktar['resim']=res;
      aktar['aciklama']=aciklama;
      aktar['lokasyon']=lokasyon;
      aktar['fiyat']=fiyat;

      await _firestore.collection("sepet").doc(doc).set(aktar, SetOptions(merge: true));
    }
    catch(e){
      debugPrint(e);

    }
  }
}
