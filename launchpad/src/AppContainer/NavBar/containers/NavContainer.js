import { connect } from 'react-redux';
import Nav from '../components/Nav';
import {
	setTab
} from '../modules/nav';


const mapStateToProps = (state) => ({
	tab: state.tab.tab
});

const mapActionCreators = {
	setTab
};

export default connect(mapStateToProps, mapActionCreators)(Nav);