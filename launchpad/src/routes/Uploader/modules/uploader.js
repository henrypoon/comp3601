import update from 'react-addons-update';
import constants from './actionConstants';
import { Actions } from 'react-native-router-flux';
import { AlertIOS } from 'react-native';
import axios from 'axios';
import urlConst from '../../url';
const { url } = urlConst;

export function uploadFile(filename) {
	return (dispatch) => {
		console.log(filename);
		const jsonToSend = {
			filename
		};

		axios.post(url + 'songs/upload', jsonToSend)
			.then((response) => {
				AlertIOS.alert('Song has been loaded to FPGA borad!');
			})
			.catch((error) => {
				console.log(error);
			});		
	};
}

const ACTION_HANDLERS = {
};

const initialState = {
};

export function UploaderReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
