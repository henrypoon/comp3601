import React from 'react';
import { View, Text } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import SliderBar from './SliderBar';
import Launchpad from './Launchpad';
import ProcessBar from './ProcessBar';

class Home extends React.Component {

	componentDidMount() {
		this.props.setSlider1(0);
		this.props.setSlider2(60);
	}

	render() {
		return (
			<View style={{ flex: 1, alignItems: 'center', backgroundColor: 'black' }}>
				<ProcessBar song={this.props.song} />
				<SliderBar
					setSlider={this.props.setSlider1}
					value={this.props.sliderVal1}
					min={0} max={6}
				/>
				<SliderBar
					setSlider={this.props.setSlider2}
					value={this.props.sliderVal2}
					min={60} max={200}
				/>
				<View style={{ flexDirection: 'row' }}>
					<RkButton onPress={this.props.addToSong}>Add</RkButton>
					<RkButton onPress={this.props.addToSong}>Delete</RkButton>
				</View>
				<Launchpad setCurrentNote={this.props.setCurrentNote} />
				<RkButton onPress={this.props.playMusic}>Play</RkButton>
			</View>
		);
	}
}

export default Home;
