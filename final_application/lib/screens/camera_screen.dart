import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isPictureTaken = false;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      
      if (cameras.isEmpty) {
        setState(() {
          _errorMessage = "Камеры не найдены";
          _isLoading = false;
        });
        return;
      }

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller.initialize();
      
      setState(() {
        _isLoading = false;
        _isCameraInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Ошибка инициализации: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized) return;

    try {
      final image = await _controller.takePicture();
      
      setState(() {
        _isPictureTaken = true;
      });

      
      Navigator.pop(context, image.path);
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка снимка: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _buildBody(),
      floatingActionButton: _isCameraInitialized && !_isPictureTaken
          ? FloatingActionButton(
              onPressed: _takePicture,
              child: const Icon(Icons.camera),
            )
          : null,
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Назад'),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        if (_isCameraInitialized) CameraPreview(_controller),
        if (_isPictureTaken)
          Container(
            color: Colors.black.withOpacity(0.6),
            child: const Center(
              child: Icon(Icons.check_circle_outline, 
                color: Colors.green, 
                size: 80),
            ),
          ),
      ],
    );
  }
}
