import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:atoi/utils/http_request.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:atoi/pages/equipments/print_qrcode.dart';
import 'package:atoi/widgets/build_widget.dart';
import 'package:atoi/pages/equipments/equipment_detail.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atoi/pages/manager/manager_complete_page.dart';
import 'package:atoi/models/models.dart';

/// 设备列表页面类
class EquipmentsList extends StatefulWidget{
  _EquipmentsListState createState() => _EquipmentsListState();
}

class _EquipmentsListState extends State<EquipmentsList> {

  List<dynamic> _equipments = [];

  List<Step> timeline = [];

  bool isSearchState = false;
  bool _loading = false;
  bool _editable = true;
  ConstantsModel cModel;

  TextEditingController _keywords = new TextEditingController();
  String searchFilter = 'e.ID';
  TextEditingController _deviceName = new TextEditingController();
  TextEditingController _deviceCode = new TextEditingController();
  List machineStatusList = [];
  int machineStatusId = 0;
  int warrantyId = 0;
  List departmentList = [];
  int departmentId = 0;
  bool usageStatus = false;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Null> getRole() async {
    var _prefs = await prefs;
    var _role = _prefs.getInt('role');
    _editable = _role==1?true:false;
  }

  List initList(Map _map) {
    List _list = [];
    _list.add({
      'value': 0,
      'text': '全部'
    });
    _map.forEach((key, val) {
      _list.add({
        'value': val,
        'text': key
      });
    });
    return _list;
  }
  
  void initFilter() async {
    setState(() {
      machineStatusList = initList(cModel.EquipmentStatus);
      machineStatusId = machineStatusList[0]['value'];
      departmentList = initList(cModel.Departments);
      departmentId = departmentList[0]['value'];
      warrantyId = 0;
      _keywords.clear();
      _deviceCode.clear();
      _deviceName.clear();
      usageStatus = false;
      searchFilter = 'e.ID';
    });
  }

  void setFilter() async {
    //do some stuff
    await getEquipments();
  }

  Future<Null> getEquipments({String filterText}) async {
    filterText = filterText??'';
    setState(() {
      _loading = true;
    });
    var resp = await HttpRequest.request(
      '/Equipment/Getdevices',
      method: HttpRequest.GET,
      params: {
        'filterText': _keywords.text,
        'status': machineStatusId,
        'warrantyStatus': warrantyId,
        'departmentID': departmentId,
        'filterTextName': _deviceName.text,
        'filterTextSerialCode': _deviceCode.text,
        'filterField': searchFilter,
        'useStatus': usageStatus
      }
    );
    setState(() {
      _loading = false;
    });
    if (resp['ResultCode'] == '00') {
      setState(() {
        _equipments = resp['Data'];
      });
    }
  }

