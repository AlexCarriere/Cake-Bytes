import React from 'react';
import API from '../data/API';
import { Link } from 'react-router-dom';

// The orderhistory component returns a list of all of the orders from the logged in user
class OrderHistory extends React.Component {

	// define the component
	constructor(props){
		super(props);
		this.state = {
			orders: []
		}
	}

	// set the inital state by getting the orders placed by the user logged in
	componentWillMount(){
		var self = this;
		var newOrders = self.state.orders.slice();
    
		if(localStorage.getItem('login')){
			var orders = API.getUsersOrders(localStorage.getItem('login'), localStorage.getItem('token'));
			orders.map((order) => {
				console.log("here")
				newOrders.push(order);

				self.setState({
					orders: newOrders
				});
			}); 
		}
	}

	// make sure that the user is logged in before trying to load orders
	requireAuth() {
		var message = null;

		if(!localStorage.getItem('login')){
			message = (
				<div>
					<h2>Please Log in to see your orders</h2>
				</div>
			)
		}

		return message;	
	}

	// Render the list of orders and return it to the parent component
	render() {
		const message  = this.requireAuth();
		var page = undefined;

		console.log(this.state.orders)

		if(!message){
			page = (
				<div>
					<h2> Orders Recieved: </h2>
						<ul className="linklist">
							{
								this.state.orders.map(order => (
									<li key={order.order_id}>
										<Link className="links" to={`/orderhistory/${order.order_id}`}>Order: {order.first_name} {order.last_name} for {order.amount} dozen cupcakes</Link>
									</li>
								))
							}
						</ul>
				</div>
			)
		}
		else{
			page = message;
		}

		return (
			<div className="App">
				<div className="home">
					{page}
				</div>
			</div>
		)
	}

}



export default OrderHistory;