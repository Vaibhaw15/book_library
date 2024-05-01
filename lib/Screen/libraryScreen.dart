import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../libraryModel/libraryModels.dart';
import 'libraryCubit.dart';
import 'libraryState.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  TextEditingController searchController = TextEditingController();
  List<ReadingLogEntries>? data;
  List<bool> isRead = [];
  bool _isSearching = false;


  @override
  void initState() {
    // TODO: implement initState
    final cubit = context.read<LibraryCubit>();
    super.initState();
    cubit.loadBooks();
    //_loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title:  _isSearching ? _buildSearchField() : Text('Library',style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            actions: _buildAppBarActions(),
          ),
          body:_createBody(),
        ),
      ),
    );
  }

  Widget _createBody() {
    return BlocConsumer<LibraryCubit, LibraryState>(
        builder: (ctx, state) {
          if (state is LibraryInitialState) {
            debugPrint("initial state");
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LibraryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LibraryLoadedState) {
            return bodyWidget(context, state);
          }
          return const Center(
            child: Text("No results found"),
          );
        }, listener: (context, state) {
      if (state is LibraryInitialState) {}
      if (state is LibraryLoadingState) {}
      if (state is LibraryLoadedState) {}
    });
  }

  Widget bodyWidget(BuildContext context,
      LibraryLoadedState state){
    final cubit = context.read<LibraryCubit>();
    return  Container(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        itemCount: state.data!.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(width: 0.5, color: Colors.blue)
              ),
              //  leading: const Icon((Icons.category)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.network("https://covers.openlibrary.org/b/id/${state.data![index].work!.coverId}-M.jpg",
                          fit: BoxFit.fitWidth,
                          height: MediaQuery.of(context).size.width * 0.33,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(child: Text(
                            "${state.data![index].work!.title} - ${state.data![index].work!.authorNames} ",
                            textAlign:TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          )),
                          SizedBox(height: 5,),
                          Text(
                            "Published year - ${state.data![index].work!.firstPublishYear} ",
                            textAlign:TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5,),
                          ElevatedButton(
                            onPressed: () {
                              cubit.toggleStatus(index);
                            },
                            child: Text(state.isRead[index] ? 'Read' : 'Unread'),
                            style: ElevatedButton.styleFrom(
                              primary: state.isRead[index] ? Colors.green : Colors.transparent,
                              onPrimary: state.isRead[index] ? Colors.white : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
            mainAxisExtent: 320
        ),
      ),
    );

  }


  Widget _buildSearchField() {
    final cubit = context.read<LibraryCubit>();
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      onChanged: (value) {
        cubit.search(value.trim().toLowerCase());
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    final cubit = context.read<LibraryCubit>();
    if (_isSearching) {
      return [
        IconButton(
          icon: Icon(Icons.cancel,color: Colors.black,),
          onPressed: () {
            setState(() {
              _isSearching = false;
              cubit.clear();
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search,color: Colors.black),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }
}
