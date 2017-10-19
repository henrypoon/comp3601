import update from 'react-addons-update';
import axios from 'axios';
import constants from './actionConstants';
import { AlertIOS } from 'react-native';
import { Actions } from 'react-native-router-flux';
import urlConst from '../../url';
const { url } = urlConst;

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
	LOAD_SONG,
	SET_SONGID
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
	return (dispatch, store) => {
		let song = '';
		let length = 0;
		const bpm = store().setting.bpm;
		const mode = store().setting.mode;
		store().home.song.map((e) => {
			song = song + e.notes + '|' + e.duration + '|';
			length += e.duration;
		});
		song = song.slice(0, song.length - 1);
		const jsonToSend = {
			notes: song,
			mode: mode,
			bpm: bpm
		};
		console.log(jsonToSend);

		axios.post(url + 'songs/playCurrent', jsonToSend)
			.then((response) => {
				AlertIOS.alert('Song has been transferred to FPGA borad!');
				console.log(response);
			})
			.catch((error) => {
				console.log(error);
			});
	};
}

export function saveMusic(filename) {
	return (dispatch, store) => {
		let song = '';
		let length = 0;
		const mode = store().setting.mode;
		const bpm = store().setting.bpm;
		store().home.song.map((e) => {
			song = song + e.notes + '|' + e.duration + '|';
			length += e.duration;
		});
		song = song.slice(0, song.length - 1);

		if (store().home.mode === 'new') {
			const jsonToSend = {
				notes: song,
				mode,
				name: filename,
				length: length/1000,
				bpm
			};
			console.log(jsonToSend);

			axios.post(url + 'songs', jsonToSend)
				.then((response) => {
					console.log(response);
					const id = response.data.data.id;
					AlertIOS.alert('Save Successfully!');
					dispatch({
						type: SAVE_MUSIC,
						payload: 'edit'
					});
					dispatch({
						type: SET_SONGID,
						payload: id
					});
				})
				.catch((error) => {
					console.log(error);
				});
		} else {
			const jsonToSend = {
				notes: song,
				mode,
				length: length/1000,
				bpm
			};
			// console.log(jsonToSend);
			const songid = store().home.songid;
			console.log(songid);
			axios.put(url + 'songs/' + songid, jsonToSend)
				.then((response) => {
					console.log(response);
					// AlertIOS.alert('Save Successfully!');
				})
				.catch((error) => {
					console.log(error);
				});			
		}
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
		const link = url + 'songs/' + payload + '.json';
		axios.get(link)
		.then((response) => {
			var song = [];
			var element = {};
			response.data.data.attributes.notes.split('|').map((e, i) => {
				if (i % 2 === 0) {
					element.notes = e;
				}
				if (i & 2 !== 0) {
					element.duration = e;
					song.push(element);
				}
			});
			const id = response.data.data.id;
			const bpm = response.data.data.bpm;
			const mode = response.data.data.mode;
			dispatch({
				type: LOAD_SONG,
				song,
				id
			});
			Actions.home();
		})
		.catch((error) => {
			console.log(error);
		});
	};
}

function handleSaveMusic(state, action) {
	return update(state, {
		mode: {
			$set: action.payload
		}
	});
}

function handleLoadSong(state, action) {
	return update(state, {
		song: {
			$set: action.song
		},
		songid: {
			$set: action.id
		},
		mode: {
			$set: 'edit'
		}
	});
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

function handleSetSongId(state, action) {
	return update(state, {
		songid: {
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
	LOAD_SONG: handleLoadSong,
	SAVE_MUSIC: handleSaveMusic,
	SET_SONGID: handleSetSongId
};

const initialState = {
	song: [],
	currentNote: '',
	octave: 0,
	duration: '1/4',
	sign: '',
	selected: 0,
	mode: 'new',
	songid: '-1'
};

export function HomeReducer(state = initialState, action) {
	const handler = ACTION_HANDLERS[action.type];

	return handler ? handler(state, action) : state;
}
