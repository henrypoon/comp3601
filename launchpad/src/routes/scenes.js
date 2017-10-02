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
import SettingContainer from './Setting/containers/SettingContainer';

const scenes = Actions.create(
  <Router>
    <Scene key="root" hideNavBar>
      <Scene key="home" hideNavBar component={HomeContainer} title="home" />
      <Scene
        key='list'
        hideNavBar 
        direction='vertical' 
        component={ListContainer} 
        title="list"
      />
      <Scene
        key='setting'
        hideNavBar 
        direction='vertical' 
        component={SettingContainer} 
        title="setting"
      />
    </Scene>
  </Router>
);

export default scenes;
