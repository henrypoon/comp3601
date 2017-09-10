import React from 'react';
import { Text, View, ScrollView, TouchableOpacity, StyleSheet, Image } from 'react-native';
const pinkIMG = require('../../../../assets/img/grid/pink.png');

export const ProcessBar = ({ song }) => {

  return (
    <View style={{ flex: 0.2 }}>
      <ScrollView
        contentContainerStyle={styles.contentContainer}
        automaticallyAdjustContentInsets={false}
        horizontal={true}
      >
      {song.map((e, i) => {
        return <Text key={i} style={{ color: 'white' }}>{e}</Text>;
      })}
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  contentContainer: {
    paddingVertical: 0,
  }
});

export default ProcessBar;
