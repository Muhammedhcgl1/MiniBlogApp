//  showDialog(
//           ignore: use_build_context_synchronously
//           context: context,
//           builder: (context) => AlertDialog(
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pushReplacement(MaterialPageRoute(
//                             builder: (context) => const Homepage()));
//                       },
//                       child: const Text("Tamam"))
//                 ],
//                 title: const Text("Başarılı!"),
//                 content: Text(
//                     "${widget.postModel.title} adlı Postu Silme İşlemi Başarılı"),
//               ));