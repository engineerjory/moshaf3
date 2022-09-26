import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moshf_quran/models/database.dart';


class Ayat2 extends StatelessWidget {
  String sora_name;
  int id;

  Ayat2(this.sora_name, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sora_name),
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "assets/quran_frame2.png",
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 80),
          child: FutureBuilder(
            future: QuranDB.retrieveAyat(id),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Wrap(
                      spacing: 3,
                      children: compineAyat(snapshot.data!),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ]),
    );
  }





  compineAyat(List ayat) {
    List<Widget> widgets = [];
    for (int i = 0; i < ayat.length; i++) {
      if (i == 0) {
        widgets.add(Center(
            child: Text(
          "${ayat[i]["text"]}",
          style: TextStyle(fontFamily: "quran", fontSize: 18),
        )));
      } else {
        ayat[i]["text"].toString().split(" ").forEach((element) {
          widgets.add(Text(
            element,
            style: TextStyle(fontFamily: "quran", fontSize: 20),
          ));
        });
        widgets.add(Container(
          alignment: Alignment.center,
          width: 25,
          height: 25,
          child: Text(
            "${convertToArabicNumber(
              "${ayat[i]["ayaid"]}",
            ).toString()}",
          ),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/AyaNumber.png")),
          ),
        ));
      }
    }

    return widgets;
  }

  String convertToArabicNumber(String number) {
    String res = '';

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    number.characters.forEach((element) {
      res += arabics[int.parse(element)];
    });

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
    return res;
  }
}
