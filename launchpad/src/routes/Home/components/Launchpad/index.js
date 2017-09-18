import React from 'react';
import { Text, View, TouchableHighlight, Image, Dimensions } from 'react-native';
const pink = require('../../../../assets/img/Grid/pink.png');
const blue = require('../../../../assets/img/Grid/blue.png');
const orange = require('../../../../assets/img/Grid/orange.png');
const cyan = require('../../../../assets/img/Grid/cyan.png');
const purple = require('../../../../assets/img/Grid/purple.png');
const green = require('../../../../assets/img/Grid/green.png');
const grey = require('../../../../assets/img/Grid/grey.png');
const yellow = require('../../../../assets/img/Grid/yellow.png');
const brown = require('../../../../assets/img/Grid/brown.png');

const deviceW = Dimensions.get('window').width;

export const Launchpad = ({ setCurrentNote }) => {

  return (
    <View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(1)}>
          <Image
            source={pink}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(2)}>
          <Image
            source={blue}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(3)}>
          <Image
            source={orange}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(4)}>
          <Image
            source={grey}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(5)}>
          <Image
            source={cyan}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(6)}>
          <Image
            source={purple}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote(7)}>
          <Image
            source={brown}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(8)}>
          <Image
            source={green}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote(9)}>
          <Image
            source={yellow}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
      </View>
    </View>
  );
};

export default Launchpad;
