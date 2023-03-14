import 'package:flutter/material.dart';
import 'package:shopping_app/modules/login_screen.dart';
import 'package:shopping_app/shared/components/components.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../shared/components/constants.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {

    var boardingController = PageController();
    List<BoardingModel> boarding = [
      BoardingModel(
          image: 'assets/images/onboarding_1.png',
          title: 'title 1',
          body: 'body 1'),
      BoardingModel(
          image: 'assets/images/onboarding_2.png',
          title: 'title 2',
          body: 'body 2'),
      BoardingModel(
          image: 'assets/images/onboarding_3.png',
          title: 'title 3',
          body: 'body 3')
    ];

    bool isLast = false;
    void submit(){
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
        if(value!){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ShopLoginScreen()),
                  (Route<dynamic> route) => false
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ShopLoginScreen()),
                        (Route<dynamic> route) => false
                );
              },
              child: const Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index == 2)
                  {
                    setState(() {
                      isLast = true;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),

            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5.0,
                      expansionFactor: 4,

                    ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      // print('is Last ===> $isLast');
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(
                            milliseconds: 600
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                      /*navigateToReplace(context, const ShopLoginScreen());*/

                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            /*  fit: BoxFit.cover,*/
            ),
          ),
          /*const SizedBox(
            height: 30.0,
          ),*/
          Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
