import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:thien_nguyen_app/configs/app_docs.dart';
import 'package:thien_nguyen_app/theme/theme.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chính sách bảo mật", style: AppTypology.titleSmall),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString(AppDocs.policy),
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