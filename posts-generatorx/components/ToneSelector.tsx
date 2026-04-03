import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

const tones = ['Inspirant', 'Professionnel', 'Humour', 'Amour'];

export default function ToneSelector({ selected, onSelect }: any) {
  return (
    <View style={styles.container}>
      {tones.map((tone) => (
        <TouchableOpacity
          key={tone}
          style={[
            styles.button,
            selected === tone && styles.active
          ]}
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
  button: {
    backgroundColor: '#1a1a1a',
    padding: 10,
    borderRadius: 20,
    margin: 5
  },
  active: {
    borderColor: '#00aaff',
    borderWidth: 1
  },
  text: { color: 'white' }
});