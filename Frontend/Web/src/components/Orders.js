import React from 'react';
import { Switch, Route } from 'react-router-dom';
import ViewOrder from './ViewOrder';
import OrderHistory from './OrderHistory';

//This component is for sending the page to the correct page, either orderhistory or a specific viewOrder
class Orders extends React.Component { 
	
	render() {
		return(
			<Switch>
				<Route exact path='/orderhistory' component={OrderHistory}/>
				<Route path ='/orderhistory/:number' component={ViewOrder}/>
			</Switch>
		);
	}

}

export default Orders