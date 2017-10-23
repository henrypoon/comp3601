import { connect } from 'react-redux';
import Home from '../components/Home';
import {
	setOctave,
	setDuraction,
	playMusic,
	saveMusic,
	setCurrentNote,
	addToSong,
	deleteNote,
	setSelected,
	setSign,
	loadSong,
} from '../modules/home';

const mapStateToProps = (state) => ({
	octave: state.home.octave,
	duration: state.home.duration,
	setCurrentNote: state.home.setCurrentNote,
	song: state.home.song,
	selected: state.home.selected,
	mode: state.home.mode,
	songid: state.home.songid,
	sign: state.home.sign,
	bpm: state.setting.bpm
});

const mapActionCreators = {
	setOctave,
	setDuraction,
	playMusic,
	saveMusic,
	setCurrentNote,
	addToSong,
	deleteNote,
	setSelected,
	setSign,
	loadSong
};
export default connect(mapStateToProps, mapActionCreators)(Home);
