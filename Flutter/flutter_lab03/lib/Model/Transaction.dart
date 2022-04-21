class Transaction{
  final String name;
  final String date;
  final double mount;
  final int img;
  final int status;

  Transaction(this.name, this.date, this.mount, this.img, this.status);

  set status(int value) {
    status = value;
  }

  set img(int value) {
    img = value;
  }

  set mount(double value) {
    mount = value;
  }

  set date(String value) {
    date = value;
  }

  set name(String value) {
    name = value;
  }
}