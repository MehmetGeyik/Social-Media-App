import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/sayfalar/akis.dart';
import 'package:social_media_app/sayfalar/ara.dart';
import 'package:social_media_app/sayfalar/duyurular.dart';
import 'package:social_media_app/sayfalar/profil.dart';
import 'package:social_media_app/sayfalar/yukle.dart';
import 'package:social_media_app/servisler/yetkilendirmeservisi.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _aktifSayfaNo = 0;
  PageController sayfaKumandasi;

  @override
  void initState() { 
    super.initState();
    sayfaKumandasi = PageController();
  }

  @override
  void dispose() { 
    sayfaKumandasi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String aktifKullaniciId = Provider.of<YetkilendirmeServisi>(context, listen: false).aktifKullaniciId;
    
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (acilanSayfaNo){
          setState(() {
            _aktifSayfaNo = acilanSayfaNo;
          });
        },
        controller: sayfaKumandasi,
        children: <Widget>[
          Akis(),
          Ara(),
          Yukle(),
          Duyurular(),
          Profil(profilSahibiId: aktifKullaniciId,)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _aktifSayfaNo,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Akış"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Keşfet"),
          BottomNavigationBarItem(icon: Icon(Icons.file_upload), label: "Yükle"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Duyurular"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        onTap: (secilenSayfaNo){
          setState(() {
            sayfaKumandasi.jumpToPage(secilenSayfaNo);
          });
        },
        ),
    );
  }
}