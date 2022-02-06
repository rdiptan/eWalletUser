// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this, file_names

class TransactionDetails {
  String? sId;
  From? from;
  To? to;
  int? amount;
  String? category;
  String? reason;
  bool? debit;
  bool? credit;
  String? transferredAt;
  int? iV;

  TransactionDetails(
      {this.sId,
      this.from,
      this.to,
      this.amount,
      this.category,
      this.reason,
      this.debit,
      this.credit,
      this.transferredAt,
      this.iV});

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    from = json['from'] != null ? new From.fromJson(json['from']) : null;
    to = json['to'] != null ? new To.fromJson(json['to']) : null;
    amount = json['amount'];
    category = json['category'];
    reason = json['reason'];
    debit = json['debit'];
    credit = json['credit'];
    transferredAt = json['transferred_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.from != null) {
      data['from'] = this.from!.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to!.toJson();
    }
    data['amount'] = this.amount;
    data['category'] = this.category;
    data['reason'] = this.reason;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    data['transferred_at'] = this.transferredAt;
    data['__v'] = this.iV;
    return data;
  }
}

class From {
  String? sId;
  String? fname;
  String? lname;
  String? email;
  String? password;
  bool? isAdmin;
  bool? isActive;
  String? createdAt;
  int? iV;
  String? image;

  From(
      {this.sId,
      this.fname,
      this.lname,
      this.email,
      this.password,
      this.isAdmin,
      this.isActive,
      this.createdAt,
      this.iV,
      this.image});

  From.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    iV = json['__v'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_admin'] = this.isAdmin;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    data['image'] = this.image;
    return data;
  }
}

class To {
  String? sId;
  String? fname;
  String? lname;
  String? email;
  String? password;
  bool? isAdmin;
  bool? isActive;
  String? createdAt;
  int? iV;

  To(
      {this.sId,
      this.fname,
      this.lname,
      this.email,
      this.password,
      this.isAdmin,
      this.isActive,
      this.createdAt,
      this.iV});

  To.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    password = json['password'];
    isAdmin = json['is_admin'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['is_admin'] = this.isAdmin;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
