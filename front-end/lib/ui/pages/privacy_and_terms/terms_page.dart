import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:thien_nguyen_app/configs/assets/app_docs.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Điều khoản sử dụng", style: AppTypology.titleSmall),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString(AppDocs.terms),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: MarkdownBody(
                  data: snapshot.data.toString(),
                  styleSheet: MarkdownStyleSheet.fromTheme(context.appTheme),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}