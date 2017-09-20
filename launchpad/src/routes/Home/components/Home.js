import React from 'react';
import { View, Text, StatusBar } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import { Header, Left, Body, Right, Button, Title } from 'native-base';
import Icon from 'react-native-vector-icons/FontAwesome';
import { Actions } from 'react-native-router-flux';
import SliderBar from './SliderBar';
import Launchpad from './Launchpad';
import ProcessBar from './ProcessBar';

class Home extends React.Component {

	componentDidMount() {
		this.props.setOctave(3);
		this.props.setDuraction(0);
		this.props.setSelected(-1);
	}

	render() {
		return (
			<View style={{ flex: 1 }}>
				<StatusBar hidden />
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
					<ProcessBar 
						song={this.props.song} 
						setSelected={this.props.setSelected} 
						selected={this.props.selected} 
					/>
					<SliderBar
						setSlider={this.props.setOctave}
						value={this.props.octave}
						min={3} 
						max={6}
					/>
					<SliderBar
						setSlider={this.props.setDuraction}
						value={this.props.duration}
						min={0} 
						max={1000}
						opt={'ms'}
					/>
					<View style={{ flexDirection: 'row' }}>
						<RkButton rkType='success rounded' onPress={this.props.addToSong}>Add</RkButton>
						<RkButton rkType='danger rounded' onPress={this.props.deleteNote}>Delete</RkButton>
					</View>
					<Launchpad setCurrentNote={this.props.setCurrentNote} setSign={this.props.setSign} octave={this.props.octave} />
					<View style={{ flexDirection: 'row' }}>
						<RkButton rkType='success rounded' onPress={this.props.playMusic}>Play</RkButton>
						<RkButton rkType='danger rounded' onPress={this.props.saveMusic}>Save</RkButton>
						<RkButton rkType='warning rounded' onPress={() => Actions.list()}>Album</RkButton>
					</View>
				</View>
			</View>
		);
	}
}

export default Home;
