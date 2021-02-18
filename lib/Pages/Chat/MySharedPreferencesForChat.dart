import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferencesForChat {
  MySharedPreferencesForChat._privateConstructor();

  static final MySharedPreferencesForChat instance =
  MySharedPreferencesForChat._privateConstructor();

  setCount(String id, List<String> value) async {
    //key = chatID  ,  value=mesaggeCount
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(id, value);
  }

  Future<List<String>> getCount(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList(key) ?? null;

  }
  bool containsKey(String key)  {
    print("contisss = ");

    SharedPreferences.getInstance().then((myPrefs) {

       return myPrefs.containsKey(key)??false;
     });


  }

  Future<void> deleteCount(String key) async {

    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    myPrefs.remove(key);
    myPrefs.reload();
    myPrefs.remove(key);
    myPrefs.reload();
  }
}
