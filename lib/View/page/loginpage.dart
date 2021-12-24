import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:togetor/Controller/Provider/info.dart';
import 'package:togetor/View/ui/tgt_side_bar.dart';
import 'package:togetor/View/ui/tgttop_bar.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void initState() {
    super.initState();
    KakaoContext.clientId = "ee04c3023a33e8b16b5b785938961ad4";
    print("login page hello");
  }

  Future<void> naverlogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    print('--------------------------------------------');
    print(res.account.runtimeType);
    print(res.runtimeType);

    // print(await FlutterNaverLogin.currentAccessToken);

    // var b = res.account;
    // print(b);
    // var c = b.toJson();
    // print(c.runtimeType);
    // var d = NaverAccountResult.fromJson(c);
    // print(d.runtimeType);
    // print(d);

    context.read<LoginINFO>().LOGIN_naver(res.account);
    print(context.read<LoginINFO>().naverINFO);
  }

  Future<void> naverlogout() async {
    FlutterNaverLogin.logOut();
    context.read<LoginINFO>().LOGOUT_naver(null);
    print(context.read<LoginINFO>().naverINFO);
    // print(await FlutterNaverLogin.currentAccessToken);

  }

  void kakaologin() async {
    try {
      final installed = await isKakaoTalkInstalled();
      installed ? await UserApi.instance.loginWithKakaoTalk() : await UserApi.instance.loginWithKakaoAccount();
      // perform actions after login
      User user = await UserApi.instance.me();
      context.read<LoginINFO>().LOGIN_kakao(user);
      print(context.read<LoginINFO>().kakaoINFO);

    } catch (e) {
      print('error on login: $e');
    }
  }


  void kakaologout() async {
    try {
      await UserApi.instance.logout();
      context.read<LoginINFO>().LOGOUT_kakao(null);
      print(context.read<LoginINFO>().kakaoINFO);
    } catch (e) {
      print('error on login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const key5 = Key('key5');
    return Scaffold(
      key: key5,
      // endDrawer: TGTSideBar(),
      appBar: TGTtop_bar(appBar: AppBar(), title: "Login page", key: key5),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // 로그인 배너 네이버랑 카카오 정밀하게 맞추려면 이미지 말고 위젯으로 따로 만들어야 할 듯
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    print("naver login");
                    naverlogin();
                  },
                  child: Image.asset(
                    'images/btnG_완성형.png',
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    // fixedSize: Size.fromWidth(1)
                  ),
                  onPressed: () {
                    print("kakao login");
                    kakaologin();
                  },
                  child: Image.asset(
                    'images/kakao_login_medium_narrow.png',
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                        onPressed:(){
                          print("naver logout");
                          naverlogout();
                        },
                        style: OutlinedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text("naver logout")),
                    OutlinedButton(
                        onPressed:(){
                          print("kakao logout");
                          kakaologout();
                        },
                        style: OutlinedButton.styleFrom(
                            primary: Colors.amber
                        ),
                        child: Text("kakao logout"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
