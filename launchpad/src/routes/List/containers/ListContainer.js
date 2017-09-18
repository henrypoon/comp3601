import { connect } from 'react-redux';
import List from '../components/List';

import {
	setData,
	playMusic
} from '../modules/list';

const mapStateToProps = (state) => ({
	data: state.list.data
});

const mapActionCreators = {
	setData,
	playMusic
};

export default connect(mapStateToProps, mapActionCreators)(List);
