import React from 'react';
import { View, Text } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import SliderBar from './SliderBar';
import Launchpad from './Launchpad';
import ProcessBar from './ProcessBar';

class Home extends React.Component {

	componentDidMount() {
		this.props.setOctave(0);
		this.props.setDuraction(0);
	}

	render() {
		return (
			<View style={{ flex: 1, alignItems: 'center', backgroundColor: 'black' }}>
				<ProcessBar song={this.props.song} />
				<SliderBar
					setSlider={this.props.setOctave}
					value={this.props.octave}
					min={0} max={6}
				/>
				<SliderBar
					setSlider={this.props.setDuraction}
					value={this.props.duration}
					min={0} max={1000}
				/>
				<View style={{ flexDirection: 'row' }}>
					<RkButton rkType='success' onPress={this.props.addToSong}>Add</RkButton>
					<RkButton rkType='danger' onPress={this.props.deleteNote}>Delete</RkButton>
				</View>
				<Launchpad setCurrentNote={this.props.setCurrentNote} />
				<View style={{ flexDirection: 'row' }}>
					<RkButton rkType='success' onPress={this.props.playMusic}>Play</RkButton>
					<RkButton rkType='danger' onPress={this.props.saveMusic}>Save</RkButton>
				</View>
			</View>
		);
	}
}

export default Home;
