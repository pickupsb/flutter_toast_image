import 'package:flutter/material.dart';
enum GRAVITY{
  TOP,
  BOTTOM,
  CENTER
}
class ImageToast {
  static double opacity = 0.0;
  static int second=2;
  static void show(
      {@required BuildContext context,

        @required Widget child,@required int second,GRAVITY gravity}) {
    if(second!=null){
      ImageToast.second=second;
    }

    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
          top: gravity1(gravity, context),
          child: new Material(
            child: AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(microseconds: 3000),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[child],
                  ),
                )),
          ));
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(overlayEntry);
    //两秒后，移除ImageToast

    new Future.delayed(Duration(seconds: ImageToast.second)).then((value) {
      overlayEntry.remove();
    });
  }

 static double gravity1(GRAVITY gravity,BuildContext context){
         if(gravity==GRAVITY.TOP){
           return MediaQuery.of(context).size.height*0.2;
         }
         if(gravity==GRAVITY.CENTER){
           return MediaQuery.of(context).size.height*0.5;
         }
         if(gravity==GRAVITY.BOTTOM){
           return MediaQuery.of(context).size.height*0.7;
         }
         return MediaQuery.of(context).size.height*0.5;
  }
}
