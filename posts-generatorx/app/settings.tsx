import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { useRouter } from 'expo-router';

export default function Settings() {
  const router = useRouter();

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Paramètres</Text>

      <TouchableOpacity onPress={() => router.back()}>
        <Text style={styles.link}>⬅ Retour</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#0a0a0a', padding: 20 },
  title: { color: 'white', fontSize: 22 },
  link: { color: '#00aaff', marginTop: 20 }
});