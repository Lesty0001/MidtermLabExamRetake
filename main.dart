//1.  Import the necessary package for Flutter
import 'package:flutter/material.dart';

// 2. The main function is the entry point of the Flutter application
void main() {
  // Run the application with the given widget
  runApp(
    // 3. Create a MaterialApp widget, which is a top-level widget for a Flutter application
    const MaterialApp(
      // Set the home property to the ExampleStaggeredAnimations widget
      home: const ExampleStaggeredAnimations(),
      //4. Set debugShowCheckedModeBanner to false to hide the debug banner
      debugShowCheckedModeBanner: false,
    ),
  );
}

//5.  Define a StatefulWidget class called ExampleStaggeredAnimations
class ExampleStaggeredAnimations extends StatefulWidget {
  // The constructor for the ExampleStaggeredAnimations class
  const ExampleStaggeredAnimations({
    // 6. The key parameter is required for all widgets
    super.key,
  });

  // 7. Override the createState method to return a State object
  @override
  State<ExampleStaggeredAnimations> createState() =>
      // Return an instance of the _ExampleStaggeredAnimationsState class
      _ExampleStaggeredAnimationsState();
}


// 8. Define a private class _ExampleStaggeredAnimationsState that extends the State class
class _ExampleStaggeredAnimationsState extends State<ExampleStaggeredAnimations>
    // Mixin the SingleTickerProviderStateMixin to provide a single ticker
    with SingleTickerProviderStateMixin {
  
  // 9 Declare a late variable _drawerSlideController of type AnimationController
  late AnimationController _drawerSlideController;

  // 10. Override the initState method, which is called when the widget is inserted into the tree
  @override
  void initState() {
    // Call the superclass's initState method
    super.initState();

    // Initialize the _drawerSlideController with an AnimationController
    _drawerSlideController = AnimationController(
      // Set the vsync property to this, which is the SingleTickerProviderStateMixin
      vsync: this,
      // 11. Set the duration of the animation to 150 milliseconds
      duration: const Duration(milliseconds: 150),
    );
  }

  // Override the dispose method, which is called when the widget is removed from the tree
@override
void dispose() {
  // 12. Dispose the _drawerSlideController to free up resources
  _drawerSlideController.dispose();
  // Call the superclass's dispose method
  super.dispose();
}

// Define a private method _isDrawerOpen that checks if the drawer is open
bool _isDrawerOpen() {
  // Return true if the value of _drawerSlideController is 1.0, indicating the drawer is open
  return _drawerSlideController.value == 1.0;
}

// Define a private method _isDrawerOpening that checks if the drawer is opening
bool _isDrawerOpening() {
  // 13. Return true if the status of _drawerSlideController is AnimationStatus.forward, indicating the drawer is opening
  return _drawerSlideController.value == AnimationStatus.forward;
}

// Define a private method _isDrawerClosed that checks if the drawer is closed
bool _isDrawerClosed() {
  // 14. Return true if the value of _drawerSlideController is 0.0, indicating the drawer is closed
  return _drawerSlideController.value == 0.0;//not sure
}

// Define a private method _toggleDrawer that toggles the drawer open or closed
void _toggleDrawer() {
  // Check if the drawer is open or opening
  if (_isDrawerOpen() || _isDrawerOpening()) {
    // If so, reverse the animation to close the drawer
    _drawerSlideController.reverse();
  } else {
    // If not, forward the animation to open the drawer
    _drawerSlideController.forward();
  }
}

@override
// Override the build method from the parent class
Widget build(BuildContext context) {
  // Return a Scaffold widget
  return Scaffold(
    // Set the background color of the Scaffold to white
    backgroundColor: Colors.white,
    // Set the appBar of the Scaffold to the result of _buildAppBar()
    appBar: _buildAppBar(),
    // Set the body of the Scaffold to a Stack widget
    body: Stack(
      // The children of the Stack widget
      children: [
        // The first child is the result of _buildContent()
        _buildContent(),
        // The second child is the result of _buildDrawer()
        _buildDrawer(),
      ],
    ),
  );
}

// A method to build a PreferredSizeWidget (in this case, an AppBar)
PreferredSizeWidget _buildAppBar() {
  // Return an AppBar widget
  return AppBar(
    // Set the title of the AppBar to a Text widget with the text 'Flutter Menu'
    title: const Text(
      'Flutter Menu',
      // Set the style of the Text widget
      style: TextStyle(
        // Set the color of the text to black
        color: Colors.black,
      ),
    ),
    //15. Set the background color of the AppBar to transparent
    backgroundColor: Colors.transparent,
    // Set the elevation of the AppBar to 0.0
    elevation: 0.0,
    // Set automaticallyImplyLeading to false
    automaticallyImplyLeading: false,
    // 16. Set the actions of the AppBar to a list containing an AnimatedBuilder
    actions: [
      AnimatedBuilder(
        // The animation to build
        animation: _drawerSlideController,
        // The builder function to call when the animation changes
        builder: (context, child) {
          // Return an IconButton
          return IconButton(
            // Set the onPressed callback to _toggleDrawer
            onPressed: _toggleDrawer,
            // Set the icon of the IconButton based on the state of the drawer
            icon: _isDrawerOpen() || _isDrawerOpening()
                ? const Icon(
                    // If the drawer is open or opening, show a clear icon
                    Icons.clear,
                    // 17. Set the color of the icon to black
                    color: Colors.black,
                  )
                : const Icon(
                    // If the drawer is not open or opening, show a menu icon
                    Icons.menu,
                    // Set the color of the icon to black
                    color: Colors.black,
                  ),
          );
        },
      ),
    ],
  );
}

// A method to build the content of the page
Widget _buildContent() {
  // This is a placeholder for the page content
  // Put page content here.
  return const SizedBox();
}

// A method to build the drawer
Widget _buildDrawer() {
  // Return an AnimatedBuilder that animates the drawer
  return AnimatedBuilder(
    // The animation to build
    animation: _drawerSlideController,
    // The builder function to call when the animation changes
    builder: (context, child) {
      // Return a FractionalTranslation that translates the drawer
      return FractionalTranslation(
        // The translation offset
        translation: Offset(1.0 - _drawerSlideController.value, 0.0),
        // The child of the FractionalTranslation
        child: _isDrawerClosed() 
          // If the drawer is closed, show an empty SizedBox
          ? const SizedBox() 
          // If the drawer is not closed, show the Menu
          : const Menu(),
      );
    },
  );
}
}

