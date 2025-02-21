import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_explorer/app/infrastrucutre/bloc/details-bloc/details_bloc.dart';
import 'package:movies_explorer/app/infrastrucutre/models/models.dart';

import '../infrastrucutre/models/rating_dto.dart';

class MovieDetails extends StatefulWidget {

  final String imdbID;

  const MovieDetails({super.key, required this.imdbID});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late MovieDetailsDto movieDetails;

  MovieDetailsBloc get detailsBloc => context.read<MovieDetailsBloc>();

  @override
  void initState() {
    fetchMovieDetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchMovieDetails() async {
    detailsBloc.add(FetchMovieDetails(widget.imdbID));
  }

  renderRatings(List<RatingDto>? ratingList) {
    if (ratingList != null) {
      if (ratingList.isNotEmpty) {
        return ratingList.map((RatingDto ratingElement) {
          return circularProgressFor(progress: ratingElement.Value?.replaceFirst("%","/100"), text: ratingElement.Source);
        });
      }
    }
  }

  Widget circularProgressFor({String? progress, String? text}) {
    var val = progress!.split('/')[0];
    var total = progress.split('/')[1];
    int percentage = double.tryParse(val)?.toInt() ?? 0;
    int totalPercentage = double.tryParse(total)?.toInt() ?? 0;
    double totalSize = MediaQuery.sizeOf(context).width - 24 - 60;
    var value = percentage / totalPercentage;
    var size = totalSize / 3;
    String metaCritic = 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Metacritic_logo_original.svg/1200px-Metacritic_logo_original.svg.png';
    String rotLogo = 'https://static.wikia.nocookie.net/jhmovie/images/6/6f/Rotten_Tomatoes_logo.svg/revision/latest/scale-to-width-down/691?cb=20211201133613';
    String imdbLogo = 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/IMDB_Logo_2016.svg/2560px-IMDB_Logo_2016.svg.png';

    text ??= '$percentage%';

    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey.withValues(alpha: .3),
              strokeWidth: 8,
              color: text.contains('Rotten') ? Colors.red : text.contains('Metacritic') ? Colors.blue : Color.fromRGBO(245, 197, 24, 1),
              value: value,
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              Image.network(width: size/2, height: size/2,text.contains('Rotten') ? rotLogo : text.contains('Metacritic') ? metaCritic : imdbLogo, fit: BoxFit.contain,),
              Text(progress)
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (BuildContext context, MovieDetailsState state) {
          String title = state is MovieDetailsFetched ? state.movieDetails.Title : '';
          double contentWidth = MediaQuery.sizeOf(context).width - 24;
          double labelWidth = MediaQuery.sizeOf(context).width * .2;
          double valWidth = contentWidth - labelWidth;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              elevation: 1,
              centerTitle: false,
              leading: InkWell(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              leadingWidth: 40,
              title: Padding(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, color: Colors.white),),
              )
            ),
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: state is MovieDetailsLoading ?
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator()
                  ],
                ) : state is MovieDetailsException ?
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Error to fetch movie!')
                  ],
                ) : state is MovieDetailsFetched ?
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width - 24,
                      height: MediaQuery.sizeOf(context).width - 24,
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: state.movieDetails.Poster! == 'N/A' ? null : DecorationImage(image: NetworkImage(state.movieDetails.Poster!), fit: BoxFit.cover)
                      ),
                      child: state.movieDetails.Poster! == 'N/A' ? Container(
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.movie_creation_outlined, color: Colors.white, size: 150,),
                      ) : null,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...renderRatings(state.movieDetails.Ratings)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20, left: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (contentWidth-3) / 2,
                            decoration: BoxDecoration(
                                border: Border(left: BorderSide(width: .5))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Year: ', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)),
                                Text(state.movieDetails.Year, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                              ],
                            ),
                          ),
                          Container(
                            width: (contentWidth-3)/2,
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(width: .5), left: BorderSide(width: .5))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Country: ', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey)),
                                Text(state.movieDetails.Country ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: labelWidth,
                            child: Text('Genre: ', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black.withValues(alpha: .8), height: 0.6)),
                          ),
                          SizedBox(
                            width: valWidth,
                            child: Text(state.movieDetails.Genre ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: labelWidth,
                            child: Text('Director: ', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black.withValues(alpha: .8), height: 0.6)),
                          ),
                          SizedBox(
                            width: valWidth,
                            child: Text(state.movieDetails.Director ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: labelWidth,
                            child: Text('Writer: ', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black.withValues(alpha: .8), height: 0.6)),
                          ),
                          SizedBox(
                            width: valWidth,
                            child: Text(state.movieDetails.Writer ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: labelWidth,
                            child: Text('Duration: ', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black.withValues(alpha: .8), height: 0.6)),
                          ),
                          SizedBox(
                            width: valWidth,
                            child: Text(state.movieDetails.Runtime ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: labelWidth,
                            child: Text('Language: ', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black.withValues(alpha: .8), height: 0.6)),
                          ),
                          SizedBox(
                            width: valWidth,
                            child: Text(state.movieDetails.Language ?? '', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                          ),
                        ],
                      ),
                    ),
                    ToggleBox(title: 'Description',content: state.movieDetails.Plot ?? ''),
                    ToggleBox(title: 'Actors',content: state.movieDetails.Actors ?? ''),
                    ToggleBox(title: 'Awards',content: state.movieDetails.Awards ?? ''),
                  ]
                ) :
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              )
            ),
          );
        }
    );
  }
}

class ToggleBox extends StatefulWidget {
  final String title;
  final String content;
  final TextStyle? contentStyle;
  final bool isOpen;
  final Function()? toggleBox;
  const ToggleBox({
    super.key,
    this.title = '',
    this.content = '',
    this.isOpen = true,
    this.contentStyle,
    this.toggleBox
  });

  @override
  State<ToggleBox> createState() => _ToggleBox();
}

class _ToggleBox extends State<ToggleBox> {
  bool isOpen = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  toggleBox() => setState(() => isOpen = !isOpen);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: .6, color: Colors.grey.withAlpha(100))
      ),
      child: Column(
        children: [
          Material(
            elevation: 1.8,
            shadowColor: Colors.grey.withValues(alpha: 0.4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(isOpen ? 0 : 8),
              bottomRight: Radius.circular(isOpen ? 0 : 8),
            ),
            child: InkWell(
              onTap: toggleBox,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFfbf1de).withAlpha(180),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(isOpen ? 0 : 8),
                    bottomRight: Radius.circular(isOpen ? 0 : 8),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title),
                      Icon(isOpen ? Icons.arrow_drop_down : Icons.arrow_right, color: Colors.black54,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isOpen) ...[
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFfbf1de).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Text(
                  widget.content,
                  style: widget.contentStyle ?? TextStyle(fontSize: 14, color: Colors.black.withAlpha(180)),),
              ),
            )
          ]
        ],
      ),
    );
  }
}