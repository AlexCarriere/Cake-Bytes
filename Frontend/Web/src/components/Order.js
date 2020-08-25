import React from 'react';
import API from '../data/API';
import Translator from './Translator';

// The order component returns an order form for either a new order to to update an existing order
class Order extends React.Component {
	
	// Define the components state
	constructor(props){
		super(props);

		this.state = {
			orderComplete: false,
			order: undefined,
			topping: "none",
			frosting: "vanilla",
			base: "vanilla",
			firstName: "",
			lastName: "",
			amount: 0,
			error: false,
		}

		this.updateOrder = this.updateOrder.bind(this);
		this.addOrder = this.addOrder.bind(this);
	}

	// Set the inital state, which is if there is an order number being passed to it, load that order for editing
	componentDidMount(){
		var self = this;
		var newOrder = API.getOrderByID(localStorage.getItem('login'), this.props.match.params.number, localStorage.getItem('token'))

		if(localStorage.getItem('login')){
			if(!this.state.orderComplete){
				if(!this.props.location.state){

					self.setState({order: newOrder, firstName: newOrder.first_name, lastName:newOrder.last_name, amount: newOrder.amount});
				}
			}
		}
	}

	// add the currently entered information and send it to the server as an order
	addOrder(){
		var validInput = validateOrder(this.state.firstName, this.state.lastName, this.state.amount);

		if(validInput){
			const topping = Translator.getToppingString(this.props.location.state.topping);
			const frosting = Translator.getFrostingString(this.props.location.state.frosting);
			const base = Translator.getBaseString(this.props.location.state.base);

			const newOrder = {
				first_name: this.state.firstName, last_name: this.state.lastName, amount: this.state.amount, cupcake: {topping: topping, frosting: frosting, base: base}
			}

			API.newOrder(localStorage.getItem('login'), newOrder, localStorage.getItem('token'));
			this.setState({orderComplete: true});
		}
		else{
			this.setState({error: true});
		}
	}

	// update the order passed to the 
	updateOrder(order){
		var validInput = validateOrder(this.state.firstName, this.state.lastName, this.state.amount);

		if(validInput){
			const user = localStorage.getItem('login');

			const updateOrder = {
				order_id: this.state.order.order_id, first_name: this.state.firstName, last_name: this.state.lastName, amount: this.state.amount, detail: this.state.order.detail, timestamp: this.state.order.timestamp, status: this.state.order.status
			}
			API.updateOrder(localStorage.getItem('login'), updateOrder, localStorage.getItem('token'));
			this.setState({orderComplete: true});
		}
		else{
			this.setState({error: true});
		}
	}

	// handles change of the firstname box
	handleFNameChange(e){
		this.setState({firstName: e.target.value});
	}

	// handles change of the lastname box
	handleLNameChange(e){
		this.setState({lastName: e.target.value});
	}

	// handles change in the amount box
	handleAmountChange(e){
		this.setState({amount: e.target.value});
	}

