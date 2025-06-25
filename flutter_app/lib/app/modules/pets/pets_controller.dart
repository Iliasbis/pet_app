import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/pet_model.dart';
import '../../data/providers/api_provider.dart';
import '../../routes/app_routes.dart';

class PetsController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  final pets = <PetModel>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPets();
  }

  List<PetModel> get filteredPets {
    if (searchQuery.value.isEmpty) {
      return pets;
    }
    return pets
        .where((pet) =>
            pet.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            pet.breed.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> loadPets() async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getPets();
      final petList = (response.data as List)
          .map((json) => PetModel.fromJson(json))
          .toList();
      pets.value = petList;
    } catch (e) {
      print('Error loading pets: $e');
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: 'Failed to load pets: \n$e',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToAddPet() {
    Get.toNamed(AppRoutes.addPet)?.then((_) => loadPets());
  }

  void editPet(PetModel pet) {
    Get.toNamed(AppRoutes.editPet, arguments: pet)?.then((_) => loadPets());
  }

  Future<void> deletePet(PetModel pet) async {
    try {
      final confirmed = await Get.dialog<bool>(
            AlertDialog(
              title: const Text('Delete Pet'),
              content: Text('Are you sure you want to delete ${pet.name}?'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ) ??
          false;

      if (confirmed) {
        await _apiProvider.deletePet(pet.id);
        pets.removeWhere((p) => p.id == pet.id);
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: 'Pet deleted successfully',
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'Failed to delete pet',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
