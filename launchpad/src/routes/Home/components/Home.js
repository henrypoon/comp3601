import React from 'react';
import { View, Text, StatusBar } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import { Container, Header, Left, Body, Right, Button, Title } from 'native-base';
import Icon from 'react-native-vector-icons/FontAwesome';
import { Actions, Scene, Router, Stack } from 'react-native-router-flux';
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
			<View style={{ flex: 1 }}>
				<StatusBar hidden={true} />
				<View style={{ flex: 0.07 }}>
					<Header>
						<Left style={{ flex: 0.2, top: -15 }} />
						<Body style={{ top: -15 }}>
							<Title>MUSIC EDITOR</Title>
						</Body>
						<Right style={{ flex: 0.2, top: -15 }}>
							<Button transparent>
								<Icon name='align-justify' />
							</Button>
						</Right>
					</Header>
				</View>
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
						<RkButton rkType='success' onPress={() => Actions.modal()}>Play</RkButton>
						<RkButton rkType='danger' onPress={this.props.saveMusic}>Save</RkButton>
					</View>
				</View>
			</View>
		);
	}
}

export default Home;
