import React from 'react';
import { View, Picker, AlertIOS } from 'react-native';
import { RkButton, RkText } from 'react-native-ui-kitten';
import Icon from 'react-native-vector-icons/FontAwesome';
import { Actions } from 'react-native-router-flux';
import { Header, Left, Body, Right, Button, Title, Text } from 'native-base';

export default class Uploader extends React.Component {

	render() {
		// console.log(this.props);
		return (
			<View style={{ flex: 1 }}>
				<View style={{ flex: 0.2 }}>
					<Header>
						<Body style={{ top: -15 }}>
							<Title>Music Uploader</Title>
						</Body>
					</Header>
				</View>
				<View style={{ flex: 0.1, alignItems: 'center', justifyContent: 'center' }}>
					<Text>Music file would be downloaded from Google Drive and loaded to FPGA Board</Text>
				</View>
				<View style={{ flex: 0.7, alignItems: 'center' }}>
					<RkButton rkType='success' large onPress={() => {
							AlertIOS.prompt(
								'Please enter the filename',
								null,
								text => this.props.uploadFile(text)
							);
						}}>Enter Filename</RkButton>
					<RkButton rkType='danger' large onPress={() => Actions.pop()}>Back To Home</RkButton>
				</View>
			</View>
		);
	}
}
