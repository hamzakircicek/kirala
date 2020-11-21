import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'verilerigoster.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class verigonder extends StatefulWidget {


  @override
  _verigonderState createState() => _verigonderState();
}

class _verigonderState extends State<verigonder> {
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  File _secilenresim;
  File _kameradanresim;
  TextEditingController txt= new TextEditingController();
  TextEditingController txt2= new TextEditingController();
  TextEditingController txt3= new TextEditingController();
  TextEditingController txt4= new TextEditingController();
  TextEditingController txt5= new TextEditingController();
  var url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [Container(
          margin: EdgeInsets.all(50),
        height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Column(
            children: [
              TextField(
                controller: txt,
                decoration: InputDecoration(
                    hintText: "Ürün Adı gir"
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: txt2,
                decoration: InputDecoration(
                    hintText: "Döküment Adı Gir"
                ),
              ),
              SizedBox(height: 20,),











              TextField(
                controller: txt4,
                decoration: InputDecoration(
                    hintText: "İl/İlçe"
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: txt5,
                decoration: InputDecoration(
                    hintText: "Günlük Kiralama Ücreti"
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: txt3,
                maxLines: 3,
                maxLength: 200,
                decoration: InputDecoration(
                    hintText: "Ürün Açıklaması"
                ),
              ),

              InkWell(
                onTap: (){
                  veriekle(txt.text,txt2.text, url, txt3.text,txt4.text, txt5.text);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> goster(t: url, docal: txt2.text,)));

                },
                child:

                Text("Veriyi Gönder"),
              ),
              //////////////////////////////////////////////////////////////////


              SizedBox(height: 50,),
              Row(
                children :[ InkWell(
                  onTap:
                  (){
                    galeriden(txt3.text);
                  }
                  ,
                  child: Container(
                    width: 150,
                    height: 150,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,

                    ),
                    child: Center(child: _secilenresim==null ? Text("Lütfen Galeriden Resim Seçin") : Image.file(_secilenresim, )),
                  ),

                ),

              SizedBox(width: 10,),
              InkWell(
                onTap:
                    (){
                  kameradan(txt3.text);
                }
                ,
                child: Container(
                  width: 150,
                  height: 150,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,

                  ),
                  child: Center(child: _kameradanresim==null ? Text("Lütfen Kameradan Resim Seçin") : Image.file(_kameradanresim, )),
                ),

              ),

                ]
              ),

            ],
          ),
        ),
    ]
      ),
    );
  }
  void veriekle (String ad,String doc, var res, String aciklama,String lokasyon, String fiyat) async{
     try{
      Map<String, dynamic> hamza= Map();
      hamza['ad']=ad;
      hamza['resim']=res;
      hamza['aciklama']=aciklama;
      hamza['lokasyon']=lokasyon;
      hamza['fiyat']=fiyat;

      await _firestore.collection("users").doc(doc).set(hamza, SetOptions(merge: true));
    }
    catch(e){
      debugPrint(e);

    }
    

  }


  void kameradan(String foto)async{
  var reesim= await ImagePicker.pickImage(source: ImageSource.camera);
  setState(() {
    _kameradanresim=reesim;
  });
  Reference ref=FirebaseStorage.instance.ref().child("user").child(foto);
  UploadTask uploadTask= ref.putFile(_secilenresim);
  var r = await (await uploadTask).ref.getDownloadURL() ;

  debugPrint("Urlmizzzzzzzzzzzzzzzz:"+r);
  url=r;
  }


  void galeriden(String foto) async{
    var resimm= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _secilenresim=resimm;
    });

    Reference ref=FirebaseStorage.instance.ref().child("user").child(foto);
    UploadTask uploadTask= ref.putFile(_secilenresim);
   var r = await (await uploadTask).ref.getDownloadURL() ;

    debugPrint("Urlmizzzzzzzzzzzzzzzz:"+r);
    url=r;


  }


}


