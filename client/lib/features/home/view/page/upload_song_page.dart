import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/utils.dart';
import 'package:music_app/core/widgets/custom_field.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:music_app/core/widgets/loader.dart';
import 'package:music_app/features/home/repository/home_repository.dart';
import 'package:music_app/features/home/view/widgets/audio_wave.dart';
import 'package:music_app/features/home/view_model/home_view_model.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({Key? key}) : super(key: key);

  @override
  _UploadSongPageState createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey<FormState>();

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      // Do something with the Audio
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      // Do something with the image
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void dispose() {
    songNameController.dispose();
    artistNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      homeViewModelProvider.select((val) => val?.isLoading == true),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Song'),
        actions: [
          IconButton(
            onPressed: () async {
              // await HomeRepository().uploadSong(selectedImage!, selectedAudio!);
              if (formKey.currentState!.validate() &&
                  selectedAudio != null &&
                  selectedImage != null) {
                ref
                    .read(homeViewModelProvider.notifier)
                    .uploadSong(
                      selectedAudio: selectedAudio!,
                      selectedThumbnail: selectedImage!,
                      songName: songNameController.text,
                      artist: artistNameController.text,
                      selectedColor: selectedColor,
                    );
              } else {
                showSnackbar(context, ' One or more fields are missing');
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body:
          isLoading
              ? const Loader()
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: selectImage,
                            child:
                                selectedImage != null
                                    ? SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          selectedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                    : DottedBorder(
                                      color: Pallete.borderColor,
                                      dashPattern: [10, 4],
                                      strokeWidth: 1,
                                      strokeCap: StrokeCap.round,
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(12),
                                      padding: EdgeInsets.all(6),
                                      child: SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.folder_open, size: 40),
                                              const SizedBox(height: 10),
                                              Text(
                                                'Select the thumbnail for your song',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                          ),
                          const SizedBox(height: 40),
                          selectedAudio != null
                              ? AudioWave(path: selectedAudio!.path)
                              : CustomField(
                                hintText: 'Select a Song',
                                controller: null,
                                readOnly: true,
                                onTap: selectAudio,
                              ),
                          const SizedBox(height: 20),
                          CustomField(
                            hintText: 'Song Artist',
                            controller: artistNameController,
                            // readOnly: true,
                            // onTap: () {},
                          ),
                          const SizedBox(height: 20),
                          CustomField(
                            hintText: 'Song Title',
                            controller: songNameController,
                            // readOnly: true,
                            // onTap: () {},
                          ),
                          const SizedBox(height: 20),
                          ColorPicker(
                            color: selectedColor,
                            pickersEnabled: {ColorPickerType.wheel: true},
                            onColorChanged: (Color color) {
                              setState(() {
                                selectedColor = color;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
    );
  }
}
