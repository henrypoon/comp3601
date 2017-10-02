import React from 'react';
import { View, Picker } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import { Actions } from 'react-native-router-flux';

export default class Setting extends React.Component {

	render() {
		console.log(this.props);
		return (
			<View>
				<Picker
					selectedValue={this.props.mode}
					onValueChange={(itemValue, itemIndex) => this.props.changeMode(itemValue)}>
					<Picker.Item label="Normal" value="normal" />
					<Picker.Item label="Other" value="Other" />
				</Picker>
				<View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'center', flex: 1 }}>
					<RkButton rkType='success large' onPress={() => Actions.home()}>Accept</RkButton>
					<RkButton rkType='danger large' onPress={() => Actions.home()}>Cancel</RkButton>
				</View>
			</View>
		);
	}
}
