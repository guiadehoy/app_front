import 'package:mobx/mobx.dart';

part 'login_form.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    print("_LoginStore");
  }

  @observable
  String email = 'juanpereze@example.do';

  @observable
  String name = 'Juan Perez';

  @observable
  String profile = 'https://www.gravatar.com/avatar?d=mp';

  @observable
  bool logged = false;

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setLogged(bool value) {
    logged = value;
  }

  @action
  void setProfile(String value) {
    profile = value;
  }
}
