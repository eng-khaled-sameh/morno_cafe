import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/core/widgets/custom_app_bar.dart';
import 'package:caffe_app/features/cart/logic/cart_cubit.dart';
import 'package:caffe_app/features/cart/logic/cart_state.dart';
import 'package:caffe_app/features/order/presentation/widgets/order_action_button.dart';
import 'package:caffe_app/features/order/presentation/widgets/order_items_summary.dart';
import 'package:caffe_app/features/order/presentation/widgets/order_section_card.dart';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/core/utils/app_formatter.dart';

import 'widgets/editable_info_row.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _notesController;

  String? _nameError;
  String? _phoneError;
  String? _addressError;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notes = context.read<CartCubit>().state.notes;
    if (_notesController.text.isEmpty && notes.isNotEmpty) {
      _notesController.text = notes;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool _validateAndSubmit(BuildContext context) {
    bool isValid = true;
    setState(() {
      _nameError = null;
      _phoneError = null;
      _addressError = null;

      final name = _nameController.text.trim();
      if (name.isEmpty || name.length < 3) {
        _nameError = AppLocalizations.of(context)!.minCharacters(3);
        isValid = false;
      }

      final phone = _phoneController.text.trim();
      final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
      if (digitsOnly.length < 8) {
        _phoneError = AppLocalizations.of(context)!.invalidPhone;
        isValid = false;
      }

      final address = _addressController.text.trim();
      if (address.isEmpty || address.length < 10) {
        _addressError = AppLocalizations.of(context)!.minCharacters(10);
        isValid = false;
      }
    });
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.order,
        onBackPress: () => Navigator.pop(context),
      ),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderSectionCard(
                    child: Column(
                      children: [
                        EditableInfoRow(
                          icon: Icons.person_outline,
                          label: AppLocalizations.of(context)!.name,
                          hintText: AppLocalizations.of(context)!.enterName,
                          controller: _nameController,
                          isRequired: true,
                          errorText: _nameError,
                          onChanged: (_) => setState(() => _nameError = null),
                        ),
                        const SizedBox(height: 12),
                        EditableInfoRow(
                          icon: Icons.phone_outlined,
                          label: AppLocalizations.of(context)!.phone,
                          hintText: AppLocalizations.of(context)!.enterPhone,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          isRequired: true,
                          errorText: _phoneError,
                          onChanged: (_) => setState(() => _phoneError = null),
                        ),
                        const SizedBox(height: 12),
                        EditableInfoRow(
                          icon: Icons.location_on_outlined,
                          label: AppLocalizations.of(context)!.address,
                          hintText: AppLocalizations.of(context)!.enterAddress,
                          controller: _addressController,
                          keyboardType: TextInputType.streetAddress,
                          isRequired: true,
                          errorText: _addressError,
                          onChanged: (_) =>
                              setState(() => _addressError = null),
                        ),
                        const SizedBox(height: 12),
                        EditableInfoRow(
                          icon: Icons.notes,
                          label: AppLocalizations.of(context)!.orderNotes,
                          hintText: AppLocalizations.of(
                            context,
                          )!.specialInstructions,
                          controller: _notesController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          onChanged: (value) =>
                              context.read<CartCubit>().updateNotes(value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const OrderItemsSummary(),
                  const SizedBox(height: 16),
                  OrderSectionCard(
                    child: Column(
                      children: [
                        _PriceRow(
                          label: AppLocalizations.of(context)!.subtotal,
                          value: state.subtotal,
                          langCode: langCode,
                        ),
                        const SizedBox(height: 10),
                        _PriceRow(
                          label: AppLocalizations.of(context)!.deliveryFee,
                          value: state.deliveryFee,
                          langCode: langCode,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Divider(height: 1),
                        ),
                        _PriceRow(
                          label: AppLocalizations.of(context)!.total,
                          value: state.total,
                          isTotal: true,
                          langCode: langCode,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: OrderActionButton(
        label: AppLocalizations.of(context)!.placeOrder,
        onPressed: () {
          if (context.read<CartCubit>().state.items.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(langCode == 'ar' ? 'السلة فارغة.' : 'Your cart is empty.'),
                behavior: SnackBarBehavior.floating,
              ),
            );
            return;
          }

          if (_validateAndSubmit(context)) {
            context.read<CartCubit>().clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.orderPlaced),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    required this.langCode,
    this.isTotal = false,
  });

  final String label;
  final double value;
  final String langCode;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: isTotal ? 16 : 14,
      fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
      color: isTotal ? AppColors.dark : AppColors.textSecondary,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        AppFormatter.formatPriceWidget(
          value,
          langCode,
          TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
            color: isTotal ? AppColors.primary : AppColors.dark,
          ),
        ),
      ],
    );
  }
}
