import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View
} from 'react-native';
import TabNavigator from 'react-native-tab-navigator';
import Icon from 'react-native-vector-icons/FontAwesome';
import {Dimensions} from 'react-native';
import { Actions, Scene, Router, Stack } from 'react-native-router-flux';
import HomeContainer from './Home/containers/HomeContainer';
import ListContainer from './List/containers/ListContainer';

const deviceW = Dimensions.get('window').width;

const basePx = 375;

function px2dp(px) {
  return px *  deviceW / basePx;
}

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


export const scenes = () => (
  <TabNavigator style={styles.container}>
    <TabNavigator.Item
      selected={true}
      title='Home'
      selectedTitleStyle={{ color: '#3496f0' }}
      renderIcon={() => <Icon name="home" size={px2dp(22)} color="#666" />}
      renderSelectedIcon={() => <Icon name="home" size={px2dp(22)} color="#3496f0" />}
      badgeText="1"
      onPress={() => console.log(tab) }>
      <HomeContainer />
    </TabNavigator.Item>
    <TabNavigator.Item
      selected={false}
      title="Profile"
      selectedTitleStyle={{ color: "#3496f0" }}
      renderIcon={() => <Icon name="user" size={px2dp(22)} color="#666" />}
      renderSelectedIcon={() => <Icon name="user" size={px2dp(22)} color="#3496f0" />}
      onPress={() => this.setState({ selectedTab: 'profile' }) }>
      <ListContainer />
    </TabNavigator.Item>
  </TabNavigator>
);

export default scenes;
