class Validators {
  
  static final RegExp _fullNNameRegExp = RegExp(
    r'^[a-z A-Z,.\-]+$',
  );
//+37498998899
  static final RegExp _phoneRegExp = RegExp(
    r'(^\+374(?:[0-9] ?){7,10}[0-9]$)',//r'(^(?:[+0]9)?[0-9]{9,12}$)',
  );
  
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidFullName(String fullName) {
    return _fullNNameRegExp.hasMatch(fullName);
  }

  static isValidPhone(String phone) {
    return _phoneRegExp.hasMatch(phone);
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return true;//_passwordRegExp.hasMatch(password);
  }

  static isValidLegalName(String legalName) {
    return _fullNNameRegExp.hasMatch(legalName);
  }

  static isValidTaxCode(String taxCode) {
    return _fullNNameRegExp.hasMatch(taxCode);
  }

  static isValidLegalAddress(String legalAddress) {
    return _fullNNameRegExp.hasMatch(legalAddress);
  }

  static isValidSdn(String sdn) {
    return _fullNNameRegExp.hasMatch(sdn);
  }
}