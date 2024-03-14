import 'package:dbu_gym/models/exercise.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class SearchPage extends SearchDelegate {
  List<Exercise> exercises;

  SearchPage({required this.exercises});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_new, size: 22),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Exercise> searchResults = this
        .exercises
        .where((element) =>
            (element.name).toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: searchResults.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) => Card(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Theme.of(context).colorScheme.background.darken(3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Text(
            searchResults[index].name.length > 25
                ? searchResults[index].name.substring(0, 26) + "..."
                : searchResults[index].name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: searchResults[index].level == 'beginner'
                  ? Colors.greenAccent.shade400.withOpacity(0.6)
                  : searchResults[index].level == 'expert'
                      ? Colors.redAccent.darken(10)
                      : Colors.yellowAccent.shade700.darken(5),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Text(
              searchResults[index].level.capitalize,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          onTap: () {
            close(context, searchResults[index]);
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Exercise> searchResults = this
        .exercises
        .where((element) =>
            (element.name).toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: searchResults.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      itemBuilder: (context, index) => Card(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Theme.of(context).colorScheme.background.darken(3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: ListTile(
          leading: Text(
            searchResults[index].name.length > 25
                ? searchResults[index].name.substring(0, 26) + "..."
                : searchResults[index].name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: searchResults[index].level == 'beginner'
                      ? Colors.greenAccent.shade400.withOpacity(0.6)
                      : searchResults[index].level == 'expert'
                          ? Colors.redAccent.darken(10)
                          : Colors.yellowAccent.shade700.darken(5),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Text(
                  searchResults[index].level.capitalize,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                searchResults[index].category.capitalize,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(10),
          onTap: () {
            close(context, searchResults[index]);
          },
        ),
      ),
    );
  }
}
