import 'package:flutter/material.dart';


class LinkToSponsorCard extends StatelessWidget {
  
  final IconData sponsorIcon;

  final String sponsor;

  final String sponsorStatus;

  final Function()? onTap;
  
  const LinkToSponsorCard(
    {
      required this.sponsorIcon,
      required this.sponsor,
      required this.sponsorStatus,
      this.onTap,
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(sponsorIcon),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "$sponsor: $sponsorStatus"
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 18,
              )
            ],
          ),
        ),
      ),
    
    );
  }
}
