class Member {
  final String title;
  final String patchURL;
  final String bookname;

  Member(this.title, this.patchURL, this.bookname) {
    if (title == null) {
      throw ArgumentError("title of Member cannot be null. "
          "Received: '$title'");
    }
    if (patchURL == null) {
      throw ArgumentError("patchURL of Member cannot be null. "
          "Received: '$patchURL'");
    }
    if (bookname == null) {
      throw ArgumentError("bookname of Member cannot be null. "
          "Received: '$bookname'");
    }
  }
}
