import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:togetor/Controller/GoogleMapService/map_bloc.dart';
import 'package:togetor/Controller/Provider/info.dart';
import 'package:togetor/View/ui/tgtbutton.dart';
import '../ui/tgt_side_bar.dart';
import '../ui/tgttop_bar.dart';
import '../page/tgt_placepicker_page.dart';
//import 'package:together/src/Provider/counter_Provider.dart';
//import 'package:togetor/Controller/Provider/counter_provider.dart';
import '../../Controller/Provider/counter_provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (BuildContext context) => CountProvider()),
//       ],
//       child: add(),
//     ),
//   );
// }
class Add extends StatefulWidget {
  final String? location;
  Add({Key? key, this.location}) : super(key: key);
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  XFile? _contentImage;

  final TextEditingController _title = new TextEditingController();
  final TextEditingController _detail = new TextEditingController();
  final _valueList = ['FOOD', 'PRACTICE', 'GOODS', 'ETC'];
  var _selectedValue;
  //_place 추가하기
  late DateTime _limitedDate = new DateTime.now();
  late CountProvider _maxparticipant;
  final key2 = const Key('key2');

  @override
  Widget build(BuildContext context) {
    _maxparticipant = Provider.of<CountProvider>(context);

    Future pickImage(ImageSource source) async {
      try {
        final _contentImage = await ImagePicker().pickImage(source: source);
        setState(() => this._contentImage = _contentImage);
        if (_contentImage == null) return;
      } on PlatformException catch (e) {
        print('Failed to pick Image : $e');
      }
    }

    Future apitest(XFile? image) async{
      Dio dio = Dio();
      dio.options.baseUrl = 'http://192.168.11.101:4000';

      NaverAccountResult? naverlogin;
      User? kakaologin;
      if(context.read<LoginINFO>().naverINFO?.id != ""){
        naverlogin = context.read<LoginINFO>().naverINFO;
      }else{
        print("kakao");
        kakaologin = context.read<LoginINFO>().kakaoINFO;
      }
      var formData = FormData.fromMap({
        'title': "${_title.text}",
        'detail': "${_detail.text}",
        'selectedValue': "${_selectedValue}",
        'deadline': _limitedDate != null ? "${_limitedDate}" : "",
        'login': naverlogin != null ? naverlogin.id : kakaologin?.id,
        'userlimit': "${context.read<CountProvider>().count}",
        'place': widget.location != null ? widget.location : "",
      });
      formData.files.addAll([
        MapEntry('one',
          MultipartFile.fromFileSync('${image!.path}'), //,filename: '${image!.name}1'
        ),
      ]);
      print(formData.runtimeType);
      var response = await dio.post('/iproduct_mobile', data:formData);
      print(response);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key : key2,
      endDrawer:TGTSideBar(),
      appBar: TGTtop_bar(key: key2, appBar: AppBar(), title: "등록 페이지"),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              _contentImage != null
                  ? Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(File(_contentImage!.path))
                  ),
                ),
              )
                  : IconButton(
                icon : Icon(Icons.add_photo_alternate),
                color: Colors.grey,
                iconSize: 100,
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          title: Text(
                            'Add picture', style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          children: <Widget>[
                            SimpleDialogOption(
                              child: Text('사진 찍기',
                                  style: TextStyle(color: Colors.black)),
                              onPressed : () => pickImage(ImageSource.camera),
                            ),


                            SimpleDialogOption(
                              child: Text('사진 가져오기',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () => pickImage(ImageSource.gallery),
                            ),
                            SimpleDialogOption(
                              child: Text('취소',
                                  style: TextStyle(color: Colors.grey)),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      }
                  ); },
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller : _title,
                  decoration: InputDecoration(
                      labelText: '제목을 입력해주세요',
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _detail,
                  decoration: InputDecoration(
                      labelText: '상세내용을 입력해주세요',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton(
                    hint: Text('카테고리'),
                    value: _selectedValue,
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
              ),
              TextButton(
                child: Text('위치선택'),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MapScreen()));
                },
              ),
              TextButton(
                child: Text('날짜선택'),
                onPressed: (){
                  Future<DateTime?> selectedDate = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2025),
                    builder: (BuildContext context, Widget? child){
                      return Theme(
                        data: ThemeData.light(),
                        child: child!,
                      );
                    },
                  );
                  selectedDate.then((dateTime){
                    setState((){
                      _limitedDate = dateTime!;
                    });
                  });
                },
              ),
              Text('${_limitedDate.year}/${_limitedDate.month}/${_limitedDate.day}', style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('인원수'),
                  Text(Provider.of<CountProvider>(context).count.toString()),
                  IconButton(onPressed: () {
                    _maxparticipant.add();
                  },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(onPressed: () {
                    _maxparticipant.remove();
                  },
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
              TGTButton(
                child: const Icon(
                  Icons.upload,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  apitest(_contentImage);
                },
              )
            ],
          )
      ),
    );
  }
}
