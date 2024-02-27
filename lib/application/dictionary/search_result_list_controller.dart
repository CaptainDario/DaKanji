import 'package:da_kanji_mobile/widgets/dictionary/search_result_list.dart';


/// Controller class that can be used to trigger events in regards to a
/// [SearchResultList]
class SearchResultListController {

  /// Runs the slide in animation of the [SearchResultList] associated with this
  /// [SearchResultListController]
  Function() runSlideInAnimation;


  SearchResultListController({
    required this.runSlideInAnimation
  });

}