import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView, ActivityIndicator } from 'react-native';
import { useState } from 'react';
import { useRouter } from 'expo-router';
import ToneSelector from '../components/ToneSelector';
import AdBanner from '../components/AdBanner';

export default function Home() {
  const router = useRouter();

  const [input, setInput] = useState('');
  const [tone, setTone] = useState('Inspirant');
  const [result, setResult] = useState('');
  const [loading, setLoading] = useState(false);

  const generate = async () => {
    if (!input) return;

    setLoading(true);
    setResult('');

    try {
      const response = await fetch("https://api-inference.huggingface.co/models/gpt2", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          inputs: `Crée un post Facebook ${tone}, engageant et viral : ${input}`
        })
      });

      const data = await response.json();
      setResult(data[0]?.generated_text || "Erreur IA");

    } catch {
      setResult("Erreur réseau");
    }

    setLoading(false);
  };

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.title}>⚡ Smart Post</Text>

      <TextInput
        style={styles.input}
        placeholder="Décris ton idée..."
        placeholderTextColor="#888"
        multiline
        value={input}
        onChangeText={setInput}
      />

      <ToneSelector selected={tone} onSelect={setTone} />

      <TouchableOpacity style={styles.button} onPress={generate}>
        <Text style={styles.buttonText}>✨ Générer</Text>
      </TouchableOpacity>

      {loading && <ActivityIndicator color="#00aaff" />}

      {result ? <Text style={styles.result}>{result}</Text> : null}

      <TouchableOpacity onPress={() => router.push('/settings')}>
        <Text style={styles.link}>⚙️ Paramètres</Text>
      </TouchableOpacity>

      <AdBanner />
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#0a0a0a', padding: 20 },
  title: { color: 'white', fontSize: 22, marginBottom: 10 },
  input: { backgroundColor: '#1a1a1a', color: 'white', padding: 15, borderRadius: 10, height: 120 },
  button: { backgroundColor: '#333', padding: 15, borderRadius: 10, marginTop: 20 },
  buttonText: { color: 'white', textAlign: 'center' },
  result: { marginTop: 20, color: '#00ffcc' },
  link: { color: '#00aaff', marginTop: 20 }
});