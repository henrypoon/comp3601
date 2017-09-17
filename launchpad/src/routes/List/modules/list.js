import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';

const { SET_DATA } = constants;

export function setData(payload) {
	return {
		type: SET_DATA,
		payload
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
