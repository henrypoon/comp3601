import { connect } from 'react-redux';
import Home from '../components/Home';
import {
	setOctave,
	setDuraction,
	playMusic,
	saveMusic,
	setCurrentNote,
	addToSong,
	deleteNote
} from '../modules/home';

const mapStateToProps = (state) => ({
	octave: state.home.octave,
	duration: state.home.duration,
	setCurrentNote: state.home.setCurrentNote,
	song: state.home.song
});

const mapActionCreators = {
	setOctave,
	setDuraction,
	playMusic,
	saveMusic,
	setCurrentNote,
	addToSong,
	deleteNote
};
export default connect(mapStateToProps, mapActionCreators)(Home);
