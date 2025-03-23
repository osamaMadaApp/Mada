import '../../backend/schema/util/schema_util.dart';
import '../../general_exports.dart';
import '../../structure_main_flow/flutter_mada_util.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ChangeNotifierProvider(
      create: (_) => PaymentModel(),
      child: Payment(
        args: args,
      ),
    );
  }
}

class Payment extends StatefulWidget {
  const Payment({
    super.key,
    this.args,
  });
  final dynamic args;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (callBack) {
        Provider.of<PaymentModel>(context, listen: false).setParams(
          widget.args,
        );
        Provider.of<PaymentModel>(context, listen: false).setPaymentMethods(
          FFAppState().masterDateJsonModel[keyPaymentType],
        );
        Provider.of<PaymentModel>(context, listen: false)
            .getPaymentOptionsDetails();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MadaHeader(
        title: FFLocalizations.of(context).getText('payment'),
        withCloseButton: true,
      ),
      backgroundColor: const Color(AppColors.gray3),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Consumer<PaymentModel>(
          builder: (BuildContext context, PaymentModel model, Widget? child) {
            return model.isLoading
                ? const Center()
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 30.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Expanded(
                                flex: 3,
                                child: PaymentOptions(),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              const Expanded(
                                flex: 5,
                                child: PaymentMethods(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentModel>(
      builder: (BuildContext context, PaymentModel model, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedContainer(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: DEVICE_HEIGHT * 0.02,
                  horizontal: DEVICE_WIDTH * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
                ),
                child: ProjectInformation(
                  title: FFLocalizations.of(context).getText('commission_vat'),
                  textKey: keyTitle,
                  valueKey: keyAmount,
                  padding: 0,
                  titleStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  projectInfo: model.data[keyCommissionAndVat] ?? [],
                  withLine: false,
                ),
              ),
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.02,
            ),
            RoundedContainer(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: DEVICE_HEIGHT * 0.02,
                  horizontal: DEVICE_WIDTH * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
                ),
                child: const CustomerDetails(),
              ),
            ),
            SizedBox(
              height: DEVICE_HEIGHT * 0.02,
            ),
            RoundedContainer(
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: DEVICE_HEIGHT * 0.02,
                  horizontal: DEVICE_WIDTH * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FFLocalizations.of(context)
                          .getText('choose_payment_method'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.02),
                    SizedBox(
                      height: DEVICE_HEIGHT * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: model.paymentMethods.length + 2,
                        itemBuilder: (context, index) {
                          if (index >= model.paymentMethods.length) {
                            final generatedIcons = [
                              iconExportLink,
                              iconReceiptAdd,
                            ];
                            final generatedTexts = [
                              FFLocalizations.of(context)
                                  .getText('share_payment_link'),
                              FFLocalizations.of(context)
                                  .getText('upload_receipt'),
                            ];
                            return GestureDetector(
                              onTap: () {},
                              child: PaymentMethodCard(
                                isGenerated: true,
                                text: generatedTexts[
                                    index - model.paymentMethods.length],
                                icon: generatedIcons[
                                    index - model.paymentMethods.length],
                              ),
                            );
                          }

                          final item = model.paymentMethods[index];
                          return GestureDetector(
                            onTap: () {
                              model.initiatePayment(
                                item,
                                FFLocalizations.of(context).getText(
                                  'please_select_payment_option',
                                ),
                                onSuccess: (url, isBuy) {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.routeWebViewScreen,
                                    arguments: {
                                      keyUrl: url,
                                      keyBuy: isBuy,
                                    },
                                  );
                                },
                              );
                            },
                            child: PaymentMethodCard(item: item),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentModel>(
      builder: (BuildContext context, PaymentModel model, Widget? child) {
        return Container(
          color: const Color(AppColors.white),
          child: SizedBox(
            height: DEVICE_HEIGHT * 0.8,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: DEVICE_HEIGHT * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: DEVICE_WIDTH * 0.02,
                            ),
                            child: Text(
                              FFLocalizations.of(context)
                                  .getText('choose_your_payment_option'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: model.paymentOptions.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return PaymentOptionCard(
                                item: model.paymentOptions[index],
                                isSelected: model.selectedPaymentOption ==
                                    model.paymentOptions[index],
                                onTap: () {
                                  model.selectPaymentOption(
                                    model.paymentOptions[index],
                                  );
                                },
                                withLine:
                                    index != model.paymentOptions.length - 1,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: DEVICE_HEIGHT * 0.02,
                    horizontal: DEVICE_WIDTH * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context)
                            .getText('if_you_have_any_questions'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: DEVICE_HEIGHT * 0.01,
                      ),
                      ContactUsButtons(
                        showEmail: true,
                        whatsappMsg: model.whatsAppDetails,
                        isPaymentMsg: true,
                        showText: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  const PaymentOptionCard({
    super.key,
    this.item,
    this.onTap,
    this.withLine = true,
    this.isSelected = false,
  });

  final dynamic item;
  final Function? onTap;
  final bool withLine;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DEVICE_HEIGHT * 0.01,
      ),
      child: GestureDetector(
        onTap: () {
          onTap!.call();
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: DEVICE_HEIGHT * 0.02,
                horizontal: DEVICE_WIDTH * 0.04,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(AppColors.primary).withValues(alpha: 0.1)
                    : const Color(AppColors.white),
                borderRadius: BorderRadius.circular(DEVICE_HEIGHT * 0.01),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(DEVICE_HEIGHT * 0.014),
                            decoration: BoxDecoration(
                              color: const Color(AppColors.gray4)
                                  .withValues(alpha: 0.25),
                              borderRadius:
                                  BorderRadius.circular(DEVICE_HEIGHT * 0.01),
                            ),
                            child: SvgPicture.asset(iconPaymentOption),
                          ),
                          SizedBox(
                            width: DEVICE_WIDTH * 0.02,
                          ),
                          Text(
                            item[keyTitle] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      SvgPictureRtl.asset(iconPrimaryArrow),
                    ],
                  ),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.02,
                  ),
                  Text(
                    item[keyDescription] ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  SizedBox(
                    height: DEVICE_HEIGHT * 0.02,
                  ),
                  Text(
                    '${getFormattedPrice(item[keyAmount].toDouble())} ${getCurrency()}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(AppColors.primary),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            if (withLine) const GrayLine(),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    this.item,
    super.key,
    this.isGenerated = false,
    this.icon,
    this.text,
  });

  final dynamic item;

  final bool isGenerated;
  final String? icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: DEVICE_WIDTH * 0.005,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: DEVICE_WIDTH * 0.01,
      ),
      decoration: BoxDecoration(
        color: const Color(AppColors.primary).withValues(alpha: 0.05),
        borderRadius: BorderRadius.all(
          Radius.circular(DEVICE_HEIGHT * 0.01),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          if (isGenerated)
            SvgPicture.asset(icon!)
          else
            CachedImage(
              image: item[keyLogo] ?? testImage,
              width: DEVICE_WIDTH * 0.07,
              height: DEVICE_HEIGHT * 0.05,
            ),
          if (text != null)
            Text(
              text ?? '',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: const Color(AppColors.primary),
                    fontWeight: FontWeight.w600,
                  ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentModel>(
      builder: (context, model, child) {
        return Form(
          key: model.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FFLocalizations.of(context).getText('customer_details'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      hint:
                          FFLocalizations.of(context).getText('customer_name'),
                      onChange: (value) => model.customerName = value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return FFLocalizations.of(context)
                              .getText('required_field');
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.02),
                  Expanded(
                    child: CustomInput(
                      hint:
                          FFLocalizations.of(context).getText('mobile_number'),
                      onChange: (value) => model.mobileNumber = value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return FFLocalizations.of(context)
                              .getText('required_field');
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.02),
                  Expanded(
                    child: CustomInput(
                      hint: FFLocalizations.of(context).getText('national_id'),
                      onChange: (value) => model.nationalId = value,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return FFLocalizations.of(context)
                              .getText('required_field');
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      hint:
                          FFLocalizations.of(context).getText('email_address'),
                      onChange: (value) => model.emailAddress = value,
                      validator: (value) => null,
                    ),
                  ),
                  SizedBox(width: DEVICE_WIDTH * 0.02),
                  Expanded(
                    child: CustomInput(
                      hint: FFLocalizations.of(context).getText('address'),
                      onChange: (value) => model.address = value,
                      validator: (value) => null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
