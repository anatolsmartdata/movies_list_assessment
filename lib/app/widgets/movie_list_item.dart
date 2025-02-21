import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_explorer/app/navigation/path_strings.dart';

import '../infrastrucutre/models/movie_item_dto.dart';

class MovieListItem extends StatelessWidget {

  final int? index;
  final MovieItemDto? movieItem;

  const MovieListItem({
    super.key,
    this.index,
    this.movieItem
  });

  bool get isEmpty => movieItem?.Poster == 'N/A';

  renderDecorationImage() {
    if (!isEmpty) {
      return DecorationImage(
        image: NetworkImage(movieItem?.Poster ?? ''),
        fit: BoxFit.cover
      );
    }
    return null;
  }

  renderEmptyIcon() {
    if (isEmpty) {
      return Icon(
        Icons.movie_creation_outlined,
        color: Colors.white
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    BorderSide borderLine = BorderSide(width: 0.5, color: Colors.black87);
    double imageSide = MediaQuery.sizeOf(context).width * .15;
    bool isEmpty = movieItem?.Poster == 'N/A';
    return InkWell(
      onTap: () {
        context.push('/movie-details/${movieItem?.imdbID}');
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: borderLine,
              bottom: borderLine
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  if (index != null) ...[
                    Text(index.toString())
                  ],
                  Container(
                      width: imageSide,
                      height: imageSide,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(imageSide / 2),
                          color: isEmpty ? Colors.grey : Colors.transparent,
                          image: renderDecorationImage()
                      ),
                      child: renderEmptyIcon()
                  ),
                  Flexible(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(movieItem?.Title ?? '', maxLines: 2)
                    ),
                  ),
                ],
              ),
            ),
            Icon(
                Icons.arrow_right,
                color: Colors.black54
            )
          ],
        ),
      ),
    );
  }
}