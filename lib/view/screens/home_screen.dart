import 'package:crypto_pair_trading/model/trade.dart';
import 'package:crypto_pair_trading/resource/app_constants.dart';
import 'package:crypto_pair_trading/view_model/trading_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../model/apis/api_response.dart';
import '../../model/order_book.dart';
import '../../model/repository/trading_repository.dart';
import '../../model/tick.dart';
import '../../resource/app_colors.dart';
import '../../resource/app_styles.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? _inputText = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _inputController = TextEditingController();
  bool isOrderBookVisible = false;

  late TradingRepository repo;
  late TradingViewModel _viewModel;


  //HomeScreen widget with Search bar, Floating action button, Tick details, Order book details
  @override
  Widget build(BuildContext context) {
    repo = TradingRepositoryImpl();
    _viewModel = TradingViewModelImpl(repo: repo);

    ApiResponse tickResponse = Provider.of<TradingViewModel>(context).tickResponse;
    ApiResponse orderBookResponse = Provider.of<TradingViewModel>(context).orderBookResponse;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(AppConstants.spaceBig),
              decoration: BoxDecoration(
                color: AppColors.grey.withAlpha(AppConstants.alpha),
                borderRadius: const BorderRadius.all(Radius.circular(AppConstants.radiusMedium)),
              ),
              child: buildSearchTextFieldWidget(),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  buildTickWidget(context, tickResponse),
                  buildOrderBookWidget(context, orderBookResponse),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildFloatingActionButtonWidget(),
    );
  }

  //Search text field
  TextField buildSearchTextFieldWidget() {
    return TextField(
        key: const Key(AppConstants.keySearchText),
        textAlignVertical: TextAlignVertical.center,
        controller: _inputController,
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(AppConstants.onlyAlphabets)),
        ],
        onChanged: (value) {
          setState(() {
            _inputText = _inputController.text.toString();
          });
        },
        onSubmitted: (value) {
          getSupportedTickData(value);
          if(isOrderBookVisible){
            getOrderBookData(value);
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: AppConstants.spaceMedium),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: AppConstants.enterCurrencyPair,
            suffixIcon: IconButton(onPressed: (){
              getSupportedTickData(_inputText!);
              if(isOrderBookVisible){
                getOrderBookData(_inputText!);
              }
            }, icon: Icon(Icons.search, color: AppColors.grey,))
        )
    );
  }

  Widget buildOrderBookWidget(BuildContext context, ApiResponse<dynamic> orderBookResponse) => isOrderBookVisible? SizedBox(child: getOrderBookWidget(context, orderBookResponse)):Container();

  SizedBox buildTickWidget(BuildContext context, ApiResponse<dynamic> tickResponse) => SizedBox(child: getTickWidget(context, tickResponse));

  //Floating action button
  FloatingActionButton buildFloatingActionButtonWidget() {
    return FloatingActionButton(
      key: const Key(AppConstants.keyFloatingActionButton),
      onPressed: () {
        getSupportedTickData( _inputText!);
        if(isOrderBookVisible){
          getOrderBookData(_inputText!);
        }
      },
      child: const Icon(Icons.refresh),
      backgroundColor: AppColors.primary,
    );
  }


  //Tick widget with currency tick details
  Widget getTickWidget(BuildContext context, ApiResponse apiResponse) {

    Tick? _tick = apiResponse.data as Tick?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return buildLoadingWidget();
      case Status.COMPLETED:
        return Container(
          margin: const EdgeInsets.only(left: AppConstants.spaceBig, right: AppConstants.spaceBig, top: AppConstants.spaceBig),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildTickNameWidget(_tick),
              const SizedBox(height: AppConstants.spaceMedium,),
              buildOpenHighRowWidget(_tick),
              const SizedBox(height: AppConstants.spaceBig,),
              buildLowLastRowWidget(_tick),
              const SizedBox(height: AppConstants.spaceBig,),
              buildVolumeRowWidget(_tick),
              const SizedBox(height: AppConstants.spaceSmall,),
              buildViewHideOrderBookWidget()
            ],
          ),
        );
      case Status.ERROR:
        return buildErrorCurrencyPairWidget();
      case Status.INITIAL:
      default:
        return buildSearchDataInfoWidget();
    }
  }

  SizedBox buildSearchDataInfoWidget() {
    return SizedBox(
        height: AppConstants.containerBig,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: AppConstants.containerSmall, color: AppColors.grey,),
              const SizedBox(height: AppConstants.spaceBig,),
              const Text(AppConstants.enterCurrencyPairLoad),
            ],
          ),
        ),
      );
  }

  SizedBox buildErrorCurrencyPairWidget() {
    return const SizedBox(
        height: AppConstants.containerBig,
        child: Center(
          child: Text(AppConstants.errorLoadingCurrencyPair),
        ),
      );
  }

  TextButton buildViewHideOrderBookWidget() {
    return TextButton(
                onPressed: () {
                  setState(() {
                    isOrderBookVisible = !isOrderBookVisible;
                  });
                  if(isOrderBookVisible){
                    getOrderBookData(_inputText!);
                  }
                },
                child: Text(isOrderBookVisible? AppConstants.hideOrderBook:AppConstants.viewOrderBook, style: AppStyles.textDetailPrimaryBold,)
            );
  }

  Row buildVolumeRowWidget(Tick? _tick) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppConstants.volume, style: AppStyles.textBodyBlack,),
                    const SizedBox(height: AppConstants.divider,),
                    Text(_tick!.volume.toString(), style: AppStyles.textSubTitleBlackBold,)
                  ],
                ),
              ],
            );
  }

  Row buildLowLastRowWidget(Tick? _tick) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppConstants.low, style: AppStyles.textBodyBlack,),
                    const SizedBox(height: AppConstants.divider,),
                    Text(_viewModel.appendCurrency(_tick!.low.toString()), style: AppStyles.textSubTitleBlackBold,)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppConstants.last, style: AppStyles.textBodyBlack,),
                    const SizedBox(height: AppConstants.divider,),
                    Text(_viewModel.appendCurrency(_tick.last.toString()), style: AppStyles.textSubTitleBlackBold,)
                  ],
                )
              ],
            );
  }

  Row buildOpenHighRowWidget(Tick? _tick) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppConstants.open, style: AppStyles.textBodyBlack,),
                    const SizedBox(height: AppConstants.divider,),
                    Text(_viewModel.appendCurrency(_tick!.open.toString()), style: AppStyles.textSubTitleBlackBold,)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppConstants.high, style: AppStyles.textBodyBlack,),
                    const SizedBox(height: AppConstants.divider,),
                    Text(_viewModel.appendCurrency(_tick.high.toString()), style: AppStyles.textSubTitleBlackBold,)
                  ],
                )
              ],
            );
  }

  Row buildTickNameWidget(Tick? _tick) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_viewModel.toUpperCaseText(_tick!.name.toString()), style: AppStyles.textTitleBlack,),
                Text(_viewModel.getFormattedDateTime(_tick.timestamp.toString()), style: AppStyles.textBodyBlack,)
              ],
            );
  }

  //Order book widget with asks and bids value titles and list view of values
  Widget getOrderBookWidget(BuildContext context, ApiResponse orderBookResponse) {
    OrderBook? _orderBook = orderBookResponse.data as OrderBook?;
    List<Trade> _tradeList = [];
    if(_orderBook!=null){
      _tradeList = _viewModel.getTradeList(_orderBook);
    }

    switch (orderBookResponse.status) {
      case Status.LOADING:
        return buildLoadingWidget();
      case Status.COMPLETED:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: AppConstants.spaceBig),
          padding: const EdgeInsets.only(left: AppConstants.spaceMedium, right: AppConstants.spaceMedium, top: AppConstants.spaceMedium),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(AppConstants.radiusMedium)),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withAlpha(AppConstants.alpha),
                spreadRadius: AppConstants.radiusSmall,
                blurRadius: AppConstants.radiusMedium,
                offset: const Offset(AppConstants.radiusZero, AppConstants.radiusSmall), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildOrderBookListTitleWidget(),
              const SizedBox(height: AppConstants.spaceMedium,),
              buildOrderBookListIfAvailable(_orderBook, _tradeList),
            ],
          ),
        );
      case Status.ERROR:
        return buildErrorTextWidget();
      case Status.INITIAL:
      default:
        return Container();
    }
  }

  SizedBox buildErrorTextWidget() {
    return const SizedBox(
        height: AppConstants.containerSmall,
        child: Center(
          child: Text(AppConstants.errorLoadingOrderBook),
        ),
      );
  }

  SizedBox buildLoadingWidget() => const SizedBox(height: AppConstants.containerBig, child: Center(child: CircularProgressIndicator()));

  StatelessWidget buildOrderBookListIfAvailable(OrderBook? _orderBook, List<Trade> _tradeList) {
    return _orderBook!=null ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _tradeList.length,
              itemBuilder: (BuildContext context, int index) {
                Trade data = _tradeList[index];
                return buildTradeItem(data);
              },
            ):Container();
  }

  Row buildOrderBookListTitleWidget() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppConstants.bidPrice, style: AppStyles.textDetailBlackBold,),
                Text(AppConstants.qty, style: AppStyles.textDetailBlackBold,),
                Text(AppConstants.qty, style: AppStyles.textDetailBlackBold,),
                Text(AppConstants.askPrice, style: AppStyles.textDetailBlackBold,),
              ],
            );
  }

  Widget buildTradeItem(Trade trade){
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spaceMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(trade.bidPrice!, style: AppStyles.textDetailBlack,),
          Text(trade.bidQuantity!, style: AppStyles.textDetailBlack,),
          Text(trade.askQuantity!, style: AppStyles.textDetailBlack,),
          Text(trade.askPrice!, style: AppStyles.textDetailBlack,),
        ],
      ),
    );
  }

  //Call ViewModel to getSupportedTickData with provider
  getSupportedTickData( String value) {
    if (value.isNotEmpty) {
      if(AppConstants.supportedCurrencyPair.contains(value)){
        Provider.of<TradingViewModel>(context, listen: false)
            .fetchTickData(value);
      }else{
        showToast(context, AppConstants.toastInvalidPair);
      }
    }else{
      showToast(context, AppConstants.toastInvalidPair);
    }
  }

  //Call ViewModel to getOrderBookData with provider
  getOrderBookData( String value) {
    if (value.isNotEmpty) {
      if(AppConstants.supportedCurrencyPair.contains(value)){
        Provider.of<TradingViewModel>(context, listen: false)
            .fetchOrderBookData(value);
      }else{
        showToast(context, AppConstants.toastInvalidPair);
      }
    }else{
      showToast(context, AppConstants.toastInvalidPair);
    }
  }

  //Show toast
  void showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: AppConstants.oneSecond,
        backgroundColor: AppColors.grey,
        textColor: AppColors.black,
        fontSize: AppConstants.toastSize
    );
  }
}