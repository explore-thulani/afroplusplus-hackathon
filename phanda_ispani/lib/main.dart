import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:animated_splash/animated_splash.dart';
import 'dart:convert';

class Job {
  final int id;
  final String title;
  final String domain;
  final String company;
  final String qualifications;

  const Job(
      {this.id, this.title, this.domain, this.company, this.qualifications});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
        id: json['id'],
        title: json['title'],
        domain: json['domain'],
        company: json['company'],
        qualifications: json['qualifications']);
  }
}

Future<Job> fetchJob() async {
  final response = await http.get('https://localhost:5000/jobs/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Job.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

final job_posts = List<Job>.generate(
  20,
  (i) => Job(
      title: 'Data Scientist',
      domain: 'https://linkedin.com/jobs/',
      company: 'African Bank',
      qualifications:
          'Bachelor of Science in Mathematics, Statistics, Actuarial Science, Applied Mathematics, Computer Science or similar'),
);

final List<Job> applied_jobs = [
  new Job(
    title: 'Data Scientist',
    domain: 'https://linkedin.com/jobs/',
    company: 'African Bank',
    qualifications:
        'Bachelor of Science in Mathematics, Statistics, Actuarial Science, Applied Mathematics, Computer Science or similar',
  )
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phanda Ispani',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Quicksand'),
      /*home: AnimatedSplash(
        imagePath: 'assets/images/ispani.png',
        home: MyHomePage(title: 'Phanda Ispani Home'),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),*/
      home: MyHomePage(title: 'Phanda Ispani Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Job> applied = [];

  Future<Job> futureJob;

  @override
  void initState() {
    super.initState();
    futureJob = fetchJob();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: FutureBuilder<Job>(
        future: futureJob,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.title);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
      //tab_views(context, _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.business_center),
            title: new Text('Jobs'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.cloud_done),
            title: new Text('Applied'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

Widget tab_views(BuildContext context, int index) {
  List<Job> applied = applied_jobs;
  List<Widget> _children = [
    ListView(
      children: job_posts
          .map((job) => ListTile(
                leading: Icon(
                  Icons.business,
                  color: Colors.black,
                ),
                title: Text(
                  job.title + ' - ' + job.company,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(job.qualifications),
                trailing: Text('1s ago'),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobView(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: job_posts[index],
                      ),
                    ),
                  );
                },
              ))
          .toList(),
    ),
    ListView(
      children: applied
          .map((job) => ListTile(
                leading: Icon(
                  Icons.business,
                  color: Colors.black,
                ),
                title: Text(
                  job.title + ' - ' + job.company,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(job.qualifications),
                trailing: Text('1s ago'),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppliedView(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: job_posts[index],
                      ),
                    ),
                  );
                },
              ))
          .toList(),
    ),
    profile_view('Thulani Ncube', 'Data Scientist', 'Johannesburg')
  ];
  return _children[index];
}

class JobView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Job job = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return;
            },
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(
                job.title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('/images/ispani.png'),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment(0.0, 0.5),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //TODO: Add Stuff
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          applied_jobs.add(job);
          Navigator.pop(context);
        },
        tooltip: 'Apply',
        isExtended: true,
        label: Text(
          'Apply',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
        ),
        icon: Icon(
          Icons.cloud_upload,
          size: 18.0,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AppliedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Job job = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return;
            },
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(
                job.title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('/images/ispani.png'),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment(0.0, 0.5),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //TODO: Add Stuff
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          applied_jobs.remove(job);
          Navigator.pop(context);
        },
        tooltip: 'Cancel',
        isExtended: true,
        label: Text(
          'Cancel',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
        ),
        icon: Icon(
          Icons.cancel,
          size: 18.0,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Profile View
ListView profile_view(
  String name,
  String title,
  String location,
) {
  return ListView(
    children: [
      SizedBox(
        height: 20.0,
      ),
      Center(
        child: Icon(
          Icons.account_circle,
          color: Colors.teal,
          size: 180,
        ),
      ),
      ListTile(
        title: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Center(
          child: Text(title),
        ),
      ),
      Center(
        child: Text(
          location,
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      Center(
        child: Text(
          'About me:',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
