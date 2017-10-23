import { combineReducers } from 'redux';
import { HomeReducer as home } from '../routes/Home/modules/home';
import { ListReducer as list } from '../routes/List/modules/list';
import { SettingReducer as setting } from '../routes/Setting/modules/setting';
import { UploaderReducer as uploader } from '../routes/Uploader/modules/uploader';


export const makeRootReducer = () => {
	return combineReducers({
		home,
		list,
		setting,
		uploader
	});
};

export default makeRootReducer;
