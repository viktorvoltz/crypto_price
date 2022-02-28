class Success{
  int? code;
  Object? response;
  
  Success({
    this.code,
    this.response
  });
}

class Failure{
  int? code;
  String? response;

  Failure({
    this.code,
    this.response,
  });
}