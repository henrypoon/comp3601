import { combineReducers } from 'redux';
import { HomeReducer as home } from '../routes/Home/modules/home';
import { ListReducer as list } from '../routes/List/modules/list';
// import { NavReducer as tab } from '../AppContainer/NavBar/modules/nav';


export const makeRootReducer = () => {
	return combineReducers({
		home,
		list,
	});
};

export default makeRootReducer;
