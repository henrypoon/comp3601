import { combineReducers } from 'redux';
import { HomeReducer as home } from '../routes/Home/modules/home';
import { ListReducer as list } from '../routes/List/modules/list';


export const makeRootReducer = () => {
	return combineReducers({
		home,
		list
	});
};

export default makeRootReducer;
