import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';

const { 
	SET_OCTAVE, 
	SET_DURATION, 
	PLAY_MUSIC, 
	SET_CURRENTNOTE, 
	ADD_TO_SONG, 
	DELETE_NOTE, 
	SAVE_MUSIC 
} = constants;

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

export function saveMusic() {
	console.log('save');
	axios.post('http://192.168.0.5:3000/songs/play/1')
		.then((response) => {
			console.log(response);
		})
		.catch((error) => {
			console.log(error);
		});
	return {
		type: SAVE_MUSIC,
		payload: null
	};
}

export function setCurrentNote(payload) {
	return {
		type: SET_CURRENTNOTE,
		payload
	};
}

export function setOctave(payload) {
	return {
		type: SET_OCTAVE,
		payload
	};
}

export function setDuraction(payload) {
	return {
		type: SET_DURATION,
		payload
	};
}

export function addToSong() {
	return (dispatch, store) => {
		const currNote = store().home.currentNote;
		const song = store().home.song;
		const add = song.concat(currNote);
		dispatch({
			type: ADD_TO_SONG,
			payload: add
		});
	};
}

export function deleteNote() {
	return (dispatch, store) => {
		const song = store().home.song;
		const len = song.length - 1;
		console.log(len);
		const add = song.splice(0, len);
		dispatch({
			type: DELETE_NOTE,
			payload: add
		});
	};
}

function handleSetCurrentNote(state, action) {
	return update(state, {
		currentNote: {
			$set: action.payload
		}
	});
}

function handleSetOctave(state, action) {
	return update(state, {
		octave: {
			$set: action.payload
		}
	});
}

function handleSetDuration(state, action) {
	return update(state, {
		duration: {
			$set: action.payload
		}
	});
}

function handleAddToSong(state, action) {
	return update(state, {
		song: {
			$set: action.payload
		}
	});
}

function handleDeteleNote(state, action) {
	return update(state, {
		song: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	SET_OCTAVE: handleSetOctave,
	SET_DURATION: handleSetDuration,
	SET_CURRENTNOTE: handleSetCurrentNote,
	ADD_TO_SONG: handleAddToSong,
	DELETE_NOTE: handleDeteleNote
};

const initialState = {
	song: [],
	currentNote: null,
	octave: 0,
	duration: 0
};

export function HomeReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
