import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';

const { CHANGE_MODE } = constants;

export function changeMode(payload) {
	return ({
		type: CHANGE_MODE,
		payload: payload
	});
}

function handleChangeMode(state, action) {
	return update(state, {
		mode: {
			$set: action.payload
		}
	});
}


const ACTION_HANDLERS = {
	CHANGE_MODE: handleChangeMode
};

const initialState = {
	mode: 'normal'
};

export function SettingReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
