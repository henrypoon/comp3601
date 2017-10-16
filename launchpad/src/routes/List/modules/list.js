import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';

var url = 'http://10.211.55.4:3000/';

const { SET_DATA, PLAY_MUSIC } = constants;

export function setData() {
	return (dispatch) => {
		axios.get(url+'songs')
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
	console.log('play');
	const api = url + 'songs/play/' + payload.toString();
	console.log(api);
	axios.post(api)
		.then((response) => {
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


function handleSetData(state, action) {
	return update(state, {
		data: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	SET_DATA: handleSetData,
};

const initialState = {
	data: []
};

export function ListReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
