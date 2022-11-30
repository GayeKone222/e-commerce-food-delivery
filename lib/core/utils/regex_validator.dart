class RegexValidators {
  /*
  This class is used to store any function that is somehow linked
  to field validation. This is a singleton since we will use it everywhere.
  */
  static final RegexValidators _instance = RegexValidators._internal();

  static const String _emailPattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

  static const String _phonePattern =
      r'\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}$';
  static const String _namePattern =
      r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$";
  static const String _formatedDatePattern =
      r'^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$'; // dd/MM/yyyy

  factory RegexValidators() {
    return _instance;
  }

  RegexValidators._internal();

  String? validatePhoneNumber(String phone) {
    RegExp regex = RegExp(_phonePattern);
    if (!regex.hasMatch(phone)) {
      return 'Invalid phone number';
    } else {
      return null;
    }
  }

  String? validateEmailAdress(String email) {
    RegExp regex = RegExp(_emailPattern);
    if (!regex.hasMatch(email)) {
      return 'Invalid email adress';
    } else {
      return null;
    }
  }

  String? validatePassword(String password) {
    // RegExp regex = RegExp(_emailPattern);
    if (password.isEmpty || password.length < 8) {
      return 'Password should be more than 8 characters';
    } else {
      return null;
    }
  }

  String? validateName(String? name, String field) {
    RegExp regex = RegExp(_namePattern);

    if (name == null || name.isEmpty || !regex.hasMatch(name)) {
      return 'Invalid $field';
    } else {
      return null;
    }
  }

  String? validateDate(String date) {
    RegExp regex = RegExp(_formatedDatePattern);
    if (!regex.hasMatch(date)) {
      return 'Invalid date';
    } else {
      return null;
    }
  }

  String? atLeastTwoChars(String text) {
    if (text.length < 2) {
      return 'Invalid value';
    } else {
      return null;
    }
  }

  String? nullOrAtLeastTwoChars(String text) {
    if (text.length < 2 && text.isNotEmpty) {
      return 'Invalid value';
    } else {
      return null;
    }
  }
}
