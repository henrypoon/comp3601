import React from 'react';
import { Text, Slider, View, TouchableHighlight, Image } from 'react-native';
const pinkIMG = require('../../../../assets/img/grid/pink.png');

export const Launchpad = ({ setCurrentNote }) => {

  return (
    <View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(1)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(2)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(3)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(4)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(5)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(6)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(7)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(8)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(9)}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
      </View>
    </View>
  );
};

export default Launchpad;