	// render the order page, and then return it
	render(props){
		var message, error;
		var topping, frosting, base;
		
		// If the order has been placed, load a thank you message, otherwise load the order form
		if(this.state.orderComplete){
			message = (
				<div>
					<h2>We will contact you when your cupcakes are ready for pickup<br/><br/>
					Thank you for your order!
					</h2>
				</div>
			)
		}
		else if(!localStorage.getItem('login')){
			// If someone makes it here without being logged in, load a please log in message
			message = (
				<div>
					<h2>Please Log in to create new orders</h2>
				</div>
			)
		}
		else{
			// if there is no order set in the state it means we are creating a new order and not editing, so load the new order
			if(this.state.order != undefined){
				// Get the cupcake details passed to it from the cupcake maker component, and load them onto the page
				const cupTopping = Translator.getToppingImg(this.state.order.detail.topping);
				const cupFrosting = Translator.getFrostingImg(this.state.order.detail.frosting);
				const cupBase = Translator.getBaseImg(this.state.order.detail.base);
				
				if(cupTopping != "none"){
					topping = (<img className="topping" src={cupTopping} alt="topping" height="60"/>);
				}
				frosting = (<img className="frosting" src={cupFrosting} alt="frosting" width="150" height="125"/>);
				base = (<img className="base" src={cupBase} alt="cupcake base" width="150" height="125"/>);

				// load the old order sheet into a variable to be rendered
				message = (
					<div>
						<h1>Please Enter Your Information</h1>
						<h4>If you wish to edit your cupcake, please remake the order</h4>
						<form className="OrderSheet" action="#">
							
							<div className="inputboxes">
								<b> First Name: </b>
						        <input 
				        			id = "firstName"
				        			size="10"
				        			type="text"
				        			value={this.state.firstName}
				        			onChange={(e) => {this.handleFNameChange(e)}}
				        		/>
					      	</div>
					      	
					      	<div className="inputboxes">
						      	<b>Last Name: </b>
						      		<input 
					        			id="lastName"
					        			size="10"
					        			type="text"
					    				value={this.state.lastName}
					    				onChange={(e) => {this.handleLNameChange(e)}}
									/>
							</div>
					      	
					      	<div className="inputboxes">
						      	<b>Amount: </b>    
							    <input
									id="amount"
					        		type="number"
					        		name="Amount"
					        		min = "1"
							        max = "100"
									value={this.state.amount}
									onChange={(e) => {this.handleAmountChange(e)}}
								/>
						    	<div className="dozen">dozen</div>
					    	</div>
							
							<b>Cupcake Wanted: </b>
						</form>
						
						<div className="cupcakeDisplay">
				   			{topping}<br/>
				   			{frosting}<br/>
				   			{base}
			 			</div>

				   		<nav>
					   		<button className="cupcakeOrderButton" onClick={this.updateOrder.bind(this)}>
					   			Update Order
					   		</button>
				   		</nav>
				   	</div>
				);
			}
			else{
				// If there is no order to load, it must be a new order, so load the props passed from the cupcake maker
				if(this.props.location.state){
					if(this.props.location.state.topping != "none"){
						topping = ( <img className="topping" src={this.props.location.state.topping} alt="topping" height="60"/> );
					}
					frosting = ( <img className="frosting" src={this.props.location.state.frosting} alt="cupcake base" width="150" height="125"/> );
					base = ( <img className="base" src={this.props.location.state.base} alt="cupcake base" width="150" height="125"/> );
				}

				// set the message variable as a new order form
				message = (
					<div>
						<h1>Please Enter Your Information</h1>
						<form className="OrderSheet" action="#">
							<div className="inputboxes">
								<b> First Name: </b>
								<input 
						        	id = "firstName"
						        	size="10"
						        	type="text"
						        	placeholder="First Name"
							        value={this.state.firstName}
							        onChange={(e) => {this.handleFNameChange(e)}}
						        />
					      	</div>

					      	<div className="inputboxes">
						      	<b>Last Name: </b>
						      	<input 
					        		id = "lastName"
					        		size="10"
					        		type="text"
					        		placeholder="Last Name"
					        		value={this.state.lastName}
					        		onChange={(e) => {this.handleLNameChange(e)}}
					    		/>
							</div>

							<div className="inputboxes">
						      	<b>Amount: </b>    
								<input
									id="amount"
							        type="number"
							        name="Amount"
							        min = "1"
							        max = "100"
							        placeholder="0"
							        value={this.state.amount}
							        onChange={(e) => {this.handleAmountChange(e)}}
								/>
						    	<div className="dozen">dozen</div>
					    	</div>
						</form>
						
						<b>Cupcake Wanted: </b>
				   		<div className="cupcakeDisplay">
				   			{topping}<br/>
				   			{frosting}<br/>
				   			{base}
			 			</div>
				   		
				   		<nav>
							<button className="cupcakeOrderButton" onClick={this.addOrder}>
						   		Complete Order
						   	</button>
				   		</nav>			 			
					</div>
				);
			}
		}

		if(this.state.error){
			error = (
				<div className="errorBox">
					<h3>Please ensure you have completed all fields</h3>
				</div>
			);
		}

		// return the message variable wrapped in the home box
		return(
			<div className="App">
				<div className="home">
					{error}
					{message}
				</div>
			</div>
		)
	}

}

function validateOrder(fName, lName, amount){
	var valid = true;

	if(amount <= 0 || fName == "" || lName == ""){
		valid = false;
	}


	return valid;
}


export default Order