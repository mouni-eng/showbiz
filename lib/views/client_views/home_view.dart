import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyerdeal/constants.dart';
import 'package:flyerdeal/size_config.dart';
import 'package:flyerdeal/view_models/home_cubit/cubit.dart';
import 'package:flyerdeal/view_models/home_cubit/states.dart';
import 'package:flyerdeal/views/AuthViews/LoginViews/login_view.dart';
import 'package:flyerdeal/views/common_views/category_listing_view.dart';
import 'package:flyerdeal/views/common_views/flyer_detail_view.dart';
import 'package:flyerdeal/views/common_views/flyer_listing_view.dart';
import 'package:flyerdeal/views/common_views/search_view.dart';
import 'package:flyerdeal/widgets/cached_image.dart';
import 'package:flyerdeal/widgets/custom_button.dart';
import 'package:flyerdeal/widgets/custom_navigation.dart';
import 'package:flyerdeal/widgets/custom_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userModel == null
                          ? const NotAuthenticatedHeader()
                          : const AuthenticatedHeader(),
                      SizedBox(
                        height: height(35),
                      ),
                      const SearchCardWidget(),
                      SizedBox(
                        height: height(35),
                      ),
                      TitleWidget(
                        title: "Categories",
                        onTap: () {
                          navigateTo(
                            view: const CategoryListingView(),
                            context: context,
                          );
                        },
                      ),
                      SizedBox(
                        height: height(15),
                      ),
                      SizedBox(
                        height: height(80),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => CategoryCard(
                            title: cubit.categories[index],
                            selected: false,
                            onTap: () {
                              cubit.changeCategory(cubit.categories[index]);
                              navigateTo(
                                view: const CategoryListingView(),
                                context: context,
                              );
                            },
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: width(15),
                          ),
                          itemCount: cubit.categories.length,
                        ),
                      ),
                      SizedBox(
                        height: height(30),
                      ),
                      TitleWidget(
                        title: "Latest Flyers",
                        onTap: () {
                          navigateTo(
                            view: const FlyerListingView(
                              title: "Latest Flyers",
                            ),
                            context: context,
                          );
                        },
                      ),
                      SizedBox(
                        height: height(15),
                      ),
                      SizedBox(
                        height: height(360),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              const FlyerCardWidget(),
                          separatorBuilder: (context, index) => SizedBox(
                            width: width(15),
                          ),
                          itemCount: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class FlyerCardWidget extends StatelessWidget {
  const FlyerCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Container(
      width: width(250),
      padding: padding,
      margin: EdgeInsets.symmetric(
        vertical: height(15),
      ),
      decoration: BoxDecoration(
        color: color.backgroundColor,
        boxShadow: [boxShadow],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Image.network(
                  "https://static.shopping-canada.com/staples-deal-of-the-week-on-from-february-19-to-february-25-2020-page-10.jpg",
                  width: width(150),
                  height: height(180),
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: CustomText(
                      fontSize: width(10),
                      text: "New",
                      color: color.backgroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const FavouriteButton(),
                ],
              )
            ],
          ),
          SizedBox(
            height: height(25),
          ),
          CustomText(
            fontSize: width(16),
            text: "Peavy Mart Flyer",
            fontWeight: FontWeight.w600,
            maxlines: 1,
          ),
          SizedBox(
            height: height(10),
          ),
          CustomText(
            fontSize: width(14),
            text: "Office & Tables",
            maxlines: 1,
            color: color.hintColor,
            fontWeight: FontWeight.w400,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: CustomText(
                  fontSize: width(13),
                  color: color.hintColor.withOpacity(0.6),
                  text: "Valid till 6 days",
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                flex: 2,
                child: CustomButton(
                  btnHeight: height(35),
                  fontSize: width(15),
                  fontWeight: FontWeight.w400,
                  function: () {
                    navigateTo(view: FlyerDetailsView(), context: context);
                  },
                  text: "Details",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.hintColor.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        "assets/icons/heart.svg",
        color: color.primaryColorDark,
        width: width(20),
        height: height(20),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          fontSize: width(18),
          text: title,
          fontWeight: FontWeight.w600,
        ),
        GestureDetector(
          onTap: onTap,
          child: CustomText(
            fontSize: width(14),
            text: "See more",
            color: color.hintColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.title,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  final Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: EdgeInsets.symmetric(
          vertical: height(15),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [boxShadow],
          color: selected ? color.primaryColor : color.backgroundColor,
        ),
        child: CustomText(
          fontSize: width(14),
          text: title,
          color: selected ? color.backgroundColor : color.hintColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class SearchCardWidget extends StatelessWidget {
  const SearchCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: () {
        navigateTo(
          view: const SearchView(),
          context: context,
        );
      },
      child: Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.backgroundColor,
          boxShadow: [
            boxShadow,
          ],
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/search.svg",
              width: width(32),
              height: height(32),
            ),
            SizedBox(
              width: width(10),
            ),
            CustomText(
              fontSize: width(16),
              text: "Search for Flyer deals",
              color: color.hintColor,
            ),
          ],
        ),
      ),
    );
  }
}

class NotAuthenticatedHeader extends StatelessWidget {
  const NotAuthenticatedHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                fontSize: width(24),
                text: "Hi there,",
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: height(5),
              ),
              CustomText(
                fontSize: width(16),
                text: "Sign in or create an account \nfor better experience.",
                fontWeight: FontWeight.w400,
                color: color.hintColor,
              ),
              SizedBox(
                height: height(15),
              ),
              CustomButton(
                fontSize: width(16),
                btnWidth: width(100),
                btnHeight: height(40),
                radius: 8,
                function: () {
                  navigateTo(view: LoginView(), context: context);
                },
                text: "Sign in",
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          "assets/images/access.svg",
          width: width(200),
          height: height(150),
        ),
      ],
    );
  }
}

class AuthenticatedHeader extends StatelessWidget {
  const AuthenticatedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);

    return Row(
      children: [
        const RoundedNetworkImage(),
        SizedBox(
          width: width(15),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              fontSize: width(16),
              text: "Hi,",
              fontWeight: FontWeight.w400,
              color: color.hintColor,
            ),
            SizedBox(
              height: height(5),
            ),
            CustomText(
              fontSize: width(20),
              text: userModel!.getFullName(),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        const Spacer(),
        SvgPicture.asset(
          "assets/images/remind.svg",
          color: color.hintColor,
          width: width(40),
          height: height(40),
        ),
      ],
    );
  }
}

class RoundedNetworkImage extends StatelessWidget {
  const RoundedNetworkImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Container(
      width: width(50),
      height: height(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color.hintColor.withOpacity(0.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: userModel!.profilePictureId != null
            ? CustomCachedImage(
                url: userModel!.profilePictureId!,
                boxFit: BoxFit.cover,
              )
            : const Icon(
                Icons.error,
              ),
      ),
    );
  }
}
