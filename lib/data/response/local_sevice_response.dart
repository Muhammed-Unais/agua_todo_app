import 'package:agua_todo_app/data/response/enums.dart';

class LocalServiceResponse<T> {
  Status? status;
  T? data;
  String? message;

  LocalServiceResponse(this.data, this.message, this.status);

  LocalServiceResponse.error(this.message) : status = Status.error;

  LocalServiceResponse.completed(this.data) : status = Status.completed;

  LocalServiceResponse.loading() : status = Status.loading;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}
