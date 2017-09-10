import { connect } from 'react-redux';
import Home from '../components/Home';
import {
	setSlider1,
	setSlider2,
	playMusic
} from '../modules/home';

const mapStateToProps = (state) => ({
	sliderVal1: state.home.sliderVal1,
	sliderVal2: state.home.sliderVal2
});

const mapActionCreators = {
	setSlider1,
	setSlider2,
	playMusic
};
export default connect(mapStateToProps, mapActionCreators)(Home);
