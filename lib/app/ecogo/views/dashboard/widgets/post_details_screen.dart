import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const PostDetailScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
  }) : super(key: key);

  String adjustImageStylesForDevice(String htmlContent, double deviceWidth) {
    return htmlContent.replaceAllMapped(
      RegExp(r'<img[^>]*style="[^"]*"[^>]*>', caseSensitive: false),
          (match) {
        String tag = match.group(0) ?? '';

        // Extraer el atributo style
        final styleMatch =
        RegExp(r'style="([^"]*)"', caseSensitive: false).firstMatch(tag);
        String styleContent = styleMatch?.group(1) ?? '';

        // Ajustar los estilos: ancho dinámico y alto fijo con ajuste proporcional
        styleContent = styleContent
            .replaceAll(
            RegExp(r'height:\s?[^;]+;?', caseSensitive: false), 'height: 200px;')
            .replaceAll(
            RegExp(r'width:\s?[^;]+;?', caseSensitive: false),
            'width: ${deviceWidth - 40}px;')
            .replaceAll(
            RegExp(r'object-fit:\s?[^;]+;?', caseSensitive: false), '')
            .trim();

        // Agregar object-fit al estilo
        styleContent += ' object-fit: cover;';

        // Reemplazar el atributo style en la etiqueta
        return tag.replaceFirst(
          RegExp(r'style="[^"]*"'),
          'style="$styleContent"',
        );
      },
    );
  }

  Future<void> _openLink(String? url) async {
    await launchUrl(Uri.parse(url!), mode: LaunchMode.inAppBrowserView);
  }

  void printFullLog(String text) {
    const int chunkSize = 800; // Número de caracteres por chunk
    for (int i = 0; i < text.length; i += chunkSize) {
      final end = (i + chunkSize < text.length) ? i + chunkSize : text.length;
      debugPrint(text.substring(i, end));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Adjust the HTML content to ensure all images have width: 100%
    final adjustedDescription =
    adjustImageStylesForDevice(description, MediaQuery.of(context).size.width);

    printFullLog(adjustedDescription);

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            if (image.isNotEmpty)
              Image.network(
                image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Html(
                data: adjustedDescription,
                style: {
                  "body": Style(
                    fontSize: FontSize(16),
                    lineHeight: const LineHeight(1.5),
                  ),
                },
                onLinkTap: (url, attributes, element) {
                  _openLink(url);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
