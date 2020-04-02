import React from 'react';
import API from '../data/API';
import { Link } from 'react-router-dom';
import Translator from './Translator';

// CupcakeTemplates Component returns a 'select a starting cupcake', has two parts a 'our favourites' of hard coded cupcakes to start from and then
// a list of all of the users previous orders
class CupcakeTemplates extends React.Component {

	// define the components state, which is just a list of orders that the user has made
	constructor(props){
		super(props);
		
		this.state = {
			orders: []
		}
	}

	// Set the state for the inital component load, fill the list of orders with all of the orders a user has placed
	componentWillMount(){
		var self = this;
		
		if(localStorage.getItem('login')){
			API.getUsersOrders(localStorage.getItem('login'), localStorage.getItem('token')).then(orders => {
				orders.map((order) => {
					var newOrders = self.state.orders.slice();
					newOrders.push(order);

					self.setState({
						orders: newOrders
					});
				}); 
			})
		}
	}

	// render the template page and return it back to the parent component
	render(){
		var ourFavourite = undefined;
		var prevOrder = undefined;
	
		// set our favourite cupcakes that are hardcoded choices
		ourFavourite = (
			<div>
				<h3>Our Favourite Cupcakes</h3>
				<ul className="toolbarList">
					<li className="prevCupcakes">
						<div className="prevCupcakeHolder">
							<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg("cherry"), frosting: Translator.getFrostingImg("vanilla"), base: Translator.getBaseImg("chocolate") }}}>
								<img className="prevToppings" src={Translator.getToppingImg("cherry")} alt="topping" height="60"/><br/>
								<img className="prevFrosting" src={Translator.getFrostingImg("vanilla")} alt="topping" height="60"/><br/>
								<img className="prevBase" src={Translator.getBaseImg("chocolate")} alt="topping" height="60"/>
							</Link>
						</div>
					</li>
					<li className="prevCupcakes">
						<div className="prevCupcakeHolder">
							<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg("rainbow_sprinkle"), frosting: Translator.getFrostingImg("mint"), base: Translator.getBaseImg("vanilla") }}}>
								<img className="prevToppings" src={Translator.getToppingImg("rainbow_sprinkle")} alt="topping" height="60"/><br/>
								<img className="prevFrosting" src={Translator.getFrostingImg("mint")} alt="topping" height="60"/><br/>
								<img className="prevBase" src={Translator.getBaseImg("vanilla")} alt="topping" height="60"/>
							</Link>
						</div>
					</li>
					<li className="prevCupcakes">
						<div className="prevCupcakeHolder">
							<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg("pocky"), frosting: Translator.getFrostingImg("vanilla"), base: Translator.getBaseImg("redvelvet") }}}>
								<img className="prevToppings" src={Translator.getToppingImg("pocky")} alt="topping" height="60"/><br/>
								<img className="prevFrosting" src={Translator.getFrostingImg("vanilla")} alt="topping" height="60"/><br/>
								<img className="prevBase" src={Translator.getBaseImg("redvelvet")} alt="topping" height="60"/>
							</Link>
						</div>
					</li>
					<li className="prevCupcakes">
						<div className="prevCupcakeHolder">
							<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg("strawberry"), frosting: Translator.getFrostingImg("chocolate"), base: Translator.getBaseImg("vanilla") }}}>
								<img className="prevToppings" src={Translator.getToppingImg("strawberry")} alt="topping" height="60"/><br/>
								<img className="prevFrosting" src={Translator.getFrostingImg("chocolate")} alt="topping" height="60"/><br/>
								<img className="prevBase" src={Translator.getBaseImg("vanilla")} alt="topping" height="60"/>
							</Link>
						</div>
					</li>
					<li className="prevCupcakes">
						<div className="prevCupcakeHolder">
							<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg("star_sprinkle"), frosting: Translator.getFrostingImg("vanilla"), base: Translator.getBaseImg("vanilla") }}}>
								<img className="prevToppings" src={Translator.getToppingImg("star_sprinkle")} alt="topping" height="60"/><br/>
								<img className="prevFrosting" src={Translator.getFrostingImg("vanilla")} alt="topping" height="60"/><br/>
								<img className="prevBase" src={Translator.getBaseImg("vanilla")} alt="topping" height="60"/>
							</Link>
						</div>
					</li>
					<li className="prevCupcakes">
						<div className="prevCupcakeHolder">
							<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg("eatMe"), frosting: Translator.getFrostingImg("chocolate"), base: Translator.getBaseImg("redvelvet") }}}>
								<img className="prevToppings" src={Translator.getToppingImg("eatMe")} alt="topping" height="60"/><br/>
								<img className="prevFrosting" src={Translator.getFrostingImg("chocolate")} alt="topping" height="60"/><br/>
								<img className="prevBase" src={Translator.getBaseImg("redvelvet")} alt="topping" height="60"/>
							</Link>
						</div>
					</li><br/>
					<li>
						<div className="scratchButton">
							<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg("none"), frosting: Translator.getFrostingImg("vanilla"), base: Translator.getBaseImg("vanilla") }}}>
								<button className="orderButton">
									Start From Stratch!
								</button>
							</Link>
						</div>
					</li>
				</ul>
			</div>
		);

		// If the user is logged in, and they have atleast one order, we can load a list of their previous orders
		if(localStorage.getItem('login')){
			if(this.state.orders.length > 0){
				prevOrder = (
					<div>
						<hr className="break"/>
						<h3>Your Previous Orders</h3>
						<ul className="toolbarList">
						{
							this.state.orders.map(order => {
								var topping;

								if(order.detail.deco != "none"){
									topping = ( <img className="prevToppings" src={Translator.getToppingImg(order.detail.deco)} alt="topping" height="60"/> );
								}
								return(
									<li className="prevCupcakes" key={order.order_id}>
										<div className="prevCupcakeHolder">
											<Link to={{ pathname: '/cupcakesMaker', state: { topping: Translator.getToppingImg(order.detail.deco), frosting: Translator.getFrostingImg(order.detail.icing), base: Translator.getBaseImg(order.detail.base) }}}>
												{topping}<br/>
												<img className="prevFrosting" src={Translator.getFrostingImg(order.detail.icing)} alt="topping" height="60"/><br/>
												<img className="prevBase" src={Translator.getBaseImg(order.detail.base)} alt="topping" height="60"/>
											</Link>
										</div>
									</li>
								);
							})
						}
						</ul>
					</div>
				);
			}
		}

		// wrap ourfavourit and the previous order into the container and send it back to the parent component
		return(
			<div className="App">
				<div className="home">
					<h2>Please Select a Template:</h2>
					{ourFavourite}
					{prevOrder}
				</div>
			</div>
		);
	}
	
}

export default CupcakeTemplates;