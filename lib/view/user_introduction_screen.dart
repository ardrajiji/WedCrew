import 'package:flutter/material.dart';
import 'package:wed_crew/view/register_separation.dart';
import 'package:wed_crew/view/utils/preference_values.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(pages: [
        OnboardingPageModel(
          title: 'Welcome to Your WEDCREW',
          description:
              'Your one-stop solution to plan, organize, and manage your dream wedding effortlessly.',
          imageUrl: 'assets/image/img1.png',
          bgColor: Colors.white,
          textColor: Color.fromRGBO(34, 125, 69, 1),
          titlesub: Color.fromRGBO(194, 154, 119, 1.0),
        ),
        OnboardingPageModel(
          title: 'Plan Every Detail',
          description:
              'From venues to vendors, manage all aspects of your wedding in one place.',
          imageUrl: 'assets/image/img2.png',
          bgColor: Colors.white,
          textColor: Color.fromRGBO(34, 125, 69, 1),
          titlesub: Color.fromRGBO(194, 154, 119, 1.0),
        ),
        OnboardingPageModel(
          title: 'Stay Connected',
          description:
              'Collaborate with your partner, family, and wedding planners in real-time.',
          imageUrl: 'assets/image/img3.png',
          bgColor: Colors.white,
          textColor: Color.fromRGBO(34, 125, 69, 1),
          titlesub: Color.fromRGBO(194, 154, 119, 1.0),
        ),
        OnboardingPageModel(
          title: 'Track Your Budget',
          description:
              'Easily manage your wedding budget and keep track of expenses.',
          imageUrl: 'assets/image/img4.png',
          bgColor: Colors.white,
          textColor: Color.fromRGBO(34, 125, 69, 1),
          titlesub: Color.fromRGBO(194, 154, 119, 1.0),
        ),
        OnboardingPageModel(
          title: 'Save Your Favorites',
          description:
              'Bookmark your favorite venues, vendors, and ideas for quick access.',
          imageUrl: 'assets/image/img5.png',
          bgColor: Colors.white,
          textColor: Color.fromRGBO(34, 125, 69, 1),
          titlesub: Color.fromRGBO(194, 154, 119, 1.0),
        ),
      ]),
    );
  }
}

class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter(
      {super.key, required this.pages, this.onSkip, this.onFinish});

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  // Store the currently visible page
  int _currentPage = 0;
  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    // Change current page when pageview changes
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              item.imageUrl,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: item.textColor,
                                        )),
                              ),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: item.titlesub,
                                        )),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 30
                              : 8,
                          height: 8,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(34, 125, 69, 1),
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            visualDensity: VisualDensity.comfortable,
                            foregroundColor:
                                const Color.fromRGBO(194, 154, 119, 1.0),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          // Disable the intro screen
                          await PreferenceValues.disableUserIntroScreen();

                          // Navigate to the LoginPage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpSelectionPage(),
                            ),
                          );
                        },
                        child: const Text("Skip")),
                    TextButton(
                      style: TextButton.styleFrom(
                          visualDensity: VisualDensity.comfortable,
                          foregroundColor: Color.fromRGBO(194, 154, 119, 1.0),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (_currentPage == widget.pages.length - 1) {
                          // Disable the intro screen
                          await PreferenceValues.disableUserIntroScreen();

                          // Navigate to the UserLoginPage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpSelectionPage(),
                            ),
                          );
                        } else {
                          // Go to the next page
                          _pageController.animateToPage(
                            _currentPage + 1,
                            curve: Curves.easeInOutCubic,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1
                                ? "Finish"
                                : "Next",
                          ),
                          const SizedBox(width: 8),
                          Icon(_currentPage == widget.pages.length - 1
                              ? Icons.done
                              : Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String imageUrl;
  final Color bgColor;
  final Color textColor;
  final Color titlesub;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.bgColor = const Color.fromARGB(255, 8, 89, 155),
    this.textColor = const Color(0xFF4552B5),
    this.titlesub = const Color(0xFF4552B5),
  });
}
