import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_constants.dart';
import '../../../data/models/pet_model.dart';
import '../../../data/providers/api_provider.dart';

class AddPetController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final breedController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final colorController = TextEditingController();
  final behaviorNotesController = TextEditingController();
  final medicalNotesController = TextEditingController();
  final vetNameController = TextEditingController();
  final vetPhoneController = TextEditingController();
  final vetAddressController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final emergencyPhoneController = TextEditingController();

  final selectedSize = PetSize.medium.obs;
  final isLoading = false.obs;

  final PetModel? editingPet = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (editingPet != null) {
      _populateFields();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    breedController.dispose();
    ageController.dispose();
    weightController.dispose();
    colorController.dispose();
    behaviorNotesController.dispose();
    medicalNotesController.dispose();
    vetNameController.dispose();
    vetPhoneController.dispose();
    vetAddressController.dispose();
    emergencyContactController.dispose();
    emergencyPhoneController.dispose();
    super.onClose();
  }

  void _populateFields() {
    final pet = editingPet!;
    nameController.text = pet.name;
    breedController.text = pet.breed;
    ageController.text = pet.age.toString();
    weightController.text = pet.weight.toString();
    colorController.text = pet.color ?? '';
    behaviorNotesController.text = pet.behaviorNotes ?? '';
    medicalNotesController.text = pet.medicalNotes ?? '';
    vetNameController.text = pet.vetName ?? '';
    vetPhoneController.text = pet.vetPhone ?? '';
    vetAddressController.text = pet.vetAddress ?? '';
    emergencyContactController.text = pet.emergencyContact ?? '';
    emergencyPhoneController.text = pet.emergencyPhone ?? '';
    selectedSize.value = pet.size;
  }

  void selectSize(PetSize size) {
    selectedSize.value = size;
  }

  Future<void> savePet() async {
    if (!formKey.currentState!.validate()) {
      print('Form validation failed');
      return;
    }

    try {
      isLoading.value = true;
      print('Starting to save pet...');

      final petData = {
        'name': nameController.text.trim(),
        'breed': breedController.text.trim(),
        'age': int.parse(ageController.text),
        'size': selectedSize.value.name,
        'weight': double.parse(weightController.text),
        'color': colorController.text.trim().isEmpty
            ? null
            : colorController.text.trim(),
        'behaviorNotes': behaviorNotesController.text.trim().isEmpty
            ? null
            : behaviorNotesController.text.trim(),
        'medicalNotes': medicalNotesController.text.trim().isEmpty
            ? null
            : medicalNotesController.text.trim(),
        'vetName': vetNameController.text.trim().isEmpty
            ? null
            : vetNameController.text.trim(),
        'vetPhone': vetPhoneController.text.trim().isEmpty
            ? null
            : vetPhoneController.text.trim(),
        'vetAddress': vetAddressController.text.trim().isEmpty
            ? null
            : vetAddressController.text.trim(),
        'emergencyContact': emergencyContactController.text.trim().isEmpty
            ? null
            : emergencyContactController.text.trim(),
        'emergencyPhone': emergencyPhoneController.text.trim().isEmpty
            ? null
            : emergencyPhoneController.text.trim(),
      };

      print('Pet data prepared: $petData');

      if (editingPet != null) {
        print('Updating existing pet...');
        await _apiProvider.updatePet(editingPet!.id, petData);
        print('Pet updated successfully');
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: 'Pet updated successfully',
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Get.back();
      } else {
        print('Creating new pet...');
        await _apiProvider.createPet(petData);
        print('Pet created successfully');
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Success',
            message: AppConstants.petAddedSuccessMessage,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        print('About to navigate back...');
        Get.offNamed('/pets');
      }
    } catch (e) {
      print('Error saving pet: $e');
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message:
              editingPet != null ? 'Failed to update pet' : 'Failed to add pet',
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
      print('Save pet operation completed');
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pet name is required';
    }
    return null;
  }

  String? validateBreed(String? value) {
    if (value == null || value.isEmpty) {
      return 'Breed is required';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 0 || age > 30) {
      return 'Please enter a valid age (0-30)';
    }
    return null;
  }

  String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return 'Weight is required';
    }
    final weight = double.tryParse(value);
    if (weight == null || weight <= 0) {
      return 'Please enter a valid weight';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(AppConstants.phonePattern).hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }
}