  void showSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ListView(
            children: <Widget>[
              SizedBox(height: 18.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Text('搜索', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Container(
                      width: 230.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xfff2f2f2),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10.0,),
                          Icon(Icons.search, color: Color(0xffaaaaaa),),
                          SizedBox(width: 10.0,),
                          Container(
                              width: 150.0,
                              child: Align(
                                alignment: Alignment(0.0, -0.5),
                                child: TextField(
                                  decoration: InputDecoration.collapsed(hintText: ''),
                                  controller: _keywords,
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                  SizedBox(width: 16.0,),
                  Container(
                    width: 130.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xfff2f2f2),
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 6.0,),
                        DropdownButton(
                          value: searchFilter,
                          underline: Container(),
                          items: <DropdownMenuItem>[
                            DropdownMenuItem(
                              value: 'e.ID',
                              child: Text('系统编号'),
                            ),
                            DropdownMenuItem(
                              value: 'e.AssetCode',
                              child: Text('资产编号'),
                            ),
                            DropdownMenuItem(
                              value: 'e.EquipmentCode',
                              child: Text('设备型号'),
                            ),
                          ],
                          onChanged: (val) {
                            setState(() {
                              searchFilter = val;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 18.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Text('设备名称', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Container(
                      width: 230.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xfff2f2f2),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10.0,),
                          Icon(Icons.search, color: Color(0xffaaaaaa),),
                          SizedBox(width: 10.0,),
                          Container(
                              width: 150.0,
                              child: Align(
                                alignment: Alignment(0.0, -0.5),
                                child: TextField(
                                  decoration: InputDecoration.collapsed(hintText: ''),
                                  controller: _deviceName,
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: 18.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Text('设备序列号', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Container(
                      width: 230.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xfff2f2f2),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10.0,),
                          Icon(Icons.search, color: Color(0xffaaaaaa),),
                          SizedBox(width: 10.0,),
                          Container(
                              width: 150.0,
                              child: Align(
                                alignment: Alignment(0.0, -0.5),
                                child: TextField(
                                  decoration: InputDecoration.collapsed(hintText: ''),
                                  controller: _deviceCode,
                                ),
                              )
                          ),
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: 18.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Text('设备状态', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Container(
                      width: 230.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xfff2f2f2),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 6.0,),
                          DropdownButton(
                            value: machineStatusId,
                            underline: Container(),
                            items: machineStatusList.map<DropdownMenuItem>((item) {
                              return DropdownMenuItem(
                                value: item['value'],
                                child: Text(item['text']),
                              );
                            }).toList(),
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                machineStatusId = val;
                              });
                            },
                          )
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: 18.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Text('科室', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Container(
                      width: 230.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xfff2f2f2),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 6.0,),
                          DropdownButton(
                            value: departmentId,
                            underline: Container(),
                            items: departmentList.map<DropdownMenuItem>((item) {
                              return DropdownMenuItem(
                                value: item['value'],
                                child: Text(item['text']),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                departmentId = val;
                              });
                            },
                          )
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: 18.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Text('维保状态', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Container(
                      width: 230.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Color(0xfff2f2f2),
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 6.0,),
                          DropdownButton(
                            value: warrantyId,
                            underline: Container(),
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: 0,
                                child: Text('全部'),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text('保外'),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('保内'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                warrantyId = val;
                              });
                            },
                          )
                        ],
                      )
                  ),
                ],
              ),
              SizedBox(height: 18.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Text('停用', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),)
                ],
              ),
              SizedBox(height: 6.0,),
              Row(
                children: <Widget>[
                  SizedBox(width: 16.0,),
                  Container(
                    width: 100.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xfff2f2f2),
                    ),
                    child: Center(
                      child: Switch(
                        value: usageStatus,
                        onChanged: (val) {
                          setState(() {
                            usageStatus = val;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          color: Color(0xff3394B9),
                          width: 1.0
                      ),
                      color: Color(0xffEBF9FF),
                    ),
                    child: Center(
                      child: FlatButton(onPressed: () {
                        setState(() {
                          machineStatusId = machineStatusList[0]['value'];
                          departmentId = departmentList[0]['value'];
                          searchFilter = 'e.ID';
                          warrantyId = 0;
                          _keywords.clear();
                          _deviceCode.clear();
                          _deviceName.clear();
                          usageStatus = false;
                        });
                        initFilter();
                      }, child: Text('重置')),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xff3394B9),
                    ),
                    child: Center(
                      child: FlatButton(onPressed: () {
                        setFilter();
                        Navigator.of(context).pop();
                      }, child: Text('确认', style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      );
    });
  }

  void initState() {
    super.initState();
    cModel = MainModel.of(context);
    initFilter();
    getEquipments();
    getRole();
  }

  Future<List<TimelineModel>> getTimeline(int deviceId) async {
    var resp = await HttpRequest.request(
      '/Equipment/GetTimeLine4App',
      method: HttpRequest.POST,
      data: {
        'id': deviceId
      }
    );
    if (resp['ResultCode'] == '00') {
      print(resp['Data']['Dispatches']);
      if (resp['Data']['Dispatches'] != null) {
        var _dispatches = resp['Data']['Dispatches'];
        List<TimelineModel> _timeline = [];
        for(var _item in _dispatches) {
          switch (_item['RequestType']['ID']) {
            case 1:
              _timeline.add(
                TimelineModel(
                  ListTile(
                    title: new Text(_item['TimelineDesc']),
                    subtitle: new Text(_item['EndDate'].split('T')[0]),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ManagerCompletePage(requestId: _item['RequestID']), ));
                    },
                  ),
                  icon: Icon(Icons.build, color: Colors.white,),
                  iconBackground: Colors.redAccent,
                  position: TimelineItemPosition.right
                )
              );
              break;
            case 3:
              _timeline.add(
                  TimelineModel(
                      ListTile(
                        title: new Text(_item['TimelineDesc']),
                        subtitle: new Text(_item['EndDate'].split('T')[0]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ManagerCompletePage(requestId: _item['RequestID']), ));
                        },
                      ),
                      icon: Icon(Icons.store, color: Colors.white,),
                      iconBackground: Colors.redAccent,
                      position: TimelineItemPosition.right
                  )
              );
              break;
            case 4:
              _timeline.add(
                  TimelineModel(
                      ListTile(
                        title: new Text(_item['TimelineDesc']),
                        subtitle: new Text(_item['EndDate'].split('T')[0]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ManagerCompletePage(requestId: _item['RequestID']), ));
                        },
                      ),
                      icon: Icon(Icons.people, color: Colors.white,),
                      iconBackground: Colors.green,
                      position: TimelineItemPosition.right
                  )
              );
              break;
            case 5:
              _timeline.add(
                  TimelineModel(
                      ListTile(
                        title: new Text(_item['TimelineDesc']),
                        subtitle: new Text(_item['EndDate'].split('T')[0]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ManagerCompletePage(requestId: _item['RequestID']), ));
                        },
                      ),
                      icon: Icon(Icons.remove_red_eye, color: Colors.white,),
                      iconBackground: Colors.green,
                      position: TimelineItemPosition.right
                  )
              );
              break;
            case 2:
              _timeline.add(
                  TimelineModel(
                      ListTile(
                        title: new Text(_item['TimelineDesc']),
                        subtitle: new Text(_item['EndDate'].split('T')[0]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => ManagerCompletePage(requestId: _item['RequestID']), ));
                        },
                      ),
                      icon: Icon(Icons.assignment_turned_in, color: Colors.white,),
                      iconBackground: Colors.green,
                      position: TimelineItemPosition.right
                  )
              );
              break;
            default:
              _timeline.add(
                  TimelineModel(
                      ListTile(
                        title: new Text(_item['TimelineDesc']),
                        subtitle: new Text(_item['EndDate'].split('T')[0]),
                        onTap: () {
                          if (_item['RequestType']['ID'] != 0) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ManagerCompletePage(requestId: _item['RequestID']), ));
                          }
                        },
                      ),
                      icon: Icon(Icons.check, color: Colors.white,),
                      iconBackground: Colors.grey,
                      position: TimelineItemPosition.right
                  )
              );
          }
        }
        return _timeline;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Card buildEquipmentCard(Map item) {
    return new Card(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            leading: IconButton(
              icon: Icon(Icons.desktop_mac, size: 36.0, color: Colors.green,),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new EquipmentDetail(editable: false, equipment: item,)));
              },
            ),
            title: Text(
              "设备名称：${item['Name']}",
              style: new TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).primaryColor
              ),
            ),
            subtitle: Text(
              "系统编号：${item['OID']}",
              style: new TextStyle(
                  color: Theme.of(context).accentColor
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                BuildWidget.buildCardRow('资产编号', item['AssetCode']),
                BuildWidget.buildCardRow('设备型号', item['EquipmentCode']),
                BuildWidget.buildCardRow('序列号', item['SerialCode']),
                BuildWidget.buildCardRow('厂商', item['Manufacturer']['Name']),
                BuildWidget.buildCardRow('资产等级', item['AssetLevel']['Name']),
                BuildWidget.buildCardRow('使用科室', item['Department']['Name']),
                BuildWidget.buildCardRow('设备状态', item['EquipmentStatus']['Name']),
                BuildWidget.buildCardRow('维保状态', item['WarrantyStatus']),
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new RaisedButton(
                onPressed: (){
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                    return new PrintQrcode(equipmentId: item['ID'],);
                  }));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: new Color(0xff2E94B9),
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.widgets,
                      color: Colors.white,
                    ),
                    new Text(
                      '二维码',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ),
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
              ),
              new RaisedButton(
                onPressed: (){
                  setState(() {
                    isSearchState = false;
                    _keywords.clear();
                  });
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                    return new EquipmentDetail(equipment: item, editable: _editable,);
                  })).then((result) => getEquipments());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: new Color(0xff2E94B9),
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      _editable?Icons.edit:Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                    new Text(
                      _editable?'编辑':'查看',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ),
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
              ),
              new RaisedButton(
                onPressed: () async {
                  List<TimelineModel> _steps = await getTimeline(item['ID']);
                  if (_steps.length > 0) {
                    showDialog(context: context,
                        builder: (context) => SimpleDialog(
                          title: new Text('生命周期'),
                          children: <Widget>[
                            new Container(
                              width: 300.0,
                              height: _steps.length*80.0,
                              child: Timeline(
                                children: _steps,
                                position: TimelinePosition.Left,
                              )
                            ),
                          ],
                        )
                    );
                  } else {
                    showDialog(context: context, builder: (context) => AlertDialog(title: new Text('暂无事件'),));
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: new Color(0xff2E94B9),
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.replay,
                      color: Colors.white,
                    ),
                    new Text(
                      '生命周期',
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: isSearchState?TextField(
            controller: _keywords,
            style: new TextStyle(
              color: Colors.white
            ),
            decoration: new InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white,),
              hintText: '请输入设备名称/型号/序列号',
              hintStyle: new TextStyle(color: Colors.white)
            ),
            onChanged: (val) {
              getEquipments(filterText: val);
            },
          ):Text('设备列表'),
          elevation: 0.7,
          actions: <Widget>[
            isSearchState?IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                //setState(() {
                //  isSearchState = false;
                //});
                showSheet(context);
              },
            ):IconButton(icon: Icon(Icons.search), onPressed: () {
              //setState(() {
              //  isSearchState = true;
              //});
              showSheet(context);
            })
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ],
              ),
            ),
          ),
        ),
        body: _loading?new Center(child: new SpinKitThreeBounce(color: Colors.blue,),):(_equipments.length==0?Center(child: Text('无设备'),):new ListView.builder(
          itemCount: _equipments.length,
          itemBuilder: (context, i) {
            return buildEquipmentCard(_equipments[i]);
          },
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
              return new EquipmentDetail(editable: true,);
            })).then((result) => getEquipments());
          },
          child: Icon(Icons.add_circle),
          backgroundColor: Colors.blue,
        ),
    );
  }
}