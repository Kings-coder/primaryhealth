import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/blog_controller.dart';

class BlogPage extends GetView<BlogController> {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlogPage'),
      ),
      body: const SafeArea(
        child: Center(
            child: Text(
          'Coming soon',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
