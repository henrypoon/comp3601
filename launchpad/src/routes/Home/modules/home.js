import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';

const { SET_SLIDER1, SET_SLIDER2, PLAY_MUSIC, SET_CURRENTNOTE } = constants;

export function playMusic() {
	console.log('play');
	axios.post('http://192.168.0.5:3000/songs/play/1')
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

export function setCurrentNote(payload) {
	return {
		type: SET_CURRENTNOTE,
		payload
	};
}

export function setSlider1(payload) {
	return {
		type: SET_SLIDER1,
		payload
	};
}

export function setSlider2(payload) {
	return {
		type: SET_SLIDER2,
		payload
	};
}

function handleSetCurrentNote(state, action) {
	return update(state, {
		currentNote: {
			$set: action.payload
		}
	});
}

function handleSetSlider1(state, action) {
	return update(state, {
		sliderVal1: {
			$set: action.payload
		}
	});
}

function handleSetSlider2(state, action) {
	return update(state, {
		sliderVal2: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	SET_SLIDER1: handleSetSlider1,
	SET_SLIDER2: handleSetSlider2,
	SET_CURRENTNOTE: handleSetCurrentNote
};

const initialState = {
	currentNote: null,
	sliderVal1: 0,
	sliderVal2: 0
};

export function HomeReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
