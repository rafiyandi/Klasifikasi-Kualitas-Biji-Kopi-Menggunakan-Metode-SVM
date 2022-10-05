import 'package:flutter/material.dart';
import 'package:kopi/ui/pages/profile/custom_biodata.dart';
import 'package:kopi/ui/pages/profile/custom_sosial_media.dart';
import 'package:kopi/ui/style/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget backgroundProfile() {
      return Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/image_background2.png"))),
      );
    }

    Widget sosialMedia() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomSosialMedia(
              imgUrl: "assets/icon/icon_instagram.png",
              text: "Instagram",
            ),
            Container(
              width: 2,
              height: 30,
              color: kWhiteColor,
            ),
            CustomSosialMedia(
              imgUrl: "assets/icon/icon_linkedin.png",
              text: "Instagram",
            ),
          ],
        ),
      );
    }

    Widget profileImage() {
      return Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              padding: EdgeInsets.all(8),
              width: 150,
              height: 150,
              decoration:
                  BoxDecoration(color: kWhiteColor, shape: BoxShape.circle),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kGreyColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/image/image_prayoga1.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "ARIF BUDI PRAYOGA",
              style:
                  kWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
            ),
            Text(
              "Senior Software Engineer",
              style: kWhiteTextStyle.copyWith(
                  fontWeight: medium, fontSize: 16, color: kBackgroundColor),
            ),
            sosialMedia()
          ],
        ),
      );
    }

    Widget biodata() {
      return Column(
        children: [
          CustomBiodata(
              imgUrl: "assets/icon/icon_email.png",
              title: "Email",
              text: "arif.180170155@mhs.unimal.ac.id"),
          CustomBiodata(
              imgUrl: "assets/icon/icon_phone.png",
              title: "Mobile",
              text: "+62 822-7565-5041"),
          CustomBiodata(
              imgUrl: "assets/icon/icon_location.png",
              title: "Tempat Lahir",
              text: "Takengon"),
          CustomBiodata(
              imgUrl: "assets/icon/icon_date.png",
              title: "Tanggal Lahir",
              text: "25 April 2000"),
          CustomBiodata(
              imgUrl: "assets/icon/icon_judul.png",
              title: "Judul Skripsi",
              text:
                  "Klasifikasi Kualitas Cutra Biji Kopi Arabika Berdasarkan Tekstur Dan Warna Dengan Menggunakan Metode Svm"),
          SizedBox(
            height: 100,
          ),
        ],
      );
    }

    Widget content() {
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [biodata()],
          ),
        ),
      );
    }

    Widget customProfile(Widget profileImage()) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kWhiteColor,
            title: Center(
              child: Text(
                "Profile",
                style: kWhiteTextStyle.copyWith(fontWeight: semiBold),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: Center(
                  child: Text(
                    "Biodata",
                    style: blackTextStyle.copyWith(
                        fontWeight: semiBold, fontSize: 16),
                  ),
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: [
                Image.asset(
                  "assets/image/image_background2.png",
                  fit: BoxFit.cover,
                  height: 400,
                ),
                profileImage(),
              ],
            )),
          ),
          content()
        ],
      );
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: customProfile(profileImage),
    );
  }
}
