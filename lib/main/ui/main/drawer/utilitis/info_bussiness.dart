import 'package:bitel_ventas/main/networks/model/user_model.dart';

class InfoBusiness{
    UserModel user = UserModel();
    static InfoBusiness? _mInstance;
    static InfoBusiness? getInstance() {
      _mInstance ??= InfoBusiness();
      return _mInstance;
    }


    void setUser(UserModel model){
      user = model;
    }

    UserModel getUser(){
      return user;
    }

}