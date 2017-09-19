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

export const Launchpad = ({ setCurrentNote, setSign }) => {

  return (
    <View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote('rest')}>
          <Image
            source={pink}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setSign()}>
          <Image
            source={blue}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote('A')}>
          <Image
            source={orange}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote('B')}>
          <Image
            source={grey}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote('C')}>
          <Image
            source={cyan}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote('D')}>
          <Image
            source={purple}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
      </View>
      <View style={{ flexDirection: 'row' }}>
        <TouchableHighlight onPress={() => setCurrentNote('E')}>
          <Image
            source={brown}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote('F')}>
          <Image
            source={green}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        <TouchableHighlight onPress={() => setCurrentNote('G')}>
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
