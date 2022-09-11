import 'package:flutter/material.dart';

showErrorModal(BuildContext context, {String? title, String? message}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? 'Erro'),
      content: Text(message ?? ''),
    ),
  );
}
