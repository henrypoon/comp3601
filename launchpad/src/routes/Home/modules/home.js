import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';
import { AlertIOS } from 'react-native';

var url = 'http://10.211.55.4:3000/';

const { 
	SET_OCTAVE, 
	SET_DURATION, 
	PLAY_MUSIC, 
	SET_CURRENTNOTE, 
	ADD_TO_SONG, 
	DELETE_NOTE, 
	SAVE_MUSIC,
	SET_SELECTED,
	SET_SIGN,
	LOAD_SONG
} = constants;

export function setSign() {
	return (dispatch, store) => {
		const curr = store().home.sign;
		let next = '';
		if (curr === '') {
			next = '#';
		}
		if (curr === '#') {
			next = 'b';
		}
		if (curr === 'b') {
			next = '';
		}
		dispatch({
			type: SET_SIGN,
			payload: next
		});
	};
}

export function playMusic() {
	console.log('play');
	axios.post(url + 'songs/play/1')
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
	return (dispatch, store) => {
		console.log(store().home.song);
		let song = '';
		let length = 0;
		store().home.song.map((e) => {
			song = song + e.notes + '|' + e.duration + '|';
			length += e.duration;
		});
		song = song.slice(0, song.length - 1);
		const jsonToSend = {
			notes: song,
			mode: 'normal',
			name: 'test',
			description: 'heeeee',
			length: length/1000,
			bpm: 20
		};
		console.log(jsonToSend);

		axios.post(url + 'songs', jsonToSend)
			.then((response) => {
				console.log(response);
				// AlertIOS.alert('Save Successfully!');
			})
			.catch((error) => {
				console.log(error);
			});
		dispatch({
			type: SAVE_MUSIC,
			payload: null
		});
	};
}

export function setCurrentNote(payload) {
	return (dispatch, store) => {
		dispatch({
			type: SET_CURRENTNOTE,
			payload
		});
		if (store().home.selected === -1) {
			dispatch({
				type: SET_SELECTED,
				payload: 0
			});
		}
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
		const octave = store().home.octave;
		const duration = store().home.duration;
		const sign = store().home.sign;
		const notes = currNote === 'rest' ? 'rest' : currNote + octave + sign;
		const n = { notes: notes, duration: duration };
		const song = store().home.song;
		const add = song.concat(n);
		if (store().home.selected !== -1) {
			dispatch({
				type: ADD_TO_SONG,
				payload: add
			});
		}
	};
}

export function deleteNote() {
	return (dispatch, store) => {
		const song = store().home.song;
		const s = store().home.selected;
		const len = song.length;
		const add = song.slice(0, s).concat(song.slice(s + 1, len));
		dispatch({
			type: DELETE_NOTE,
			payload: add
		});
		if (s === len - 1) {
			dispatch({
				type: SET_SELECTED,
				payload: s - 1
			});
		}
	};
}

export function setSelected(payload) {
	return {
		type: SET_SELECTED,
		payload
	};
}

export function loadSong(payload) {
	return (dispatch) => {
		console.log('load');
		const link = url + 'songs/' + payload + '.json';
		console.log(link);
		axios.get(link)
		.then((response) => {
			var arr = [];
			response.data.data.attributes.notes.split('|').map((i) => {
				arr.push(i);
			});
			console.log(arr);
			dispatch({
				type: LOAD_SONG,
				payload: response.data.data
			});
		})
		.catch((error) => {
			console.log(error);
		});
	};
}

function handleLoadSong(state, action) {
	// return update(state, {
	// 	song: {
	// 		$set: action.payload
	// 	}
	// });
	console.log(action.payload);
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

function handleSetSelected(state, action) {
	return update(state, {
		selected: {
			$set: action.payload
		}
	});
}

function handleSetSign(state, action) {
	return update(state, {
		sign: {
			$set: action.payload
		}
	});
}

const ACTION_HANDLERS = {
	SET_OCTAVE: handleSetOctave,
	SET_DURATION: handleSetDuration,
	SET_CURRENTNOTE: handleSetCurrentNote,
	ADD_TO_SONG: handleAddToSong,
	DELETE_NOTE: handleDeteleNote,
	SET_SELECTED: handleSetSelected,
	SET_SIGN: handleSetSign,
	LOAD_SONG: handleLoadSong
};

const initialState = {
	song: [],
	currentNote: '',
	octave: 0,
	duration: 0,
	sign: '',
	selected: 0,
	mode: 'new',
	songid: '-1'
};

export function HomeReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
