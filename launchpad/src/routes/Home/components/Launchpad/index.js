import React from 'react';
import { Text, Slider, View, TouchableHighlight, Image } from 'react-native';
const pinkIMG = require('../../../../assets/img/grid/pink.png');

export const Launchpad = () => {

  return (
    <View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => console.log('dddd')}>
          <Image
            source={pinkIMG}
          />
        </TouchableHighlight>
      </View>
    </View>
  );
};

export default Launchpad;
