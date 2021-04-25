import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container();
}

// class OrderInquiryState extends State<OrderInquiryPage> {
//   String confirmDate = '';
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (context) => OrderInquiryManager(),
//         child: Consumer(
//           builder: (BuildContext context,
//               OrderInquiryManager orderInquiryManager, child) {
//             return Scaffold(
//               backgroundColor: Color(0xFFF7F7F7),
//               appBar: AppBar(
//                 backgroundColor: Color(0xFFFFFFFF),
//                 brightness: Brightness.light,
//                 elevation: 0.0,
//                 toolbarHeight: 50.0,
//                 title: Text(
//                   '订单查询',
//                   style: OrderInquiryTextStyle().titleText,
//                 ),
//                 centerTitle: true,
//                 leading: IconButton(
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: Color(0xA3000000),
//                     size: 20,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context); // 关闭当前页面
//                   },
//                 ),
//               ),
//               body: _bodyContainer(orderInquiryManager),
//             );
//           },
//         ));
//   }
//
//   Widget _bodyContainer(orderInquiryManager) {
//     int allPassengerNum = 0;
//     orderInquiryManager.orderInquiryList.forEach((element) {
//       allPassengerNum = allPassengerNum + element['passengerNum'];
//     });
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _selectDataView(orderInquiryManager),
//           Container(
//             padding: const EdgeInsets.only(left: 16.0, top: 13.0, bottom: 10.0),
//             child: Text(
//                 "共${orderInquiryManager.orderInquiryLength}笔订单，$allPassengerNum人次",
//                 style: OrderInquiryTextStyle().orderNumText),
//           ),
//           _mainListView(orderInquiryManager),
//         ],
//       ),
//     );
//   }
//
//   Widget _selectDataView(orderInquiryManager) {
//     return GestureDetector(
//       onTap: () {
//         DatePicker.showDatePicker(context,
//             showTitleActions: true,
//             minTime: DateTime(2019, 3, 5),
//             maxTime: orderInquiryManager.ymdDateTime, onChanged: (date) {
//               print('change $date');
//             }, onConfirm: (date) {
//               print('confirm $date');
//               confirmDate = formatDate(date, [yyyy, '年', mm, '月', dd, '日']);
//               orderInquiryManager
//                   .orderInquiryData(formatDate(date, [yyyy, '-', mm, '-', dd]),
//                   formatDate(date, [yyyy, '-', mm, '-', dd]))
//                   .then((orderInquiryDataValue) {
//                 if (orderInquiryDataValue) {
//                   orderInquiryManager.notifyListeners();
//                 }
//               });
//             }, currentTime: DateTime.now(), locale: LocaleType.zh);
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Container(
//               height: 0.5,
//               color: Color(0xFFF4F4F4),
//             ),
//             Container(
//                 padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//                 color: Color(0xFFFFFFFF),
//                 height: 50.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       child: Text(
//                           confirmDate == ''
//                               ? '${orderInquiryManager.todayDate}（今天）'
//                               : confirmDate,
//                           style: OrderInquiryTextStyle().selectedDataText),
//                     ),
//                     Container(
//                       child: Icon(
//                         Icons.arrow_forward_ios,
//                         size: 12.0,
//                         color: Color(0xFF999999),
//                       ),
//                     ),
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _mainListView(orderInquiryManager) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//         child: ListView.separated(
//             separatorBuilder: (BuildContext context, int itemIndex) =>
//                 Container(height: 10.0),
//             shrinkWrap: true,
//             // physics: const NeverScrollableScrollPhysics(),
//             itemCount: orderInquiryManager.orderInquiryLength,
//             // itemCount: 10,
//             itemBuilder: (BuildContext context, int index) =>
//                 _listViewItem(orderInquiryManager, index)),
//       ),
//     );
//   }
//
//   Widget _listViewItem(orderInquiryManager, index) {
//     var _listDataBase = orderInquiryManager.orderInquiryList[index];
//     return Container(
//       height: 140.5,
//       padding: const EdgeInsets.only(left: 16.0, right: 15.0),
//       decoration: BoxDecoration(color: Color(0xFFFFFFFF), boxShadow: [
//         BoxShadow(
//             color: Color(0x14000000),
//             offset: Offset(0.0, 2.0), //阴影xy轴偏移量
//             blurRadius: 4.0, //阴影模糊程度
//             spreadRadius: 0.0 //阴影扩散程度
//         )
//       ]),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 18.0, bottom: 7.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   child: Text('${_listDataBase['createTime'] ?? '2020年10月22日'}',
//                       style: OrderInquiryTextStyle().orderDateText),
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       Container(
//                         child: Text(
//                           "已完成",
//                           style: OrderInquiryTextStyle().orderNumText,
//                         ),
//                       ),
//                       Container(
//                           child: Icon(
//                             Icons.arrow_forward_ios,
//                             size: 12.0,
//                             color: Color(0xFFCCCCCC),
//                           )),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           _infoModelView(
//               Color(0xFF44CBA9), '${_listDataBase['startStopName']}'),
//           _infoModelView(Color(0xFFFCB814), '${_listDataBase['endStopName']}'),
//           _infoModelView(Color(0xFF9E9E9E), '${_listDataBase['passengerNum']}人')
//         ],
//       ),
//     );
//   }
//
//   Widget _infoModelView(Color pointColor, String text) {
//     return Container(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Icon(Icons.brightness_1, size: 6.0, color: pointColor),
//           Container(width: 12.0),
//           Container(
//             width: 200.0,
//             child: Text(text,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: OrderInquiryTextStyle().busStopNameText),
//           )
//         ],
//       ),
//     );
//   }
// }
