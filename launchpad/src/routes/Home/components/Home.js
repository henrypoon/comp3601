import React from 'react';
import { View, Text, StatusBar, AlertIOS } from 'react-native';
import { RkButton } from 'react-native-ui-kitten';
import { Header, Left, Body, Right, Button, Title } from 'native-base';
import Icon from 'react-native-vector-icons/FontAwesome';
import { Actions } from 'react-native-router-flux';
import SliderBar from './SliderBar';
import Launchpad from './Launchpad';
import ProcessBar from './ProcessBar';
import { Dropdown } from 'react-native-material-dropdown';

class Home extends React.Component {

	componentWillMount() {
		this.props.setOctave(3);
		this.props.setDuraction('1/4');
		this.props.setSelected(-1);
	}



	render() {
		const renderSaveButton = () => {
			if (this.props.mode === 'new') {
				return (
					<RkButton rkType='danger rounded' onPress={() => {
						AlertIOS.prompt(
							'Enter a song name',
							null,
							text => this.props.saveMusic(text)
						);
					}}>Save</RkButton>
				);
			}
			return (
				<RkButton rkType='danger rounded' onPress={this.props.saveMusic}>Save</RkButton>
			);
		};

		let duractionList = [{
			value: '1/4',
		}, {
			value: '1/3',
		}, {
			value: '1/2',
		}, {
			value: '3/4',
		}, {
			value: '1',
		}, {
			value: '1 1/2',
		}, {
			value: '2',
		}, {
			value: '3',
		}, {
			value: '4',
		}, {
			value: '8',
		}];
		return (
			<View style={{ flex: 1 }}>
				<StatusBar hidden />
				<View style={{ flex: 0.1 }}>
					<Header>
						<Left style={{ flex: 0.2, top: -15 }} >
							<Button transparent onPress={() => Actions.setting()}>
								<Icon name='align-justify' />
							</Button>
						</Left>
						<Body style={{ top: -15 }}>
							<Title>MUSIC EDITOR</Title>
						</Body>
						<Right style={{ flex: 0.2, top: -15 }}>
							<Button transparent onPress={() => Actions.setting()}>
								<Icon name='align-justify' />
							</Button>
						</Right>
					</Header>
				</View>

				<View style={{ flex: 1, alignItems: 'center' }}>
					<ProcessBar 
						song={this.props.song} 
						setSelected={this.props.setSelected} 
						selected={this.props.selected} 
						mode={this.props.mode}
					/>
					<SliderBar
						setSlider={this.props.setOctave}
						value={this.props.octave}
						min={3} 
						max={6}
					/>
					<View style={{ height: 65, width: 300 }}>
						<Dropdown
							value='1/4'
							label='Duraction'
							data={duractionList}
							onChangeText={(e) => this.props.setDuraction(e)}
						/>
					</View>
					<View style={{ flexDirection: 'row' }}>
						<RkButton rkType='success rounded' onPress={this.props.addToSong}>Add</RkButton>
						<RkButton rkType='danger rounded' onPress={this.props.deleteNote}>Delete</RkButton>
					</View>
					<Launchpad setCurrentNote={this.props.setCurrentNote} setSign={this.props.setSign} octave={this.props.octave} />
					<View style={{ flexDirection: 'row' }}>
						<RkButton rkType='success rounded' onPress={this.props.playMusic}>Play</RkButton>
						{renderSaveButton()}
						<RkButton rkType='warning rounded' onPress={() => Actions.list()}>Album</RkButton>
					</View>
				</View>
			</View>
		);
	}
}

export default Home;
