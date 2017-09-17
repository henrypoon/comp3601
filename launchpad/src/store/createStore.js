import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import { createLogger } from 'redux-logger';
import makeRootReducer from './reducers';
import { composeWithDevTools } from 'remote-redux-devtools';


const log = createLogger({ diff: true, collapsed: true });

// a function which can create our store and auto-persist the data
export default (initialState = {}) => {
    // ======================================================
    // Middleware Configuration
    // ======================================================
    const middleware = [thunk, log];

    // ======================================================
    // Store Enhancers
    // ======================================================
    const enhancers = [];

    // ======================================================
    // Store Instantiation
    // ======================================================
    const store = createStore(
        makeRootReducer(),
        initialState,
        composeWithDevTools(
            applyMiddleware(...middleware),
            ...enhancers
        )
    );
    return store;
};
