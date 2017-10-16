import React from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  StatusBar
} from 'react-native';

import {
  RkTheme
} from 'react-native-ui-kitten';

import { UtilStyles } from '../style/styles';
import ListDetails from './ListDetails';

class List extends React.Component {

	componentDidMount() {
    console.log(this.props);
		this.props.setData();
	}

	renderDetails() {
    const rendering = this.props.data.map((song) => 
      <ListDetails key={song.id} song={song.attributes} playMusic={this.props.playMusic} loadSong={this.props.loadSong} i={song.id} />
    );
		return rendering;
	}

	render() {
    return (
      <View style={{ flex: 1, backgroundColor: 'black' }}>
      <StatusBar hidden />
        <ScrollView
          automaticallyAdjustContentInsets
          style={[UtilStyles.container, styles.screen]}>
          {this.renderDetails()}
        </ScrollView>
      </View>
    );
  }
}

let styles = StyleSheet.create({
  screen: {
    backgroundColor: '#f0f1f5',
    padding: 12
  },
  buttonIcon: {
    marginRight: 7,
    fontSize: 19.7,
  },
  footer: {
    marginHorizontal: 16
  },
  avatar: {
    width: 42,
    height: 42,
    borderRadius: 21,
    marginRight: 17
  },
  dot: {
    fontSize: 6.5,
    color: '#0000008e',
    marginLeft: 2.5,
    marginVertical: 10,
  },
  floating: {
    width: 56,
    height: 56,
    position: 'absolute',
    zIndex: 200,
    right: 16,
    top: 173,
  },
  footerButtons: {
    flexDirection: 'row'
  },
  overlay: {
    justifyContent: 'flex-end',
    paddingVertical: 23,
    paddingHorizontal: 16
  }
});

export default List;
