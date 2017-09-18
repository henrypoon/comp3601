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
          horizontal={false}
          index={1}
          dot={<View style={{backgroundColor:'rgba(0,0,0,.2)', width: 16, height: 16, borderRadius: 8, marginLeft: 3, marginRight: 3, marginTop: 3, marginBottom: 0, }} />}
          activeDot={<View style={{backgroundColor: '#007aff', width: 16, height: 16, borderRadius: 8, marginLeft: 3, marginRight: 3, marginTop: 3, marginBottom: 0, }} />}
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
