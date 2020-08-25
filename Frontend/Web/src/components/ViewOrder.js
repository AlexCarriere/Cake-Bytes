import React from 'react';
import API from '../data/API';
import { Link } from 'react-router-dom';
import Translator from './Translator';

class ViewOrder extends React.Component {
	
	// define the component
	constructor(props){
		super(props);
		this.state = {
			deleted: false,
			order: undefined,
		}
		this.deleteOrder = this.deleteOrder.bind(this);
	}

	// set up the state for the component
	componentDidMount(){
		var self = this;
		
		if(self.props.match){
			if(!this.state.deleted){
				var newOrder = API.getOrderByID(localStorage.getItem('login'), this.props.match.params.number, localStorage.getItem('token'))
				
				self.setState({order: newOrder});
			}
		}
	
	}

	// Delete the order the user is viewing
	deleteOrder(){
		API.deleteOrder(localStorage.getItem('login'), this.state.order.order_id, localStorage.getItem('token'));
		this.setState({deleted: true})
	}

	// render the order, and send it back
	render(props){
		var message;
		var topping, frosting, base;

		if(this.state.order == undefined) {
			message = <h2>Sorry, but no order was found</h2>
		}
		else{
			if(this.state.order.detail.topping !== "none"){
				topping = (<img className="topping" src={Translator.getToppingImg(this.state.order.detail.topping)} alt="topping" height="60"/>);
			}
			frosting = ( <img className="frosting" src={Translator.getFrostingImg(this.state.order.detail.frosting)} alt="frosting" width="150" height="125"/> );
			base = ( <img className="base" src={Translator.getBaseImg(this.state.order.detail.base)} alt="cupcake base" width="150" height="125"/>);

			message = (
				<div>
					<h1>Order Details: </h1>
					
					<p>
						<b>Order Status:</b> {this.state.order.status}<br/>
						<b>Time of Order:</b> {this.state.order.timestamp}<br/>
						<b>Order Number:</b> {this.state.order.order_id}
					</p>

					<p>
						<b>Order placed by:</b> {this.state.order.first_name} {this.state.order.last_name} <br/>
						<b>Quantity Ordered:</b> {this.state.order.amount} dozen <br/>
					</p>

					<p>
						<b>Cupcake Requested:</b>
					</p>
					
					<div className="cupcakeDisplay">
				   		{topping} <br/>
				   		{frosting}<br/>
				  		{base}
			 		</div>
					
			 		<div className="orderSpace">
						<Link to={`/order/${this.state.order.order_id}`}>
							<button className="orderButton">
								Edit Order
							</button>
						</Link>
					</div>

					<div className="orderSpace">
						<Link to="../">
							<button className="deleteButton" onClick={this.deleteOrder.bind(this)}>
								Delete Order
							</button>
						</Link>
					</div>
				</div>
			);
		}

		return (
			<div className="App">
				<div className="home">
					{message}
				</div>	
			</div>
		)
	}

}

export default ViewOrder