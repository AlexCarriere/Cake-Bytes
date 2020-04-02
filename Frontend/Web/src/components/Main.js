import React from 'react';
import { Switch, Route } from 'react-router-dom';
import Home from './Home';
import Order from './Edit';
import Orders from './Orders';
import Login from './Login';
import Register from './Register';
import Cupcake from './Cupcakes';
import CupcakeTemplates from './CupcakeTemplates';

// Main component sets up all of the components and then routes the component to the url provided
class Main extends React.Component {
	
	// render the switch and return it
	render() {
		return(
			<main>
				<Switch>
					<Route exact path = '/' component={Home} />
					<Route path = '/order/' component={Order}/>
					<Route path = '/orderhistory' component = {Orders}/>
					<Route path = '/login' component = {Login}/>
					<Route path = '/Register' component = {Register}/>
					<Route path = '/cupcakesMaker' component = {Cupcake}/>
					<Route path = '/cupcakes' component = {CupcakeTemplates}/>
				</Switch>
			</main>
		);
	}

}

export default Main