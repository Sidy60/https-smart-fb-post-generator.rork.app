import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import { useRouter } from 'expo-router';

export default function Settings() {
  const router = useRouter();

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Paramètres</Text>

      <Text style={styles.card}>📱 Smart Post Generator\nVersion 1.0</Text>

      <TouchableOpacity onPress={() => router.back()}>
        <Text style={styles.link}>⬅ Retour</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#0a0a0a', padding: 20 },
  title: { color: 'white', fontSize: 22, marginBottom: 20 },
  card: { color: '#ccc', marginBottom: 20 },
  link: { color: '#00aaff', marginTop: 10 }
});