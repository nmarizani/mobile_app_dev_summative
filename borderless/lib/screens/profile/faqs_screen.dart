import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/theme/theme.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  Widget _buildFAQItem({
    required String question,
    required String answer,
    required bool isFirst,
    required bool isDark,
  }) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Text(
          question,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        shape: Border(
          top: isFirst
              ? BorderSide.none
              : BorderSide(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                ),
        ),
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;

        return Scaffold(
          backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
          appBar: AppBar(
            backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black,
                  size: 20,
                ),
              ),
            ),
            title: Text(
              'FAQs',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: ListView(
            children: [
              _buildFAQItem(
                question: 'Can I cancel my order?',
                answer:
                    'Yes, you can cancel your order before it is shipped. To cancel your order, go to Order History, find the order you want to cancel, and click on the Cancel button. Once an order is shipped, it cannot be cancelled.',
                isFirst: true,
                isDark: isDark,
              ),
              _buildFAQItem(
                question: 'Will I receive the same product I see in the image?',
                answer:
                    'The actual product color may vary from the images displayed on our app. We make every effort to display the most accurate colors possible, but we cannot guarantee that your device\'s display will accurately reflect the actual colors.',
                isFirst: false,
                isDark: isDark,
              ),
              _buildFAQItem(
                question: 'How can I receive the forgotten password?',
                answer:
                    'If you\'ve forgotten your password, you can reset it by clicking on the "Forgot Password" link on the login screen. We\'ll send you an email with instructions to reset your password.',
                isFirst: false,
                isDark: isDark,
              ),
              _buildFAQItem(
                question: 'Is my personal information confidential?',
                answer:
                    'Yes, we take your privacy very seriously. Your personal information is confidential and will not be shared with third parties. We use industry-standard security measures to protect your data. For more details, please refer to our Privacy Policy.',
                isFirst: false,
                isDark: isDark,
              ),
              _buildFAQItem(
                question: 'What payment methods can I use to make purchases?',
                answer:
                    'We offer the following payment methods: PayPal, Google Pay, and major credit/debit cards including Visa, MasterCard, and American Express.',
                isFirst: false,
                isDark: isDark,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'For more queries, you can write to us at ',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Open email client
                      },
                      child: const Text(
                        'help@quickmart.com',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF00C566),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
