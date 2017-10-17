import React from 'react';
import { View, Picker, Text } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import { Actions } from 'react-native-router-flux';
import SliderBar from './SliderBar';

export default class Setting extends React.Component {

	render() {
		// console.log(this.props);
		return (
			<View>
				<View style={{ alignItems: 'center', flex: 1, top: 50 }}>
					<Text style={{ fontSize: 25 }}>Mode</Text>
				</View>
				<Picker
					selectedValue={this.props.selected_mode}
					onValueChange={(itemValue, itemIndex) => this.props.changeMode(itemValue)} >
					<Picker.Item label="Normal" value="normal" />
					<Picker.Item label="Staccido" value="staccido" />
					<Picker.Item label="Slurred" value="slurred" />
				</Picker>
				<View style={{ alignItems: 'center', flex: 1, top: 150 }}>
					<Text style={{ fontSize: 25 }}>BPM</Text>
				</View>
				<View style={{ flex: 1.5, top: 180 }}>
					<SliderBar
						setSlider={this.props.setBpm}
						value={this.props.bpm}
						min={60} 
						max={200}
					/>
				</View>
				<View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'center', flex: 1 }}>
					<RkButton rkType='success large' onPress={() => this.props.selectMode()}>Accept</RkButton>
					<RkButton rkType='danger large' onPress={() => Actions.home()}>Cancel</RkButton>
				</View>
			</View>
		);
	}
}
