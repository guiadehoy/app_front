import 'package:app_scanner/models/event_response.dart';
import 'package:app_scanner/store/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'login_form.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _LoginStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  EventResponse? eventSelected;

  @observable
  String devideId = "";

  @observable
  int countScanned = 0;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setDeviceId(String value) {
    devideId = value;
  }

  @action
  void setCountScanned(int value) {
    countScanned = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setEventSelected(EventResponse value) {
    eventSelected = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "El correo no puede ser vacío";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Por favor ingresa un correo valido';
    } else {
      formErrorStore.userEmail = "";
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "La contraseña no puede ser vacía";
    } else if (value.length < 8) {
      formErrorStore.password = "La contraseña debe tener más de 8 caracteres";
    } else {
      formErrorStore.password = "";
    }
  }

  @action
  Future login() async {
    loading = false;
    success = true;
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    success = false;
    loading = false;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String userEmail = "";

  @observable
  String password = "";

  @computed
  bool get hasErrorsInLogin => userEmail != "" || password != "";
}
