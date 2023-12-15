import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_cuoikhoa/screen/product_detail_screen.dart';
import 'package:ecommerce_cuoikhoa/widgets/search_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc/search_bloc.dart';
import '../model/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    SearchBloc().add(SearchStarted());
  }

  Timer? searchOnStoppedTyping;

  _onChangeHandler(String value) {
    const duration = Duration(seconds:2); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null || value.isEmpty) {
      searchOnStoppedTyping?.cancel(); // clear timer
      BlocProvider.of<SearchBloc>(context).add(SearchCleared());
    }
    searchOnStoppedTyping = Timer(duration, () => BlocProvider.of<SearchBloc>(context).add(SearchEntered(value)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'search',
                style: Theme.of(context).textTheme.displayLarge
            ).tr(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            CupertinoSearchTextField(
              style: Theme.of(context).textTheme.headlineMedium,
              onSuffixTap: () {
                context.read<SearchBloc>().add(SearchCleared());
                searchTEC.clear();
              },
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<SearchBloc>().add(SearchCleared());
                } else {
                  _onChangeHandler(value);
                }
              },
              controller: searchTEC,
              prefixIcon: const Icon(CupertinoIcons.search),
              placeholder: 'searchField'.tr(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            BlocConsumer<SearchBloc, SearchState>(
                listener: (context, state) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ProductDetail()));
                },
                listenWhen: (previous, current) =>
                    current is SearchProductPressState,
                buildWhen: (previous, current) =>
                    current is! SearchProductPressState,
                builder: (context, stateSearch) {
                  if (stateSearch is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (stateSearch is SearchSuccess) {
                    return Expanded(
                      child: ListView.separated(
                          itemCount: stateSearch.listP.length,
                          separatorBuilder: (ctx, index) => Divider(color: Theme.of(context).colorScheme.background,),
                          itemBuilder: (ctx, index) =>
                              SearchItem(product: stateSearch.listP[index])),
                    );
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }
}