// A class that represents the menu
class Menu extends StatefulWidget {
  // The constructor for the Menu class
  const Menu({super.key});

  // Override the createState method to create the state for the Menu
  @override
  State<Menu> createState() => _MenuState();
}

// The state class for the Menu
class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  // A list of menu titles
  static const _menuTitles = [
    'Declarative style',
    'Premade widgets',
    'Stateful hot reload',
    'Native performance',
    'Great community',
  ];

  // The initial delay time for the animation
  static const _initialDelayTime = Duration(milliseconds: 50);
  // The time it takes for each item to slide in
  static const _itemSlideTime = Duration(milliseconds: 250);
  // The time between each item's animation
  static const _staggerTime = Duration(milliseconds: 50);
  // The delay time before the button animation starts
  static const _buttonDelayTime = Duration(milliseconds: 150);
  // The time it takes for the button animation to complete
  static const _buttonTime = Duration(milliseconds: 500);

  // Calculate the total duration of the animation
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  // The animation controller for the staggered animation
  late AnimationController _staggeredController;
  // A list of intervals for the item slide animations
  final List<Interval> _itemSlideIntervals = [];
  // The interval for the button animation
  late Interval _buttonInterval;

  // 18. Override the initState method from the parent class
@override
void initState() {
  // Call the parent class's initState method
  super.initState();

  // Create the animation intervals
  _createAnimationIntervals();

  // 19. Create an AnimationController with the vsync and duration
  _staggeredController = AnimationController(
    // The vsync to use for the animation
    vsync: this,
    // The duration of the animation
    duration: _animationDuration,
  )
  // 20. Start the animation forward
  ..forward();
}

// A method to create the animation intervals
void _createAnimationIntervals() {
  // Loop through each menu title
  for (var i = 0; i < _menuTitles.length; ++i) {
    // Calculate the start time for the current item's animation
    final startTime = _initialDelayTime + (_staggerTime * i);
    // Calculate the end time for the current item's animation
    final endTime = startTime + _itemSlideTime;
    // Add an Interval to the list of item slide intervals
    _itemSlideIntervals.add(
      Interval(
        // The start time of the interval as a fraction of the total animation duration
        startTime.inMilliseconds / _animationDuration.inMilliseconds,
        // The end time of the interval as a fraction of the total animation duration
        endTime.inMilliseconds / _animationDuration.inMilliseconds,
      ),
    );
  }

  // Calculate the start time for the button animation
  final buttonStartTime =
      Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
  // Calculate the end time for the button animation
  final buttonEndTime = buttonStartTime + _buttonTime;
  // Set the button interval
  _buttonInterval = Interval(
    // The start time of the interval as a fraction of the total animation duration
    buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
    // The end time of the interval as a fraction of the total animation duration
    buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
  );
}

// Override the dispose method from the parent class
@override
void dispose() {
  // Dispose of the staggered controller
  _staggeredController.dispose();
  // Call the parent class's dispose method
  super.dispose();
}

// Override the build method from the parent class
@override
Widget build(BuildContext context) {
  // 21. Return a Container widget
  return Container(
    // Set the color of the Container to white
    color: Colors.white,
    // Set the child of the Container to a Stack widget
    child: Stack(
      // Set the fit of the Stack to expand
      fit: StackFit.expand,
      // Set the children of the Stack
      children: [
        // The first child is the Flutter logo
        _buildFlutterLogo(),
        // The second child is the content
        _buildContent(),
      ],
    ),
  );
}

