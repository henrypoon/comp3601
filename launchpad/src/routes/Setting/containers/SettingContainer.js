import { connect } from 'react-redux';
import Setting from '../components/Setting';

import {
	changeMode
} from '../modules/setting';

const mapStateToProps = (state) => ({
	mode: state.setting.mode
});

const mapActionCreators = {
	changeMode
};

export default connect(mapStateToProps, mapActionCreators)(Setting);
