import 'package:flutter/material.dart';



class Test1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DropboxCloudUI(),
    );
  }
}

class DropboxCloudUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3F6), // Soft background color
      body: CustomScrollView(
        slivers: [
          // Fixed Header Section
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            backgroundColor: Color(0xFF0074E4),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar with icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu, color: Colors.white),
                        Icon(Icons.notifications, color: Colors.white),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Dropbox Cloud Title
                    Text(
                      "Dropbox Cloud",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Progress Bar
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: 0.65, // 65% filled
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "65Gb / 100Gb",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Body content
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20),
              // Folders Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Folders",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFolderCard("My Developments", "18.02.2018"),
                        _buildFolderCard("Dribbles", "21.06.2018"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Last Files Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last files: Google Disk",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildFileCard("Brandbook.PDF", "Dropbox/Projects/UI"),
                    _buildFileCard("Landing Page.sketch", "Dropbox/Design"),
                    _buildFileCard("Dashboard.sketch", "Dropbox/Design"),
                    _buildFileCard("Dashboard.sketch", "Dropbox/Design"),
                    _buildFileCard("Dashboard.sketch", "Dropbox/Design"),
                    _buildFileCard("Dashboard.sketch", "Dropbox/Design"),
                    _buildFileCard("Dashboard.sketch", "Dropbox/Design"),
                    _buildFileCard("Dashboard.sketch", "Dropbox/Design"),

                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFolderCard(String title, String date) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.folder, color: Color(0xFF0074E4), size: 40),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Created: $date",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileCard(String fileName, String location) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.insert_drive_file, color: Colors.grey, size: 40),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5),
              Text(
                location,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }
}
