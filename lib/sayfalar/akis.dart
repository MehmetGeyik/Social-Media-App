import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/modeller/gonderi.dart';
import 'package:social_media_app/modeller/kullanici.dart';
import 'package:social_media_app/servisler/firestoreservisi.dart';
import 'package:social_media_app/servisler/yetkilendirmeservisi.dart';
import 'package:social_media_app/widgetlar/gonderikarti.dart';
import 'package:social_media_app/widgetlar/silinmeyenFutureBuilder.dart';

class Akis extends StatefulWidget {
  @override
  _AkisState createState() => _AkisState();
}

class _AkisState extends State<Akis> {
  List<Gonderi> _gonderiler = [];
  
  _akisGonderileriniGetir() async {
    String aktifKullaniciId = Provider.of<YetkilendirmeServisi>(context, listen: false).aktifKullaniciId;

    List<Gonderi> gonderiler = await FireStoreServisi().akisGonderileriniGetir(aktifKullaniciId);
    if (mounted) {
      setState(() {
        _gonderiler = gonderiler;
      });
    }
  }

  @override
  void initState() { 
    super.initState();
    _akisGonderileriniGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SocialApp"),
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: _gonderiler.length,
        itemBuilder: (context, index){

          Gonderi gonderi = _gonderiler[index];

          return SilinmeyenFutureBuilder(
            future: FireStoreServisi().kullaniciGetir(gonderi.yayinlayanId),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return SizedBox();
              }

              Kullanici gonderiSahibi = snapshot.data;

              return GonderiKarti(gonderi: gonderi, yayinlayan: gonderiSahibi,);
            }
            );
        }
        ),
    );
  }
}