import React from 'react';
import { Text, View, TouchableHighlight, Image, Dimensions, StyleSheet } from 'react-native';
import FadeInView from 'react-native-fade-in-view';
import { connect } from 'react-redux';

const pink = require('../../../../assets/img/Grid/pink_num.png');
const blue = require('../../../../assets/img/Grid/blue_n.png');
const blue_s = require('../../../../assets/img/Grid/blue_s.png');
const blue_b = require('../../../../assets/img/Grid/blue_b.png');
const orange = require('../../../../assets/img/Grid/orange_num.png');
const cyan = require('../../../../assets/img/Grid/cyan_num.png');
const purple = require('../../../../assets/img/Grid/purple_num.png');
const green = require('../../../../assets/img/Grid/green_num.png');
const grey = require('../../../../assets/img/Grid/grey_num.png');
const yellow = require('../../../../assets/img/Grid/yellow_num.png');
const brown = require('../../../../assets/img/Grid/brown_num.png');

const deviceW = Dimensions.get('window').width;

export default class Launchpad extends React.Component {

  render() {
    const blurMap = (val) => {
      switch (this.props.octave) {
        case 3:
          if (val === 'C' && val === 'D' && val === 'E' && val === 'F' && val === 'G' && val === 'A' && val === 'B') {
            return true;
          }
          return false;
        case 4:
          if (val === 'C' && val === 'D' && val === 'E' && val === 'F' && val === 'G' && val === 'A' && val === 'B') {
            return true;
          }
          return false;
        case 5:
          if (val === 'C' && val === 'D' && val === 'E' && val === 'F' && val === 'G' && val === 'A' && val === 'B') {
            return true;
          }
          return false;
        case 6:
          if (val === 'C' && val === 'D' && val === 'E' && val === 'F' && val === 'G' && val === 'A' && val === 'B') {
            return true;
          }
          return false;
        default:
          return false;
      }
    };

    const renderGrid = (color, val) => {
      const blur = blurMap(val) ? 100 : 0;
      return (
        <TouchableHighlight onPress={() => this.props.setCurrentNote(val)}>
              <Image
              source={color}
              style={{ width: deviceW / 3, height: deviceW / 3 }}
              blurRadius={blur}
              />
            </TouchableHighlight>
      );
    };

    const renderFlat = (flag) => {
      console.log(this.props);
      if (flag === 'b') {
        return (
          <Image
            source={blue_b}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        );
      } else if (flag === '#') {
        return (
          <Image
            source={blue_s}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        );        
      } else {
        return (
          <Image
            source={blue}
            style={{ width: deviceW / 3, height: deviceW / 3 }}
          />
        );
      }
    };

    return (
        <View>
          <FadeInView
            duration={750}
            style={{ alignItems: 'center' }}
          >
          <View style={{ flexDirection: 'row' }}>
            {renderGrid(pink, 'rest')}
            <TouchableHighlight onPress={() => this.props.setSign()}>
              {renderFlat(this.props.sign)}
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
    }
}

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