// 22. A method to build the Flutter logo
Widget _buildFlutterLogo() {
  // Return a Positioned widget
  return const Positioned(
    // 23. Set the right position of the Positioned widget to -100
    right: -100,
    // Set the bottom position of the Positioned widget to -30
    bottom: -30,
    // Set the child of the Positioned widget to an Opacity widget
    child: Opacity(
      // 24. Set the opacity of the Opacity widget to 0.2
      opacity: 0.2,
      // Set the child of the Opacity widget to a FlutterLogo widget
      child: FlutterLogo(
        // Set the size of the FlutterLogo widget to 400
        size: 400,
      ),
    ),
  );
}

// A method to build the content
Widget _buildContent() {
  // 25. Return a Column widget
  return Column(
    // Set the cross axis alignment of the Column widget to start
    crossAxisAlignment: CrossAxisAlignment.start,
    // 26. Set the children of the Column widget
    children: [
      // 27. The first child is a SizedBox with a height of 16
      const SizedBox(height: 16),
      // The second child is a list of items
      ..._buildListItems(),
      // 28. The third child is a Spacer widget
      const Spacer(),
      // The fourth child is the get started button
      _buildGetStartedButton(),
    ],
  );
}

// A method to build a list of items
List<Widget> _buildListItems() {
  // 29. Create an empty list of widgets
  final listItems = <Widget>[];
  // Loop through each menu title
  for (var i = 0; i < _menuTitles.length; ++i) {
    // 30. Add an AnimatedBuilder to the list
    listItems.add(
       AnimatedBuilder(
        // 31. The animation to build
        animation: _staggeredController,
        //32. The builder function to call when the animation changes
        builder: (context, child) {
          // Calculate the animation percent
          final animationPercent = Curves.easeOut.transform(
            _itemSlideIntervals[i].transform(_staggeredController.value),
          );
          //33.  Calculate the opacity
          final opacity = animationPercent;
          // Calculate the slide distance
          final slideDistance = (1.0 - animationPercent) * 150;

          // 34.Return an Opacity widget
          return Opacity(
            // 35. Set the opacity of the Opacity widget
            opacity: opacity,
            // 36. Set the child of the Opacity widget to a Transform widget
            child: Transform.translate(
              // Set the offset of the Transform widget
              offset: Offset(slideDistance, 0),
              // 37. Set the child of the Transform widget
              child: child,
            ),
          );
        },
        // 38. The child of the AnimatedBuilder
        child: Padding(
          // Set the padding of the Padding widget
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
          // 39. Set the child of the Padding widget to a Text widget
          child: Text(
            // Set the text of the Text widget
            _menuTitles[i],
            // 40. Set the text alignment of the Text widget
            textAlign: TextAlign.left,
            // Set the style of the Text widget
            style: const TextStyle(
              // Set the font size of the Text widget
              fontSize: 24,
              // Set the font weight of the Text widget
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
  // 41. Return the list of items
  return listItems;
}

// A method to build the get started button
Widget _buildGetStartedButton() {
  // 42. Return a SizedBox widget with infinite width
  return SizedBox(
    // Set the width of the SizedBox widget to infinity
    width: double.infinity,
    // Set the child of the SizedBox widget to a Padding widget
    child: Padding(
      //43. Set the padding of the Padding widget to 24 on all sides
      padding: const EdgeInsets.all(24),
      //44.  Set the child of the Padding widget to an AnimatedBuilder
      child: AnimatedBuilder(
        // 45. The animation to build
        animation: _staggeredController,
        // The builder function to call when the animation changes
        builder: (context, child) {
          // Calculate the animation percent using the elastic out curve
          final animationPercent = Curves.elasticOut.transform(
            _buttonInterval.transform(_staggeredController.value),
          );
          //46. Clamp the animation percent to be between 0.0 and 1.0
          final opacity = animationPercent.clamp(0.0, 1.0);
          // Calculate the scale based on the animation percent
          final scale = (animationPercent * 0.5) + 0.5;

          // 47. Return an Opacity widget
          return Opacity(
            // Set the opacity of the Opacity widget
            opacity: opacity,
            //48 Set the child of the Opacity widget to a Transform widget
            child: Transform.scale(
              // Set the scale of the Transform widget
              scale: scale,
              // Set the child of the Transform widget
              child: child,
            ),
          );
        },
        // The child of the AnimatedBuilder
        child: ElevatedButton(
          //49. Set the style of the ElevatedButton
          style: ElevatedButton.styleFrom(
            // Set the shape of the ElevatedButton to a StadiumBorder
            shape: const StadiumBorder(),
            // Set the background color of the ElevatedButton to blue
            backgroundColor: Colors.blue,
            // Set the padding of the ElevatedButton
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
          ),
          // 50. Set the onPressed callback of the ElevatedButton
          onPressed: () {},
          // Set the child of the ElevatedButton to a Text widget
          child: const Text(
            // Set the text of the Text widget
            'Get started',
            // Set the style of the Text widget
            style: TextStyle(
              // Set the color of the Text widget to white
              color: Colors.white,
              // Set the font size of the Text widget
              fontSize: 22,
            ),
          ),
        ),
      ),
    ),
  );
}
}
