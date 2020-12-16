import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/ilkekran.dart';
import 'firebase.dart';
import 'detay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'sepet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class goster extends StatefulWidget {
  String docal;
  var t;
  var kullanici;

  goster({this.t, this.docal,this.kullanici});

  @override
  _gosterState createState() => _gosterState();
}
FirebaseAuth _auth=FirebaseAuth.instance;

final FirebaseFirestore _firestore= FirebaseFirestore.instance;
class _gosterState extends State<goster> with SingleTickerProviderStateMixin{
  ProgressDialog progressDialog;
  TabController cont;
  @override
  void initstate(){
  cont=TabController(length: 3, vsync: this);

  }


  Future<Null> refresh() async{
    await Future.delayed(Duration(seconds: 2));
}
  @override
  Widget build(BuildContext context) {

    progressDialog=ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'Yükleniyor...');
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.data == null) return CircularProgressIndicator();
          return DefaultTabController(
            length: 3,  // Added
            initialIndex: 1,
            child: Scaffold(


              appBar: AppBar(
              automaticallyImplyLeading: false,
                title: Center(
                  child: Text(
                    "Kira'La",
                    style: GoogleFonts.comfortaa(fontSize: 25,color: Colors.blueGrey,),
                  ),
                ),
                bottom: TabBar(
                  controller: cont,
                  tabs: [
                    Tab(icon: Icon(Icons.add,color: Colors.blueGrey,), ),
                    Tab(icon: Icon(Icons.home_filled,color: Colors.blueGrey,),),

                    Tab(
                      icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.blueGrey,),


                    ),
                  ],
                ),
                elevation: 10,
                backgroundColor: Colors.white,
                ),
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                if(_auth.currentUser!=null){
                  _auth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>kullanici()));
                  Toast.show("Çıkış Yaptınız", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM );
                }
                },
                backgroundColor: Colors.blueGrey.withOpacity(0.7),
                child: Icon(Icons.remove_circle_outline),
              ),
              body:

               TabBarView(
                 controller: cont,
                 children:[
                   verigonder(),
                   RefreshIndicator(
                     onRefresh: refresh,
                     child: ListView(

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


                                                IconButton(icon: Icon(Icons.add_shopping_cart_outlined), onPressed: (){

                                                  sepet(doc['kullanici'],doc['ad'], widget.docal, doc['resim'], doc['aciklama'], doc['lokasyon'], doc['fiyat']);
                                                 Toast.show("Ürün Sepete Eklendi", context, duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);


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
                      ).toList()),
                   ),
                    sepetim(),


                   ]
               ),
            ),
          );
        });
  }


  void sepet(String kulad,String ad,String doc, var res, String aciklama,String lokasyon, String fiyat) async{
    try{

      Map<String, dynamic> aktar= Map();
      aktar['kullanici']=kulad;
      aktar['ad']=ad;
      aktar['resim']=res;
      aktar['aciklama']=aciklama;
      aktar['lokasyon']=lokasyon;
      aktar['fiyat']=fiyat;

      await _firestore.collection("sepet").doc().set(aktar, SetOptions(merge: true));

    }
    catch(e){
      debugPrint(e);

    }
  }
}