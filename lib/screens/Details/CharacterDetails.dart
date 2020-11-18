import 'package:flutter/material.dart';

class CharacterDetails extends StatefulWidget {
  final int id;
  CharacterDetails({this.id});

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  List<String> names = [
    "Ichi-nii",
    "Shinigami Daiko (Substitute Soul Reaper)",
    "Itsygo",
    "Ryoka Boy"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://cdn.myanimelist.net/images/characters/3/89190.jpg',
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Ichigo Kurosaki",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nicknames",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 5,
                children: names
                    .map(
                      (e) => Chip(
                        label: Text(e),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Race: Human, Shinigami, \\n\r\nBirthday: July 15 (Cancer)\\n\r\nAge: 15 (beginning); 17 (currently)\\n\r\nHeight: 174->181 cm\\n\r\nWeight: 61->66 kg\\n\r\nKnown Relatives: Isshin Kurosaki (father), Masaki Kurosaki (mother, deceased), Yuzu Kurosaki (younger sister), Karin Kurosaki (younger sister),  \\n\r\nTheme Songs: \"Number One\" by Hazel Fernandes, \"News From the Front\" by Bad Religion\\n\r\n\\n\r\nFor the most part, Ichigo appears like a normal teenage boy, the one exception to that is his spiky, orange hair, a trait which he has been ridiculed about for years. He is a fairly tall, and lean-built person with peach skin and brown eyes. Since becoming a Shinigami, he has become noticeably more muscular, as noted by his sister Karin. When in his spiritual form, Ichigo wears standard Shinigami attire with the addition of a strap across his chest.\\n\r\n\\n\r\nWhen he was young, Ichigo considered his mother to be the center of his world. Ichigo always smiled whenever he was with Masaki and he was regularly at her side, holding her hand.\\n\r\n\\n\r\nAs a teenager, Ichigo's personality is much more complex. Stubborn, short-tempered, occasionally confrontational, determined, outspoken, strong-willed and impulsive, he attempts to maintain a detached and \"cool\" image, despite claiming to not care about what other people think about him. He generally keeps his face set in a permanent scowl with his eyebrows drawn together. Ichigo carries the burden of the real world and the spirit world (Soul Society), a task quite difficult, especially for a teenager like Ichigo, who has his own worries and problems. Also, Ichigo is quite smart; he was ranked 23rd in his high school. He does this partly to prove to his teachers and classmates that just because he's unique, or somewhat punkish, that he can still succeed.\\n\r\n\\n\r\nWhen Ichigo first becomes a Shinigami, his Zanpakutō is a standard-looking katana, but oversized with an equally-oversized brown sheathe hung by a strap over his right shoulder. It has a rectangular bronze hand guard with gently inward-curved edges, a stylized flame pattern on the long sides, and a simple decorative slit on the short ones. The handle is red with two light blue tassels on the end of the handle. The large size is due to the unfocused but immense amount of Ichigo's spiritual power, which he didn't know how to control. As a result, the sword itself was rather weak, since very little spiritual power was used to create it. Nevertheless, it was powerful enough to subdue a Gillian-class Menos and lesser Hollows, completely blocking a Cero from the former. It was even able to upturn the ground with a single strike. Because of its weak spiritual energy nature, Byakuya Kuchiki was able to easily cut off most of the blade during his first encounter with Ichigo and Kisuke Urahara subsequently slices it down to the hilt during their training, forcing Ichigo to learn the name of his Zanpakutō in order to release its true form. This sword is found to be a result of Rukia's deprived spiritual energy and not a result of his own power.\\n\r\n\\n\r\n\\n\\n"
                    .replaceAll("\\n", "\n"),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
