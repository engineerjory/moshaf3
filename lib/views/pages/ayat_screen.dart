import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moshf_quran/models/database.dart';

class AyatScreen extends StatelessWidget {
  String sora_name;
  int id;

  AyatScreen(this.sora_name, this.id);

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
                    child: RichText(
                      locale: Locale.fromSubtags(languageCode: "ar"),
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "",
                        style: TextStyle(
                            fontFamily: "quran",
                            fontSize: 24,
                            color: Colors.black),
                        children: compineAyat(snapshot.data!),
                      ),
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
    List<InlineSpan> widgets = [];
    for (Map aya in ayat) {
      widgets.add(
        TextSpan(
            text: aya["text"],
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print(aya["text"]);
              }),
      );
      aya["ayaid"] == 0
          ? widgets.add(TextSpan(text: "\n",))
          : widgets.add(
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/AyaNumber.png"),
                      child: Text(
                          convertToArabicNumber("${aya["ayaid"]}").toString()),
                    ),
                  )),
            );
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
