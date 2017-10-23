import React from 'react';
import { Actions, Scene, Router } from 'react-native-router-flux';
import HomeContainer from './Home/containers/HomeContainer';
import ListContainer from './List/containers/ListContainer';
import SettingContainer from './Setting/containers/SettingContainer';
import UploaderContainer from './Uploader/containers/UploaderContainer';

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
      <Scene
        key='uploader'
        hideNavBar 
        direction='vertical' 
        component={UploaderContainer} 
        title="uploader"
      />
    </Scene>
  </Router>
);

export default scenes;
