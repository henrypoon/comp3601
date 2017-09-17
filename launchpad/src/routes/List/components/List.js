import React from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
} from 'react-native';

import {
  RkTheme
} from 'react-native-ui-kitten';

import { UtilStyles } from '../style/styles';
import ListDetails from './ListDetails';

class List extends React.Component {

	componentDidMount() {
		this.props.setData(data);
	}

	renderDetails() {
		return this.props.data.map(song => 
			<ListDetails key={song.id} song={song} />
		);
	}

	render() {
    return (
      <View style={{ flex: 1 }}>
        <ScrollView
          automaticallyAdjustContentInsets={true}
          style={[UtilStyles.container, styles.screen]}>
          {this.renderDetails()}
        </ScrollView>
      </View>
    );
  }
}

const data = [
  {
    id: 1,
    notes: '#3|#6|%3',
    length: '156',
    name: 'hello world',
    description: 'compcompcomp3601',
    mode: 'normal',
    created_at: '2017-09-17 16:34:34',
    bpm: '120'
  },
  {
    id: 2,
    notes: '#3|#6|%3',
    length: '156',
    name: 'hello world',
    description: 'compcompcomp3601',
    mode: 'normal',
    created_at: '2017-09-17 16:34:34',
    bpm: '160'
  },
  {
    id: 3,
    notes: '#7|%3',
    length: '156',
    name: 'hello world',
    description: 'compcompcomp3601',
    mode: 'normal',
    created_at: '2017-09-17 16:34:34',
    bpm: '180'
  },
  {
    id: 4,
    notes: '#3|#6|%3',
    length: '156',
    name: 'hello world',
    description: 'compcompcomp3601',
    mode: 'normal',
    created_at: '2017-09-17 16:34:34',
    bpm: '190'
  },
];

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
