import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  // Daftar halaman yang ditampilkan pada bottom navigation
  static const List<Widget> _pages = <Widget>[
    HomeContent(),
    Center(child: Text('Profil Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings Page', style: TextStyle(fontSize: 24))),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Menghapus padding default
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("johndoe@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              decoration: BoxDecoration(color: Colors.deepPurple),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Aksi notifikasi
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Aksi pencarian
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);
  
  // Carousel slider menggunakan PageView
  Widget _buildCarousel(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(
        children: [
          _buildCarouselItem(context, Colors.deepPurple, "Slide 1", "Ini slide pertama"),
          _buildCarouselItem(context, Colors.indigo, "Slide 2", "Ini slide kedua"),
          _buildCarouselItem(context, Colors.blue, "Slide 3", "Ini slide ketiga"),
        ],
      ),
    );
  }
  
  Widget _buildCarouselItem(BuildContext context, Color color, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/sample.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(color.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Center(
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white, 
              fontSize: 24, 
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
  
  // Judul section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }
  
  // Grid untuk featured items
  Widget _buildFeaturedCards() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.8,
      padding: EdgeInsets.all(8),
      children: List.generate(4, (index) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar featured
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage('assets/featured${index + 1}.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Featured ${index + 1}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("Deskripsi singkat mengenai fitur ini",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      }),
    );
  }
  
  // Daftar berita terbaru
  Widget _buildLatestNews() {
    return Column(
      children: List.generate(5, (index) {
        return ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage('assets/news${index + 1}.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text("Berita Terbaru ${index + 1}",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Deskripsi singkat mengenai berita terbaru."),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigasi ke detail berita
          },
        );
      }),
    );
  }
  
  // Section testimonial menggunakan list horizontal
  Widget _buildTestimonials() {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.deepPurple.shade100),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.format_quote, color: Colors.deepPurple, size: 32),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    "Testimoni ${index + 1}: Ini adalah testimoni yang sangat memuaskan dari pengguna aplikasi ini. Sangat direkomendasikan!",
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text("- User ${index + 1}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
  
  // Konten utama halaman home
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCarousel(context),
          _buildSectionTitle("Featured"),
          _buildFeaturedCards(),
          _buildSectionTitle("Latest News"),
          _buildLatestNews(),
          _buildSectionTitle("Testimonials"),
          _buildTestimonials(),
          SizedBox(height: 32),
          Text(
            "© 2025 MyAwesomeApp. All rights reserved.",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}