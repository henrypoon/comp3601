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
	setSign
} from '../modules/home';

const mapStateToProps = (state) => ({
	octave: state.home.octave,
	duration: state.home.duration,
	setCurrentNote: state.home.setCurrentNote,
	song: state.home.song,
	selected: state.home.selected
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
	setSign
};
export default connect(mapStateToProps, mapActionCreators)(Home);
