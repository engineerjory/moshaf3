import 'package:flutter/material.dart';
import 'package:moshf_quran/models/database.dart';
import 'ayat2.dart';

class SoraScreen extends StatefulWidget {
  const SoraScreen({Key? key}) : super(key: key);

  @override
  State<SoraScreen> createState() => _SoraScreenState();
}

class _SoraScreenState extends State<SoraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ("al sewar"),
      ),
      body: FutureBuilder(
        future: QuranDB.retrieve(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

          if(snapshot.hasData){
            return ListView.separated(
                itemBuilder: (context,index){
                  var sora = snapshot.data![index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Ayat2( sora["name"],sora["soraid"])));
                             // AyatScreen( sora["name"],sora["soraid"])));
                    },
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        title: Text("${sora["name"]}",style: TextStyle(fontFamily: "quran",fontSize: 23),),
                        subtitle: Text(sora["place"]==1?"مكيه" :"مدنية",
                          style:TextStyle(fontSize: 18,fontFamily: "quran") ,),
                        leading: sora["place"]==1? Image.asset("assets/kaba.png"):Image.asset("assets/medina.png"),
                      ),
                    ),
                  );
                },
                separatorBuilder:(context,index){
                  return Divider();
                } ,
                itemCount: snapshot.data!.length);
          }
          else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },

      ),
    );
  }
}


