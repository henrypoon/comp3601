import React, { Component, PropTypes } from 'react';
import { Router } from 'react-native-router-flux';
import { Provider, connect } from 'react-redux';
import { Text, View } from 'react-native';
import Nav from './NavBar/containers/NavContainer';


export default class AppContainer extends Component {
	// static propTypes = {
	// 	store: PropTypes.object.isRequired
	// }
	

	render() {
		console.log(this.props);
		return (
			<Provider store={this.props.store}>
				<Nav />
			</Provider>
		);
	}
}

