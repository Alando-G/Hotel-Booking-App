import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Offers'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildOfferCard(
              context,
              'Family Package',
              'Get a discount on family stays!',
              Icons.family_restroom,
              Colors.blue.shade400,
            ),
            const SizedBox(height: 16),
            _buildOfferCard(
              context,
              'Spa Package',
              'Enjoy complimentary spa services.',
              Icons.spa,
              Colors.green.shade400,
            ),
            const SizedBox(height: 16),
            _buildOfferCard(
              context,
              'Dining Offer',
              'Exclusive dining experiences available.',
              Icons.local_dining,
              Colors.red.shade400,
            ),
            const SizedBox(height: 16),
            _buildOfferCard(
              context,
              'Extended Stay Offer',
              'Discounts for extended stays.',
              Icons.hotel,
              Colors.orange.shade400,
            ),
            const SizedBox(height: 16),
            _buildOfferCard(
              context,
              'Adventure Package',
              'Guided tours and activities.',
              Icons.hiking,
              Colors.purple.shade400,
            ),
            const SizedBox(height: 16),
            _buildOfferCard(
              context,
              'Couples Retreat',
              'Romantic getaway offers.',
              Icons.favorite,
              Colors.pink.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(
      BuildContext context, String title, String subtitle, IconData icon, Color iconColor) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 60),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
