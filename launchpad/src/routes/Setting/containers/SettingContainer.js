import { connect } from 'react-redux';
import Setting from '../components/Setting';

import {
	changeMode,
	selectMode,
	setBpm
} from '../modules/setting';

const mapStateToProps = (state) => ({
	mode: state.setting.mode,
	selected_mode: state.setting.selected_mode,
	bpm: state.setting.bpm
});

const mapActionCreators = {
	changeMode,
	selectMode,
	setBpm
};

export default connect(mapStateToProps, mapActionCreators)(Setting);
