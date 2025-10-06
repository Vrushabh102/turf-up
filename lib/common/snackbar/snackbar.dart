import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeautifulMessenger {
  // Success message with elegant green gradient
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildMessageContent(
          message: message,
          icon: Icons.check_circle_rounded,
          gradientColors: [
            const Color(0xFF00C851),
            const Color(0xFF00E676),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Error message with sophisticated red gradient
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildMessageContent(
          message: message,
          icon: Icons.error_rounded,
          gradientColors: [
            const Color(0xFFFF5252),
            const Color(0xFFFF1744),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Warning message with vibrant amber gradient
  static void showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildMessageContent(
          message: message,
          icon: Icons.warning_rounded,
          gradientColors: [
            const Color(0xFFFFB74D),
            const Color(0xFFFF9800),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Info message with cool blue gradient
  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildMessageContent(
          message: message,
          icon: Icons.info_rounded,
          gradientColors: [
            const Color(0xFF42A5F5),
            const Color(0xFF2196F3),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  // Custom message with your own colors and icon
  static void showCustom(
    BuildContext context,
    String message, {
    IconData? icon,
    List<Color>? gradientColors,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _buildMessageContent(
          message: message,
          icon: icon ?? Icons.notifications_rounded,
          gradientColors: gradientColors ?? [
            const Color(0xFF7C4DFF),
            const Color(0xFF651FFF),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  // Loading message for async operations
  static void showLoading(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF37474F),
                const Color(0xFF263238),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5.w,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Private method to build the message content
  static Widget _buildMessageContent({
    required String message,
    required IconData icon,
    required List<Color> gradientColors,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.4),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 16.h,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dismiss any currently showing snackbar
  static void dismiss(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  // Clear all snackbars in queue
  static void clearAll(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}

// Extension for even easier usage
extension MessengerExtension on BuildContext {
  void showSuccessMessage(String message) {
    BeautifulMessenger.showSuccess(this, message);
  }

  void showErrorMessage(String message) {
    BeautifulMessenger.showError(this, message);
  }

  void showWarningMessage(String message) {
    BeautifulMessenger.showWarning(this, message);
  }

  void showInfoMessage(String message) {
    BeautifulMessenger.showInfo(this, message);
  }

  void showLoadingMessage(String message) {
    BeautifulMessenger.showLoading(this, message);
  }

  void showCustomMessage(
    String message, {
    IconData? icon,
    List<Color>? gradientColors,
    Duration? duration,
  }) {
    BeautifulMessenger.showCustom(
      this,
      message,
      icon: icon,
      gradientColors: gradientColors,
      duration: duration,
    );
  }

  void dismissMessage() {
    BeautifulMessenger.dismiss(this);
  }

  void clearAllMessages() {
    BeautifulMessenger.clearAll(this);
  }
}