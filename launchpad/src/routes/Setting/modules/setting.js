import update from 'react-addons-update';
import constants from './actionConstants';
import { Actions } from 'react-native-router-flux';

const { CHANGE_MODE, SELECT_MODE } = constants;

export function changeMode(payload) {
	return ({
		type: CHANGE_MODE,
		payload
	});
}

export function selectMode() {
	return (dispatch, store) => {
		const mode = store().setting.selected_mode;
		dispatch({
			type: SELECT_MODE,
			payload: mode
		});
		Actions.home();
	};
}

function handleChangeMode(state, action) {
	return update(state, {
		selected_mode: {
			$set: action.payload
		}
	});
}

function handleSelectMode(state, action) {
	console.log('duudududud')
	return update(state, {
		mode: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	CHANGE_MODE: handleChangeMode,
	SELECT_MODE: handleSelectMode
};

const initialState = {
	mode: 'normal',
	selected_mode: 'normal',
};

export function SettingReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
