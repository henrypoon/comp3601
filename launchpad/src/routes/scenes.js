import React from 'react';
import { Text } from 'react-native';
import { Actions, Scene, Router, Stack } from 'react-native-router-flux';
import HomeContainer from './Home/containers/HomeContainer';

const TabIcon = ({ selected, title }) => {
	return (
		<Text style={{ fontSize: 20, color: selected ? 'red' : 'black' }}>{title}</Text>
	);
};

const scenes = () => (
		<Router>
			<Stack key="root">
				<Scene key="Home" component={HomeContainer} title="Music Editor" />
			</Stack>
		</Router>
);

export default scenes;