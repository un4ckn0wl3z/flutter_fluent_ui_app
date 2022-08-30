import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_fluent_ui_app/models/article.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsItem extends StatelessWidget {
  final Article article;
  const NewsItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    return Card(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: Container(
              width: double.infinity,
              height: 180,
              color: material.Colors.grey.shade700,
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  imageErrorBuilder: ((context, error, stackTrace) {
                    return Icon(
                      material.Icons.image,
                      color: material.Colors.grey.shade300,
                    );
                  }),
                  fit: BoxFit.cover,
                  image: article.urlToImage ?? ''),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              child: Text(
                article.title,
                style: typography.bodyLarge?.apply(fontSizeFactor: 1),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 8,
              left: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    article.source,
                    style: typography.caption?.apply(fontSizeFactor: 1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropDownButton(
                  title: const Icon(FluentIcons.share),
                  items: [
                    MenuFlyoutItem(
                      text: const Text('Open in Browser'),
                      leading: const Icon(FluentIcons.edge_logo),
                      onPressed: () {},
                    ),
                    MenuFlyoutItem(
                      text: const Text('Send'),
                      leading: const Icon(FluentIcons.send),
                      onPressed: () {},
                    ),
                    MenuFlyoutItem(
                      text: const Text('Copy URL'),
                      leading: const Icon(FluentIcons.copy),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
