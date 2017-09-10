import React from 'react';
import { Text, Slider, View, TouchableHighlight, Image } from 'react-native';
const pink = require('../../../../assets/img/grid/pink.png');
const blue = require('../../../../assets/img/grid/blue.png');
const orange = require('../../../../assets/img/grid/orange.png');
const cyan = require('../../../../assets/img/grid/cyan.png');
const purple = require('../../../../assets/img/grid/purple.png');
const green = require('../../../../assets/img/grid/green.png');


export const Launchpad = ({ setCurrentNote }) => {

  return (
    <View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(1)}>
          <Image
            source={pink}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(2)}>
          <Image
            source={blue}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(3)}>
          <Image
            source={orange}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(4)}>
          <Image
            source={blue}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(5)}>
          <Image
            source={cyan}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(6)}>
          <Image
            source={purple}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(7)}>
          <Image
            source={orange}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(8)}>
          <Image
            source={green}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(9)}>
          <Image
            source={pink}
          />
        </TouchableHighlight>
      </View>
    </View>
  );
};

export default Launchpad;
