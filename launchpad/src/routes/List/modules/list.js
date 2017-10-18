import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';
import { Actions } from 'react-native-router-flux';
import { AlertIOS } from 'react-native';

var url = 'http://192.168.43.63:3000/';

const { SET_DATA, PLAY_MUSIC, DELETE_SONG } = constants;

export function setData() {
	return (dispatch) => {
		axios.get(url + 'songs')
		.then((response) => {
			dispatch({
				type: SET_DATA,
				payload: response.data.data
			});
		})
		.catch((error) => {
			console.log(error);
		});
	};
}

export function playMusic(payload) {
	const api = url + 'songs/play/' + payload;
	axios.post(api)
		.then((response) => {
			AlertIOS.alert('Song has been transferred to FPGA borad!');
			console.log(response);
		})
		.catch((error) => {
			console.log(error);
		});
	return {
		type: PLAY_MUSIC,
		payload: null
	};
}

export function deleteSong(payload) {
	return (dispatch) => {
		const api = url + 'songs/' + payload;
		axios.delete(api)
			.then((response) => {
				console.log(response);
				dispatch({
					type: DELETE_SONG,
					payload: null
				});
				Actions.home();
			})
			.catch((error) => {
				console.log(error);
			});
	};
}


function handleSetData(state, action) {
	return update(state, {
		data: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	SET_DATA: handleSetData
};

const initialState = {
	data: []
};

export function ListReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
