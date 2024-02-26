import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/posts/posts_bloc.dart';
import 'package:instagram_clone/features/presentation/widgets/LOADING.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';
import '../../../../core/constants.dart';
import '../../../../core/dependency_injection.dart';
import '../../bloc/home/home_bloc.dart';

class SearchScreen extends StatefulWidget {
  final UserEntity currentUser;
  const SearchScreen({super.key, required this.currentUser});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        title: "Search",
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  context.read<HomeBloc>().add(GetAllUsersEvent());
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        currentUser: widget.currentUser,
                        userBloc: sl<HomeBloc>()),
                  );
                } catch (e) {
                  rethrow;
                }
              },
              icon: const Icon(
                Icons.search,
                color: Constants.primaryColor,
              )),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
            if (state is PostsLoaded) {
              return Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // go to detailed post screen
                          Navigator.pushNamed(
                              context, RouteNames.detailedPostScreen,
                              arguments: {
                                "currentUser": widget.currentUser,
                                "postEntity": state.posts[index],
                              });
                        },
                        child: SizedBox(
                          height: mediaHeight(context, 0.07),
                          width: mediaWidth(context, 0.01),
                          child: Image.network(
                            state.posts[index].postImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final UserEntity currentUser;
  final Bloc<HomeEvent, HomeState> userBloc;
  CustomSearchDelegate({required this.userBloc, required this.currentUser});
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor:
            Constants.backGroundColor, // Set your desired background color
        foregroundColor: Colors.red, // Set your desired text// color
        iconTheme:
            IconThemeData(color: Colors.white), // Set your desired icon color
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle:
            TextStyle(color: Colors.white), // Set color for the typed text
        helperStyle: TextStyle(color: Colors.white),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: const TextStyle(
                color: Colors.white), // Set color for the typed text
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Constants.primaryColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserEntity> users = [];
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: query == ""
          ? Container()
          : BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const LOADING();
                }
                if (state is HomeLoaded) {
                  for (int i = 0; i < state.usersList.length; i++) {
                    if (!(state.usersList[i].username!
                            .toLowerCase()
                            .contains(currentUser.username!.toLowerCase())) &&
                        !(state.usersList[i].username!
                            .toLowerCase()
                            .startsWith(currentUser.username!.toLowerCase())) &&
                        ((query.isNotEmpty &&
                                state.usersList[i].username!
                                    .toLowerCase()
                                    .contains(query.toLowerCase())) ||
                            (query.isNotEmpty &&
                                state.usersList[i].username!
                                    .toLowerCase()
                                    .startsWith(query.toLowerCase())))) {
                      users.add(state.usersList[i]);
                    }
                  }
                  return users.isEmpty
                      ? const Center(
                          child: Text(
                          "no results..",
                          style: TextStyle(color: Colors.white),
                        ))
                      : ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      RouteNames.otherUsersProfileScreen,
                                      arguments: {
                                        "currentUser": currentUser,
                                        "targetUser": users[index],
                                      });
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: mediaHeight(context, 0.03),
                                      backgroundImage: NetworkImage(
                                          users[index].profileUrl!),
                                    ),
                                    sizeHor(mediaWidth(context, 0.02)),
                                    Text(users[index].username!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium)
                                  ],
                                ),
                              ),
                            );
                          });
                }
                return const Center(
                    child: Text(
                  "no results..",
                  style: TextStyle(color: Colors.white),
                ));
              },
            ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print(state.usersList);
    List<UserEntity> usersss = [];
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: query == ""
          ? Container()
          : BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  for (int i = 0; i < state.usersList.length; i++) {
                    if (!(state.usersList[i].username!
                            .toLowerCase()
                            .contains(currentUser.username!.toLowerCase())) &&
                        !(state.usersList[i].username!
                            .toLowerCase()
                            .startsWith(currentUser.username!.toLowerCase())) &&
                        ((query.isNotEmpty && state.usersList[i].username!.toLowerCase().contains(query.toLowerCase())) || (query.isNotEmpty && state.usersList[i].username!.toLowerCase().startsWith(query.toLowerCase())))
                    )
                    {
                      usersss.add(state.usersList[i]);
                    }
                  }
                  return ListView.builder(
                      itemCount: usersss.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.otherUsersProfileScreen,
                                  arguments: {
                                    "currentUser": currentUser,
                                    "targetUser": usersss[index],
                                  });
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: mediaHeight(context, 0.03),
                                  backgroundImage:
                                      NetworkImage(usersss[index].profileUrl!),
                                ),
                                sizeHor(mediaWidth(context, 0.02)),
                                Text(usersss[index].username!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium)
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Container();
              },
            ),
    );
  }
}
