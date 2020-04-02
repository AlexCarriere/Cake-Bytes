import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import {shallow, configure} from 'enzyme';

import App from '../components/App';
import Cupcakes from '../components/Cupcakes';
import CupcakeTemplate from '../components/CupcakeTemplates';
import Edit from '../components/Edit';
import Header from '../components/Header';
import Home from '../components/Home';
import Login from '../components/Login';
import Main from '../components/Main';
import Orders from '../components/Orders';
import OrderHistory from '../components/OrderHistory';
import Register from '../components/Register';
import ViewOrder from '../components/ViewOrder';

configure({adapter: new Adapter()});

// need to make better acceptance tests not enough time, currently just checks if the components render without errors
describe('Make sure all components can ', () => {
	
	it('App renders without crashing', () => {
		shallow(<App />);
	});

	it('cupcake maker renders without crashing', () => {
		shallow(<Cupcakes/>);
	});

	it('renders without crashing', () => {
		shallow(<CupcakeTemplate />);
	});

	it('renders without crashing', () => {
		shallow(<Edit />);
	});

	it('renders without crashing', () => {
		shallow(<Header />);
	});

	it('renders without crashing', () => {
		shallow(<Home />);
	});

	it('renders without crashing', () => {
		shallow(<Login />);
	});

	it('renders without crashing', () => {
		shallow(<Main />);
	});

	it('renders without crashing', () => {
		shallow(<OrderHistory />);
	});

	it('renders without crashing', () => {
		shallow(<Orders />);
	});

	it('renders without crashing', () => {
		shallow(<Register />);
	});

	it('renders without crashing', () => {
		shallow(<ViewOrder />);
	});

});