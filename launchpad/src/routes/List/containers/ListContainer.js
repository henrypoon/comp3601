import { connect } from 'react-redux';
import List from '../components/List';

import {
	setData,
	playMusic,
	deleteSong
} from '../modules/list';

import {
	loadSong
} from '../../Home/modules/home';

const mapStateToProps = (state) => ({
	data: state.list.data,
	song: state.home.song
});

const mapActionCreators = {
	setData,
	playMusic,
	loadSong,
	deleteSong
};

export default connect(mapStateToProps, mapActionCreators)(List);
