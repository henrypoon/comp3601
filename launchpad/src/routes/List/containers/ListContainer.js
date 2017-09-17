import { connect } from 'react-redux';
import List from '../components/List';

import {
	setData
} from '../modules/list';

const mapStateToProps = (state) => ({
	data: state.list.data
});

const mapActionCreators = {
	setData
};

export default connect(mapStateToProps, mapActionCreators)(List);
