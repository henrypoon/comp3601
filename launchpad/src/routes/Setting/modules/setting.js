import update from 'react-addons-update';
import constants from './actionConstants';
import { Actions } from 'react-native-router-flux';

const { CHANGE_MODE, SELECT_MODE, SET_BPM } = constants;

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

export function setBpm(payload) {
	return {
		type: SET_BPM,
		payload
	};
}

function handleSetBpm(state, action) {
	return update(state, {
		bpm: {
			$set: action.payload
		}
	});
}

function handleChangeMode(state, action) {
	return update(state, {
		selected_mode: {
			$set: action.payload
		}
	});
}

function handleSelectMode(state, action) {
	return update(state, {
		mode: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	CHANGE_MODE: handleChangeMode,
	SELECT_MODE: handleSelectMode,
	SET_BPM: handleSetBpm
};

const initialState = {
	mode: 'normal',
	selected_mode: 'normal',
	bpm: 100
};

export function SettingReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
