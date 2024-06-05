import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app_2/controller/sectonController.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SectionController _sectionController = Get.put(SectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: const Color(0xff535FF7),
        centerTitle: true,
        title: const Text(
          'Section task App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() => _sectionController.isLoading.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
          itemCount: _sectionController.allSections.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      color: const Color.fromRGBO(205, 213, 223, 1),
                      width: 1.0)),
              child: Center(
                child: Text(
                  _sectionController.allSections[index].sectionTitle,
                  style: const TextStyle(
                    color: Color.fromRGBO(76, 85, 102, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            );
          })),
    );
  }
}