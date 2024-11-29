import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/solar_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    var providerTrue = Provider.of<SolarProvider>(context);
    var providerfalse = Provider.of<SolarProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/night.jpg'),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35.0, left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xffC9C9C9)),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Color(0xffC9C9C9),
                  ),
                ),
              ),
            ),
            (providerTrue.favoutiteList.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: providerTrue.favoutiteList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shadowColor: Colors.white,
                                      elevation: 6,
                                      backgroundColor: Colors.black,
                                      title: Text(
                                        'Delete Planet',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: Text(
                                        'Do You Want To Delete !',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancle',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              providerfalse
                                                  .removeFavourite(index);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ))
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 52,
                                  width: 52,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      color: Colors.cyan,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    size: 30,
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 140,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.4),
                                      Colors.white.withOpacity(0.1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Planet Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Image.asset(
                                        providerTrue.favoutiteList[index].image,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Planet Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            providerTrue
                                                .favoutiteList[index].name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            providerTrue.favoutiteList[index]
                                                .description,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white70,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 290.0, ),
                      child: Text(
                        textAlign: TextAlign.center,
                        'No Add Favourite Data Currently',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
