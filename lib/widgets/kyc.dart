import 'package:flutter/material.dart';

class KYC extends StatefulWidget {
  const KYC({Key? key}) : super(key: key);

  @override
  _KYCState createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('KYC'),
      ),
      body: Center(
        child: Stepper(
          steps: [
            Step(
              title: const Text('Step 1'),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
              content: const Text('This is the first step.'),
            ),
            Step(
              title: const Text('Step 2'),
              isActive: _currentStep >= 1,
              state:
                  _currentStep >= 1 ? StepState.complete : StepState.disabled,
              content: const Text('This is the second step.'),
            ),
            Step(
              title: const Text('Step 3'),
              isActive: _currentStep >= 2,
              state:
                  _currentStep >= 2 ? StepState.complete : StepState.disabled,
              content: const Text('This is the third step.'),
            ),
          ],
          onStepTapped: (int newIndex) {
            setState(() {
              _currentStep = newIndex;
            });
          },
          currentStep: _currentStep,
          onStepContinue: () {
            setState(() {
              if (_currentStep != 2) {
                _currentStep += 1;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep != 0) {
                _currentStep -= 1;
              }
            });
          },
        ),
      ),
    );
  }
}
