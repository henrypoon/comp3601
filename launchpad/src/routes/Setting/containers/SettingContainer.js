import { connect } from 'react-redux';
import Setting from '../components/Setting';

import {
	changeMode,
	selectMode
} from '../modules/setting';

const mapStateToProps = (state) => ({
	mode: state.setting.mode,
	selected_mode: state.setting.selected_mode
});

const mapActionCreators = {
	changeMode,
	selectMode
};

export default connect(mapStateToProps, mapActionCreators)(Setting);
