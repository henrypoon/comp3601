import React from 'react';
import { View, Text } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import SliderBar from './SliderBar';
import Launchpad from './Launchpad';

class Home extends React.Component {

	componentDidMount() {
		this.props.setSlider1(0);
		this.props.setSlider2(60);
	}

	render() {
		return (
			<View style={{ flex: 1, alignItems: 'center', backgroundColor: 'black' }}>
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
				<Launchpad />
				<RkButton onPress={this.props.playMusic}>Play</RkButton>
			</View>
		);
	}
}

export default Home;
