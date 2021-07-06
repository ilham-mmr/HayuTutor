class Payment {
  String orderId;
  String email;
  double amount;
  String status;
  String subject;
  String tutorEmail;
  String tutorName;
  String date;

  Payment(
      {this.orderId,
      this.email,
      this.amount,
      this.status,
      this.subject,
      this.tutorEmail,
      this.tutorName,
      this.date});

  Payment.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    email = json['email'];
    amount = json['paid'].toDouble();
    status = json['status'];
    subject = json['subject'];
    tutorEmail = json['tutorEmail'];
    tutorName = json['tutorName'];
    date = json['date'];
  }
}
