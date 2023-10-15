class MaterialDialogContent {
  final String title;
  final String message;
  final String positiveText;
  final String negativeText;

  MaterialDialogContent(
      {required this.title, required this.message, this.positiveText = 'Try Again', this.negativeText = 'Cancel'});

  MaterialDialogContent.networkError()
      : this(
            title: 'Limited Network Connection',
            message:
                'Uh..oh… We\'re unable proceed, its seems like your internet connection is broke or maybe limited. Please check it and try again.');

  @override
  String toString() {
    return 'MaterialDialogContent{title: $title, message: $message, positiveText: $positiveText, negativeText: $negativeText}';
  }
}
