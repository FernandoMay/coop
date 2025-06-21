import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// Theme Provider
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return CupertinoApp(
          title: 'Cupertino',
          theme: CupertinoThemeData(
            brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            primaryColor: CupertinoColors.systemBlue,
          ),
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    MainScreen(),
    CupertinoTabView(builder: (context) => Center(child: Text('Second Tab'))),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.play_circle),
            label: 'Second',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return _screens[index];
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Cupertino',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: GestureDetector(
          onTap: () => themeProvider.toggleTheme(),
          child: Icon(
            isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
            color: CupertinoColors.systemBlue,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? CupertinoColors.tertiarySystemFill : CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.search,
                    color: CupertinoColors.placeholderText,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Search',
                    style: TextStyle(
                      color: CupertinoColors.placeholderText,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Toggle layout direction
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toggle layout direction',
                  style: TextStyle(fontSize: 16),
                ),
                CupertinoSwitch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Color circles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorCircle(CupertinoColors.systemBlue),
                _buildColorCircle(CupertinoColors.systemGreen),
                _buildColorCircle(CupertinoColors.systemPurple),
                _buildColorCircle(CupertinoColors.systemOrange),
                _buildColorCircle(CupertinoColors.systemRed),
              ],
            ),
            
            SizedBox(height: 30),
            
            // Menu Items
            _buildMenuItem(
              context,
              'SF Symbols',
              'One',
              CupertinoIcons.heart_fill,
              CupertinoColors.systemPink,
              () => Navigator.push(context, CupertinoPageRoute(builder: (context) => SFSymbolsScreen())),
            ),
            
            _buildMenuItem(
              context,
              'Sections',
              'Two',
              CupertinoIcons.rectangle_stack_fill,
              CupertinoColors.systemPurple,
              () => Navigator.push(context, CupertinoPageRoute(builder: (context) => SectionsScreen())),
            ),
            
            _buildMenuItem(
              context,
              'Adaptive widgets',
              'Three',
              CupertinoIcons.device_phone_portrait,
              CupertinoColors.systemBlue,
              () => Navigator.push(context, CupertinoPageRoute(builder: (context) => AdaptiveWidgetsScreen())),
            ),
            
            _buildMenuItem(
              context,
              'Bottom sheet',
              'Four',
              CupertinoIcons.square_stack_3d_up,
              CupertinoColors.systemTeal,
              () => Navigator.push(context, CupertinoPageRoute(builder: (context) => BottomSheetScreen())),
            ),
            
            SizedBox(height: 30),
            
            // Swipe horizontally sections
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? CupertinoColors.tertiarySystemFill : CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Swipe horizontally',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.placeholderText,
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? CupertinoColors.tertiarySystemFill : CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Swipe horizontally',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.placeholderText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String subtitle, IconData icon, Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: CupertinoColors.white,
                size: 18,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.placeholderText,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.placeholderText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class SFSymbolsScreen extends StatelessWidget {
  const SFSymbolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('SF Symbols'),
        previousPageTitle: 'Back',
      ),
      child: Center(
        child: Text('SF Symbols Screen'),
      ),
    );
  }
}

class SectionsScreen extends StatelessWidget {
  const SectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Sections'),
        previousPageTitle: 'Back',
      ),
      child: Center(
        child: Text('Sections Screen'),
      ),
    );
  }
}

