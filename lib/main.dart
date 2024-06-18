import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'firebase_service.dart';
import 'screens/auth_screen.dart'; // Обновленный путь для экрана аутентификации
import 'screens/user_info_screen.dart'; // Обновленный путь для экрана информации о пользователе

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightGreen,
        ),
      ),
      home: AuthScreen(), // Начинаем с экрана аутентификации
    );
  }
}

// Остальная часть вашего кода останется без изменений.


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();

  static final List<Widget> _screens = <Widget>[
    HomePage(),
    SearchPage(),
    CartPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
        title: Text('Главная'),
      )
          : _selectedIndex == 2
          ? AppBar(
        title: Text('Корзина'),
      )
          : null,
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Личный кабинет',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Остальная часть вашего кода останется без изменений.



class HomePage extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];

  final List<String> buttonTexts = [
    'Средство для мытья посуды',
    'Гидрофильное гель-масло',
    'Набор футболок 3шт',
    'Беспроводные наушники для iphone',
    'Магнитный автодержатель',
    'мармелад в подарочной коробке',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage(imagePaths[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Подборка для вас',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Введите поисковой запрос',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Действие при нажатии на кнопку
                    print('Pressed $index');
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10), // Используем BorderRadius.circular для сглаживания углов
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Сглаживаем углы области обрезки
                      child: Image.asset(
                        'assets/images/button_image_$index.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    buttonTexts[index], // Используем текст из списка buttonTexts
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        ]
      ),
      )
    );
  }
}






class SearchPage extends StatelessWidget {
  final List<String> categories = [
    'Одежда',
    'Обувь',
    'Аксессуары',
    'Косметика',
    'Техника',
    'Игрушки',
    'Книги',
    'Дом',
    'Украшения',
    'Ремонт',
    'Для офиса',
    'Здоровье',
    'Спорт',
    'Хобби',
    'Автотовары',
    'Канцтовары',
  ];

  final List<String> categoryImages = [
    'assets/images/clothes.png',
    'assets/images/shoes.png',
    'assets/images/accessories.png',
    'assets/images/cosmetics.png',
    'assets/images/tech.png',
    'assets/images/toys.png',
    'assets/images/books.png',
    'assets/images/home.png',
    'assets/images/jewelry.png',
    'assets/images/construction.png',
    'assets/images/office.png',
    'assets/images/health.png',
    'assets/images/sports.png',
    'assets/images/hobby.png',
    'assets/images/auto.png',
    'assets/images/stationery.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.0, // Изменено на 1.0 для квадратных контейнеров
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Действие при нажатии на категорию
                print('Pressed ${categories[index]}');
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Светлосерый фон
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset( //
                      categoryImages[index],
                      fit: BoxFit.contain, //
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ваша корзина пуста'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Личный кабинет'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Действие при нажатии на кнопку пользователя
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Действие при нажатии на кнопку уведомления
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
          children: [
      ListTile(
      leading: Icon(Icons.favorite, color: Colors.pink),
      title: Text('Избранное'),
      trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
      onTap: () {
        // Действие при нажатии на кнопку Избранное
      },
    ),
    ListTile(
    leading: Icon(Icons.shopping_bag, color: Colors.blue),
    title: Text('Мои покупки'),
    trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
    onTap: () {
    // Действие при нажатии на кнопку Мои покупки
    },
    ),
    ListTile(
    leading: Icon(Icons.rate_review, color: Colors.lime),
    title: Text('Оставить отзыв'),
    trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
    onTap: () {
    // Действие при нажатии на кнопку Оставить отзыв
    },
    ),
    ListTile(
    leading: Icon(Icons.schedule, color: Colors.grey),
    title: Text('Лист Ожидания'),
    trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
    onTap: () {
    // Действие при нажатии на кнопку Лист ожидания
    },
    ),
    ListTile(
    leading: Icon(Icons.monetization_on, color: Colors.deepOrange),
    title: Text('Возвраты'),
    trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
    onTap: () {
    // Действие при нажатии на кнопку Возвраты
    },
    ),
    ListTile(
    leading: Icon(Icons.credit_card, color: Colors.amber),
    title: Text('Способы оплаты'),
    trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
    onTap: () {
    // Действие при нажатии на кнопку Способы оплаты
    },
    ),
    ListTile(
            leading: Icon(Icons.attach_money, color: Colors.green),
            title: Text('Мои финансы'),
            trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
            onTap: () {
              // Действие при нажатии на кнопку Мои финансы
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_input_svideo, color: Colors.blue),
            title: Text('Активные сессии'),
            trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
            onTap: () {
              // Действие при нажатии на кнопку Активные сессии
            },
          ),
          // Добавьте остальные кнопки здесь
          ListTile(
            leading: Icon(Icons.info),
            title: Text('О приложении'),
            trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
            onTap: () {
              // Действие при нажатии на кнопку О приложении
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Помощь'),
            trailing: Icon(Icons.arrow_forward), // Стрелочка вправо
            onTap: () {
              // Действие при нажатии на кнопку Помощь
            },
          ),
        ],
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления'),
      ),
      body: Center(
        child: Text('Уведомлений нет.'),
      ),
    );
  }
}
