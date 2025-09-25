class ResponseClassify<T> {
  Status status;
  T? data;
  String? error;
  ResponseClassify.initial() : status = Status.INITIAL;
  ResponseClassify.loading() : status = Status.LOADING;

  ResponseClassify.completed(this.data) : status = Status.COMPLETED;

  ResponseClassify.error(this.error) : status = Status.ERROR;

  bool get isLoading => data == null && error!.isEmpty;

  @override
  String toString() {
    return "Status : $status \n Message :  \n Data : $data Error : $error";
  }
}

enum Status { INITIAL, LOADING, COMPLETED, ERROR }
