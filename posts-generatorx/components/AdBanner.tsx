import { AdMobBanner } from 'expo-ads-admob';
import { View } from 'react-native';

export default function AdBanner() {
  return (
    <View style={{ marginTop: 20 }}>
      <AdMobBanner
        bannerSize="smartBannerPortrait"
        adUnitID="ca-app-pub-5350081816144613/1395585176"
      />
    </View>
  );
}