class AdaptiveWidgetsScreen extends StatelessWidget {
  const AdaptiveWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Adaptive Widgets'),
        previousPageTitle: 'Back',
      ),
      child: Center(
        child: Text('Adaptive Widgets Screen'),
      ),
    );
  }
}

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino'),
        previousPageTitle: 'Back',
        trailing: GestureDetector(
          onTap: () => themeProvider.toggleTheme(),
          child: Icon(
            isDark ? CupertinoIcons.sun_max : CupertinoIcons.moon,
            color: CupertinoColors.systemBlue,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Bottom sheet item
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemTeal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    CupertinoIcons.square_stack_3d_up,
                    color: CupertinoColors.white,
                    size: 18,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Bottom sheet',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(
                  'Four',
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.placeholderText,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  CupertinoIcons.chevron_right,
                  color: CupertinoColors.placeholderText,
                  size: 16,
                ),
              ],
            ),
            
            SizedBox(height: 30),
            
            // Swipe sections
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? CupertinoColors.tertiarySystemFill : CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Swipe horizontally',
                style: TextStyle(fontSize: 16, color: CupertinoColors.placeholderText),
              ),
            ),
            
            SizedBox(height: 16),
            
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? CupertinoColors.tertiarySystemFill : CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Swipe horizontally',
                style: TextStyle(fontSize: 16, color: CupertinoColors.placeholderText),
              ),
            ),
            
            SizedBox(height: 30),
            
            // Controls Section
            Text(
              'Controls',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Control buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(CupertinoIcons.share),
                _buildControlButton(CupertinoIcons.plus),
                _buildControlButton(CupertinoIcons.play_fill),
                _buildControlButton(CupertinoIcons.plus),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Segmented Control
            SizedBox(
              width: double.infinity,
              child: CupertinoSegmentedControl<int>(
                children: {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('Gray S'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('Tinted M'),
                  ),
                  2: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('Filled L'),
                  ),
                },
                onValueChanged: (value) {},
                groupValue: 2,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Second segmented control
            SizedBox(
              width: double.infinity,
              child: CupertinoSegmentedControl<int>(
                children: {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('Plain'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('Creating'),
                  ),
                  2: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text('Updating'),
                  ),
                },
                onValueChanged: (value) {},
                groupValue: 0,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Activity indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoActivityIndicator(),
                CupertinoActivityIndicator(),
                CupertinoActivityIndicator(),
                CupertinoActivityIndicator(),
                CupertinoActivityIndicator(),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Progress indicators
            Row(
              children: [
                Expanded(
                  child: CupertinoActivityIndicator(
                    radius: 12,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CupertinoActivityIndicator(
                    radius: 12,
                    animating: true,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 30),
            
            // Text field
            Text(
              'Text field...',
              style: TextStyle(
                fontSize: 16,
                color: CupertinoColors.placeholderText,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Text input
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? CupertinoColors.tertiarySystemFill : CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.textformat,
                    color: CupertinoColors.placeholderText,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Text input',
                      style: TextStyle(
                        color: CupertinoColors.placeholderText,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.pencil,
                    color: CupertinoColors.placeholderText,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Popups Section
            Text(
              'Popups',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Popup buttons
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                    child: Text(
                      'Alert',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                    ),
                    onPressed: () => _showAlert(context),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                    child: Text(
                      'Native',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                    ),
                    onPressed: () => _showNativeDialog(context),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                    child: Text(
                      'Action sheet',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                    ),
                    onPressed: () => _showActionSheet(context),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CupertinoButton(
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                    child: Text(
                      'Native',
                      style: TextStyle(color: CupertinoColors.systemBlue),
                    ),
                    onPressed: () => _showNativeActionSheet(context),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            CupertinoButton(
              color: CupertinoColors.systemBlue.withOpacity(0.1),
              child: Text(
                'Menu',
                style: TextStyle(color: CupertinoColors.systemBlue),
              ),
              onPressed: () => _showMenu(context),
            ),
            
            SizedBox(height: 30),
            
            // Wheel pickers section
            Text(
              'Wheel pickers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Picker headers
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Months',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Date',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Date & Time',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Date picker
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Alert'),
        content: Text('This is a Cupertino alert dialog.'),
        actions: [
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
  
  void _showNativeDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Native Dialog'),
        content: Text('This is a native-style dialog.'),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
  
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Action Sheet'),
        message: Text('Select an option'),
        actions: [
          CupertinoActionSheetAction(
            child: Text('Option 1'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoActionSheetAction(
            child: Text('Option 2'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
  
  void _showNativeActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Native Action Sheet'),
        actions: [
          CupertinoActionSheetAction(
            child: Text('Native Option'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
  
  void _showMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Menu'),
        actions: [
          CupertinoActionSheetAction(
            child: Text('Menu Item 1'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoActionSheetAction(
            child: Text('Menu Item 2'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoActionSheetAction(
            child: Text('Menu Item 3'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon) {
    return CupertinoButton(
      color: CupertinoColors.systemBlue.withOpacity(0.1),
      child: Icon(
        icon,
        color: CupertinoColors.systemBlue,
      ),
      onPressed: () {},
    );
  }
  // Widget _buildControlButtonWithText(String text) {
  //   return CupertinoButton(
  //     color: CupertinoColors.systemBlue.withOpacity(0.1),
  //     child: Text(
  //       text,
  //       style: TextStyle(color: CupertinoColors.systemBlue),
  //     ),
  //     onPressed: () {},
  //   );
  // }
  // Widget _buildControlButtonWithIcon(IconData icon) {
  //   return CupertinoButton(
  //     color: CupertinoColors.systemBlue.withOpacity(0.1),
  //     child: Icon(
  //       icon,
  //       color: CupertinoColors.systemBlue,
  //     ),
  //     onPressed: () {},
  //   );
  // }
  // Widget _buildControlButtonWithIconAndText(IconData icon, String text) {
  //   return CupertinoButton(
  //     color: CupertinoColors.systemBlue.withOpacity(0.1),
  //     child: Row(
  //       children: [
  //         Icon(
  //           icon,
  //           color: CupertinoColors.systemBlue,
  //         ),
  //         SizedBox(width: 8),
  //         Text(
  //           text,
  //           style: TextStyle(color: CupertinoColors.systemBlue),
  //         ),
  //       ],
  //     ),
  //     onPressed: () {},
  //   );
  // }
}