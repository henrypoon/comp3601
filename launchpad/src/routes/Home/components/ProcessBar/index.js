import React from 'react';
import { Text, View, ScrollView, TouchableOpacity, StyleSheet, Image } from 'react-native';
const pinkIMG = require('../../../../assets/img/grid/pink.png');

export const ProcessBar = () => {

  return (
    <View style={{ flex: 0.5 }}>
      <ScrollView
        contentContainerStyle={styles.contentContainer}
        automaticallyAdjustContentInsets={false}
        horizontal={true}
      >
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
      <Image
        source={pinkIMG}
      />
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
