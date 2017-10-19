import React from 'react';
import { View, Picker, Text } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import { Actions } from 'react-native-router-flux';
import SliderBar from './SliderBar';

export default class Setting extends React.Component {

	render() {
		// console.log(this.props);
		return (
			<View style={{ flex: 1 }}>
				<View style={{ top: 70, alignItems: 'center', flex: 0.2 }}>
					<Text style={{ fontSize: 25 }}>Mode</Text>
				</View>
					<Picker
						selectedValue={this.props.selected_mode}
						onValueChange={(itemValue) => this.props.changeMode(itemValue)} >
						<Picker.Item label="Normal" value="normal" />
						<Picker.Item label="staccato" value="staccato" />
						<Picker.Item label="Slurred" value="slurred" />
					</Picker>
				<View style={{ alignItems: 'center', flex: 0.2 }}>
					<Text style={{ fontSize: 25 }}>BPM</Text>
				</View>
				<View style={{ flex: 0.2 }}>
					<SliderBar
						setSlider={this.props.setBpm}
						value={this.props.bpm}
						min={60} 
						max={200}
					/>
				</View>
				<View style={{ flexDirection: 'row', alignItems: 'center', flex: 0.2, justifyContent: 'center' }}>
					<RkButton rkType='success large' onPress={() => this.props.selectMode()}>Accept</RkButton>
					<RkButton rkType='danger large' onPress={() => Actions.pop()}>Cancel</RkButton>
				</View>
			</View>
		);
	}
}
