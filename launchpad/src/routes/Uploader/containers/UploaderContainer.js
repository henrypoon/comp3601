import { connect } from 'react-redux';
import Uploader from '../components/Uploader';

import {
	uploadFile
} from '../modules/uploader';

const mapStateToProps = (state) => ({
});

const mapActionCreators = {
	uploadFile
};

export default connect(mapStateToProps, mapActionCreators)(Uploader);
