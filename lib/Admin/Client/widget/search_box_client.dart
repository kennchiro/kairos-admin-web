
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_firebase/Admin/Client/widget/search_client.dart';
import 'package:web_firebase/Widgets/colors.dart';

class SearchDelegateClient extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      InkWell(
        // onTap: () {
        //   Route route = MaterialPageRoute(builder: (_) => SearchClient());
        //   Navigator.push(context, route);
        // },
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [AppColors.WHITE, AppColors.WHITE],
              ),
            ),
            child: InkWell(
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: BoxDecoration(
                  color: AppColors.SHADOW,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Rechercher...",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 2.0),
                      child: Container(
                         width: 45,
                         height: 45,
                        child: Material(
                          elevation: 5.0,
                           borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
