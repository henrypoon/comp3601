import React, { Component } from 'react';
import {
  Dimensions,
  StyleSheet,
  StatusBar,
  Text,
  View
} from 'react-native';
import Swiper from 'react-native-swiper';
import HomeContainer from '../../../routes/Home/containers/HomeContainer';
import ListContainer from '../../../routes/List/containers/ListContainer';

const deviceW = Dimensions.get('window').width;

const basePx = 375;

class Nav extends React.Component {

  px2dp = (px) =>  {
    return px * deviceW / basePx;
  }

  render() {
    return (
      <View style={{ flex: 1 }}>
        <StatusBar hidden={true} />
        <Swiper
          loop={false}
          showsPagination={false}
          index={1}
        >
          <View style={{ flex: 1 }}>
            <HomeContainer />
          </View>
          <View style={{ flex: 1 }}>
            <ListContainer />
          </View>
        </Swiper>
      </View>
    );
  }
}

export default Nav;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
