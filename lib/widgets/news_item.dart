import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:transparent_image/transparent_image.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key}) : super(key: key);

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
                  image:
                      'https://www.infoquest.co.th/wp-content/uploads/2022/07/20220705_canva_%E0%B8%88%E0%B8%B5%E0%B8%99%E0%B8%99%E0%B8%B2%E0%B8%8B%E0%B9%88%E0%B8%B2-1024x576.png'),
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
                'This is test message',
                style: typography.bodyLarge?.apply(fontSizeFactor: 0.8),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
