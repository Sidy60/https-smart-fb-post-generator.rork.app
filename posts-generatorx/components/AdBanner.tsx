import React from 'react';
import { View } from 'react-native';
import { BannerAd, BannerAdSize, TestIds } from 'react-native-google-mobile-ads';

export default function AdBanner() {
  return (
    <View style={{ marginTop: 20 }}>
      <BannerAd
        unitId="ca-app-pub-5350081816144613/1395585176"
        size={BannerAdSize.BANNER}
        requestOptions={{
          requestNonPersonalizedAdsOnly: true,
        }}
      />
    </View>
  );
}