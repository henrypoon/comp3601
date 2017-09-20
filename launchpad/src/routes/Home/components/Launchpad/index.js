import React from 'react';
import { Text, View, TouchableHighlight, Image, Dimensions, StyleSheet } from 'react-native';
import FadeInView from 'react-native-fade-in-view';
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

  const renderGrid = (color, val) => {
    return <TouchableHighlight onPress={() => setCurrentNote(val)}>
            <Image
            source={color}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
            blurRadius={0}
            />
          </TouchableHighlight>;
  };

  return (
    <View>
      <FadeInView
        duration={750}
        style={{ alignItems: 'center' }}
      >
      <View style={{ flexDirection: 'row' }}>
        {renderGrid(pink, 'rest')}
        <TouchableHighlight onPress={() => setSign()}>
          <Image
            source={blue}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        </TouchableHighlight>
        {renderGrid(orange, 'A')}
      </View>
      <View style={{ flexDirection: 'row' }}>
        {renderGrid(grey, 'B')}
        {renderGrid(cyan, 'C')} 
        {renderGrid(purple, 'D')}
      </View>
      <View style={{ flexDirection: 'row' }}>
        {renderGrid(brown, 'E')}
        {renderGrid(green, 'F')}
        {renderGrid(yellow, 'G')}
      </View>
      </FadeInView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  absolute: {
    position: "absolute",
    top: 0, left: 0, bottom: 0, right: 0,
  },
});

export default Launchpad;
