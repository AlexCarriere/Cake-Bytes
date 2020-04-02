import React from 'react';
import { Switch, Route } from 'react-router-dom';
import Order from './Order';

// Edit component gets all of the pages directed at Order and then sends it to the correct order form
class Edit extends React.Component {
	
	render() { 
		return (
			<Switch>
				<Route exact path='/order' component={Order}/>
				<Route path ='/order/:number' component={Order}/>
			</Switch>
		);
	}
	
}

export default Edit