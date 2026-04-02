#!/bin/bash

echo "🚀 Création du projet Smart Post Generator..."

# Dossiers
mkdir -p src/screens
mkdir -p src/components

# package.json
cat > package.json << 'EOF'
{
  "name": "post-generator-mobile",
  "version": "1.0.0",
  "main": "node_modules/expo/AppEntry.js",
  "scripts": {
    "start": "expo start",
    "build": "eas build -p android"
  },
  "dependencies": {
    "expo": "^51.0.0",
    "expo-status-bar": "~1.12.1",
    "react": "18.2.0",
    "react-native": "0.74.0",
    "expo-ads-admob": "~13.0.0"
  },
  "private": true
}
EOF

# app.json
cat > app.json << 'EOF'
{
  "expo": {
    "name": "Smart Post Generator",
    "slug": "smart-post-generator",
    "version": "1.0.0",
    "orientation": "portrait",
    "platforms": ["android"],
    "android": {
      "package": "com.smartpost.generator"
    }
  }
}
EOF

# eas.json
cat > eas.json << 'EOF'
{
  "build": {
    "preview": {
      "android": {
        "buildType": "apk"
      }
    }
  }
}
EOF

# babel.config.js
cat > babel.config.js << 'EOF'
module.exports = function(api) {
  api.cache(true);
  return {
    presets: ['babel-preset-expo'],
  };
};
EOF

# App.tsx
cat > App.tsx << 'EOF'
import { useState } from 'react';
import GeneratorScreen from './src/screens/GeneratorScreen';
import SettingsScreen from './src/screens/SettingsScreen';

export default function App() {
  const [screen, setScreen] = useState<'generator' | 'settings'>('generator');

  return screen === 'generator'
    ? <GeneratorScreen goToSettings={() => setScreen('settings')} />
    : <SettingsScreen goBack={() => setScreen('generator')} />;
}
EOF

# GeneratorScreen
cat > src/screens/GeneratorScreen.tsx << 'EOF'
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView } from 'react-native';
import { useState } from 'react';
import ToneSelector from '../components/ToneSelector';
import AdBanner from '../components/AdBanner';

export default function GeneratorScreen({ goToSettings }: any) {
  const [input, setInput] = useState('');
  const [tone, setTone] = useState('Inspirant');
  const [result, setResult] = useState('');

  const generate = async () => {
    if (!input) return;

    try {
      const response = await fetch("https://api-inference.huggingface.co/models/gpt2", {
        method: "POST",
        headers: {
          "Authorization": "Bearer YOUR_HF_TOKEN",
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          inputs: `Crée un post Facebook ${tone} : ${input}`
        })
      });

      const data = await response.json();
      setResult(data[0]?.generated_text || "Erreur génération");
    } catch {
      setResult("Erreur réseau");
    }
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

      {result ? <Text style={styles.result}>{result}</Text> : null}

      <TouchableOpacity onPress={goToSettings}>
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
  button: { backgroundColor: '#333', padding: 15, borderRadius: 10, marginTop: 20, alignItems: 'center' },
  buttonText: { color: 'white' },
  result: { marginTop: 20, color: '#00ffcc' },
  link: { color: '#00aaff', marginTop: 20 }
});
EOF

# SettingsScreen
cat > src/screens/SettingsScreen.tsx << 'EOF'
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

export default function SettingsScreen({ goBack }: any) {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Paramètres</Text>

      <TouchableOpacity onPress={goBack}>
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
EOF

# ToneSelector
cat > src/components/ToneSelector.tsx << 'EOF'
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const tones = ['Inspirant', 'Professionnel', 'Humour', 'Amour'];

export default function ToneSelector({ selected, onSelect }: any) {
  return (
    <View style={styles.container}>
      {tones.map((tone) => (
        <TouchableOpacity
          key={tone}
          style={[styles.button, selected === tone && styles.active]}
          onPress={() => onSelect(tone)}
        >
          <Text style={styles.text}>{tone}</Text>
        </TouchableOpacity>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flexDirection: 'row', flexWrap: 'wrap' },
  button: { backgroundColor: '#1a1a1a', padding: 10, borderRadius: 20, margin: 5 },
  active: { borderColor: '#00aaff', borderWidth: 1 },
  text: { color: 'white' }
});
EOF

# AdBanner
cat > src/components/AdBanner.tsx << 'EOF'
import { AdMobBanner } from 'expo-ads-admob';
import { View } from 'react-native';

export default function AdBanner() {
  return (
    <View style={{ marginTop: 20 }}>
      <AdMobBanner
        bannerSize="smartBannerPortrait"
        adUnitID="ca-app-pub-3940256099942544/6300978111"
      />
    </View>
  );
}
EOF

echo "✅ Projet créé avec succès !"
echo "👉 Lance: npm install && npx expo start"