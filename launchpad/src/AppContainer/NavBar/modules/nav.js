import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';

const { SET_TAB } = constants;

export function setTab(payload) {
	return {
		type: SET_TAB,
		payload
	};
}

function handleSetTab(state, action) {
	return update(state, {
		tab: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	SET_TAB: handleSetTab
};

const initialState = {
	tab: 'home'
};

export function NavReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];
	
	return handler ? handler(state, action) : state;
}
