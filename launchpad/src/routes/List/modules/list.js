import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';

const { SET_DATA } = constants;

export function setData() {
	return (dispatch) => {
		axios.get('http://192.168.0.5:3000/songs')
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
