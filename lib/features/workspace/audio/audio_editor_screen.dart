import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

// class AudioEditorScreen extends StatelessWidget {
//   const AudioEditorScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AudioEditorBloc(),
//       child: BlocBuilder<AudioEditorBloc, AudioEditorState>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Audio Editor'),
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const Text('Audio Editor'),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class AudioEditorView extends StatelessWidget {
  const AudioEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioEditorCubit(),
      child: BlocBuilder<AudioEditorCubit, AudioEditorState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Audio Editor'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Audio Editor'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
