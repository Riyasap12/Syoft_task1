class ImageAssets {
  static ImageAssets? singleInstance;

  static ImageAssets getSingleton() {
    singleInstance ??= ImageAssets();
    return singleInstance ?? ImageAssets();
  }

  String logo = "assets/images/logo.png";

  String walkAround1 = "assets/images/w1.png";
  String walkAround2 = "assets/images/w2.png";
  String walkAround3 = "assets/images/w3.png";
  String wBack = "assets/images/wBack.png";
}

class IconAssets {
  static IconAssets? singleInstance;

  static IconAssets getSingleton() {
    singleInstance ??= IconAssets();
    return singleInstance ?? IconAssets();
  }

  String google = "assets/icons/google.svg";
  String facebook = "assets/icons/facebook.svg";
  String info = "assets/icons/info.svg";
  String error = "assets/icons/error.svg";
  String success = "assets/icons/success.svg";
}
