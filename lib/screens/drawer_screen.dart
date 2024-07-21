import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Number',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 30,
            ),
            title: const Text('title'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 30,
            ),
            title: const Text('title'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 30,
            ),
            title: const Text('title'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 30,
            ),
            title: const Text('title'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 30,
            ),
            title: const Text('title'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 30,
            ),
            title: const Text('title'),
          ),
          const Spacer(),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.circle,
              color: Colors.red,
              size: 30,
            ),
            title: const Text('title'),
          )
        ],
      ),
    );
  }
}
