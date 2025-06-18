enum StreamOperation {
  insert,
  delete,
  update;

  bool get isInsert => this == StreamOperation.insert;
  bool get isDelete => this == StreamOperation.delete;
  bool get isUpdate => this == StreamOperation.update;
}
