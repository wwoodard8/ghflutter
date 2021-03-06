class Member {
  final String title;
  final String bookname;

  Member(this.title, this.bookname) {
    if (title == null) {
      throw ArgumentError("title of Member cannot be null. "
          "Received: '$title'");
    }
    if (bookname == null) {
      throw ArgumentError("bookname of Member cannot be null. "
          "Received: '$bookname'");
    }
  }
}
