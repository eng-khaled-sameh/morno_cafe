import 'dart:async';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/home/data/models/ad_model.dart';
import 'package:caffe_app/core/services/firestore_service.dart';
import 'package:caffe_app/features/product_detail/presentation/screens/product_detail_screen.dart';

class AdsBanner extends StatefulWidget {
  final List<AdModel> ads;

  const AdsBanner({super.key, required this.ads});

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (widget.ads.isNotEmpty) {
      _startAutoScroll();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isLoaded = true;
        });
      }
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      if (_currentPage < widget.ads.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleAdTap(AdModel ad) async {
    try {
      final firestoreService = FirestoreService();
      final product = await firestoreService.getProductByPath(ad.productPath);

      if (mounted) {
        if (product != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.productNotFound),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ads.isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: _isLoaded ? 1.0 : 0.0,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 600),
        scale: _isLoaded ? 1.0 : 0.95,
        curve: Curves.easeOut,
        child: SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: widget.ads.length,
            itemBuilder: (context, index) {
              final ad = widget.ads[index];

              String currentPriceStr = ad.adDescription;
              String oldPriceStr = '';
              if (ad.adDescription.contains('~~')) {
                final parts = ad.adDescription.split('~~');
                if (parts.length >= 3) {
                  currentPriceStr = parts[0].trim();
                  oldPriceStr = parts[1].trim();
                } else if (parts.length == 2) {
                  currentPriceStr = parts[0].trim();
                  oldPriceStr = parts[1].trim();
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () => _handleAdTap(ad),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [AppColors.dark, AppColors.primary],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Right side image glow
                        Positioned(
                          right: -10,
                          top: -10,
                          bottom: -10,
                          width: 140,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withOpacity(0.4),
                                  Colors.transparent,
                                ],
                                radius: 0.7,
                              ),
                            ),
                          ),
                        ),
                        // Right side product image
                        Positioned(
                          right: 14,
                          top: 20,
                          bottom: 20,
                          width: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: CachedNetworkImage(
                                imageUrl: ad.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Left side content
                        Positioned(
                          left: 16,
                          top: 14,
                          bottom: 14,
                          right: 120, // keep space for image
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.limitedOffer,
                                  style: GoogleFonts.sora(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Product Name
                              Text(
                                ad.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.sora(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // Price styled
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    currentPriceStr,
                                    style: GoogleFonts.sora(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (oldPriceStr.isNotEmpty) ...[
                                    const SizedBox(width: 6),
                                    Text(
                                      oldPriceStr,
                                      style: GoogleFonts.sora(
                                        fontSize: 11,
                                        color: Colors.white.withOpacity(0.6),
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const Spacer(),
                              // Order Now Button
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.orderNow,
                                      style: GoogleFonts.sora(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 8,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.ads.length,
                              (dotIndex) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: _currentPage == dotIndex ? 16 : 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: _currentPage == dotIndex
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
