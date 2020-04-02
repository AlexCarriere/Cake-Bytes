import React from 'react';
import { Draggable, Droppable } from 'react-drag-and-drop';
import { Link } from 'react-router-dom';
import Translator from './Translator'

// the cupcake component is the interactive cupcake maker
class Cupcakes extends React.Component {
	
	// set the inital state of the component
	constructor(props){
		super(props);
		var topping, base, frosting;
		if(this.props.location){
			if(this.props.location.state){
				topping = this.props.location.state.topping;
				frosting = this.props.location.state.frosting;
				base = this.props.location.state.base;
			}
			else{
				topping = "none";
				frosting = Translator.getFrostingImg("vanilla");
				base = Translator.getBaseImg("chocolate");
			}
		}

		this.state = {
			frosting: frosting,
			topping: topping,
			base: base,
			tab: "base"
		};

		this.changeFrosting = this.changeFrosting.bind(this);
		this.changeTopping = this.changeTopping.bind(this);
		this.changeCustomBar = this.changeCustomBar.bind(this);
	}

	// the event that triggers when you change frosting, sets the state to the frosting clicked
	changeFrosting(frostingCol){
		if(frostingCol.frosting){
			this.setState({frosting: frostingCol.frosting});	
		}
		else{
			this.setState({frosting: frostingCol});	
		}
	}

	// the event that triggers when you change toppings, sets the state to the frosting clicked
	changeTopping(toppingType){
		if(toppingType.toppings){
			this.setState({topping: toppingType.toppings});
		}
		else{
			this.setState({topping: toppingType});
		}
	}

	// the event that truggers when you change base, set the state to the base clicked
	changeBase(baseType){
		if(baseType.base){
			this.setState({base: baseType.base});
		}
		else{
			this.setState({base: baseType});
		}
	}

	// event handler for clicking on an item on the customization bar
	changeCustomBar(tab){
		if(tab == "topping") {
			this.setState({tab: "topping"});
		}
		else if(tab == "frosting") {
			this.setState({tab: "frosting"});
		}
		else if(tab == "base") {
			this.setState({tab: "base"});
		}
	}

	// create a page to be return and the return it to the parent component
	render(){
		var topping;
		var tab;

		// If there is a topping, load the topping if not, load an empty space
		if(this.state.topping != "none"){
			topping = (
				<div className="toppingContainer">
					<img src={this.state.topping} alt="topping" height="60"/>
				</div>
			);
		}
		else{
			topping = (
				<div className="toppingContainer">
				</div>
			);
		}
		
		// load up the current tab based on the state
		if(this.state.tab == "base"){
			tab = (
				<div className="tab">
					<h3>Bases</h3>
					<br/>
					<div className="btn-group">
						<div className="toppingContainer">
							<Draggable className="drag" type="base" data={Translator.getBaseImg("chocolate")}>
								<div className="customToolTip">
									<input
										type="image"
										alt = "Chocolate"
										src={Translator.getBaseImg("chocolate")}
										height="90px"
										className="toppingButtons"
										onClick={this.changeBase.bind(this, Translator.getBaseImg("chocolate"))}
									/>
									<div className="toolTipTextBase">Chocolate</div>
								</div>
							</Draggable>
							
							<Draggable className="drag" type="base" data={Translator.getBaseImg("vanilla")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getBaseImg("vanilla")}
										height="90px"
										className="toppingButtons"
										onClick={this.changeBase.bind(this, Translator.getBaseImg("vanilla"))}
									/>
									<div className="toolTipTextBase">Vanilla</div>
								</div>
							</Draggable> <br/><br/>
							
							<Draggable className="drag" type="base" data={Translator.getBaseImg("redvelvet")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getBaseImg("redvelvet")}
										height="90px"
										className="toppingButtons"
										onClick={this.changeBase.bind(this, Translator.getBaseImg("redvelvet"))}
									/>
									<div className="toolTipTextBase">Red Velvet</div>
								</div>
							</Draggable>
						</div>
					</div>
				</div>
			);
		}
		else if(this.state.tab == "frosting"){
			tab = (
				<div className="tab">
					<h3>Frosting</h3>
					<div className="btn-group">
						<div className="floatSide"><br/>
							
							<Draggable className="drag" type="frosting" data={Translator.getFrostingImg("chocolate")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getFrostingImg("chocolate")}
										height="70px"
										className="toppingButtons"
										onClick={this.changeFrosting.bind(this, Translator.getFrostingImg("chocolate"))}
									/>
									<div className="toolTipTextFrosting">Chocolate</div>
								</div>
							</Draggable>
							
							<Draggable className="drag" type="frosting" data={Translator.getFrostingImg("vanilla")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getFrostingImg("vanilla")}
										height="70px"
										className="toppingButtons"
										onClick={this.changeFrosting.bind(this, Translator.getFrostingImg("vanilla"))}
									/>
									<div className="toolTipTextFrosting">Vanilla</div>
								</div>
							</Draggable><br/><br/>
								
							<Draggable className="drag" type="frosting" data={Translator.getFrostingImg("mint")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getFrostingImg("mint")}
										height="70px"
										className="toppingButtons"
										onClick={this.changeFrosting.bind(this, Translator.getFrostingImg("mint"))}
									/>
									<div className="toolTipTextFrosting">Mint</div>
								</div>
							</Draggable>
									
							<Draggable className="drag" type="frosting" data={Translator.getFrostingImg("lime")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getFrostingImg("lime")}
										height="70px"
										className="toppingButtons"
										onClick={this.changeFrosting.bind(this, Translator.getFrostingImg("lime"))}
									/>
									<div className="toolTipTextFrosting">Lime</div>
								</div>
							</Draggable>
						</div>
					</div>
				</div>
			);
		}
		else if(this.state.tab == "topping"){
			tab = (
				<div className="tab">
					<h3>Toppings</h3><br/>
					<div className="btn-group">
						<div className="toppingContainer">
							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("cherry")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("cherry")}
										height= "60px"
										width="40px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("cherry"))}
									/>
									<div className="toolTipTextTopping">Cherries</div>
								</div>
							</Draggable>
								
							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("orange")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("orange")}
										height= "60px"
										width= "40px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("orange"))}
									/>
									<div className="toolTipTextTopping">Oranges</div>
								</div>
							</Draggable>
								
							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("rainbow_sprinkle")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("rainbow_sprinkle")}
										height= "60px"
										width="70px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("rainbow_sprinkle"))}
									/>
									<div className="toolTipTextSprinkles">Sprinkes</div>
								</div>
							</Draggable><br/><br/>
							
							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("eatMe")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("eatMe")}
										height= "60px"
										width="40px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("eatMe"))}
									/>
									<div className="toolTipTextTopping">Eat Me</div>
								</div>
							</Draggable>
										
							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("blackberry")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("blackberry")}
										height= "60px"
										width="50px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("blackberry"))}
									/>
									<div className="toolTipTextTopping">Blackberries</div>
								</div>
							</Draggable>

							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("heart_sprinkle")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("heart_sprinkle")}
										height= "60px"
										width="70px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("heart_sprinkle"))}
									/>
									<div className="toolTipTextSprinkles">Hearts</div>
								</div>
							</Draggable><br/><br/>
							
							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("pocky")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("pocky")}
										height= "60px"
										width="40px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("pocky"))}
									/>
									<div className="toolTipTextTopping">Pocky</div>
								</div>
							</Draggable>


							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("strawberry")}>
								<div className="customToolTip">
									<input
										type="image"
										src={Translator.getToppingImg("strawberry")}
										height="60px"
										width="50px"
										className="toppingButtons"
										onClick={this.changeTopping.bind(this, Translator.getToppingImg("strawberry"))}
									/>
									<div className="toolTipTextTopping">Strawberries</div>
								</div>
							</Draggable>

							<Draggable className="drag" type="toppings" data={Translator.getToppingImg("star_sprinkle")}>
								<div className="customToolTip">
								<input
									type="image"
									src={Translator.getToppingImg("star_sprinkle")}
									height="60px"
									width="60px"
									className="toppingButtons"
									onClick={this.changeTopping.bind(this, Translator.getToppingImg("star_sprinkle"))}
								/>
								<div className="toolTipTextSprinkles">Stars</div>
								</div>
							</Draggable><br/><br/>
										
							<button className="noneButton" onClick={this.changeTopping.bind(this, "none")}>
								None
							</button>
						</div>
					</div>
				</div>
			);
		}

		// Return the cupcake maker to the parent component
		return(
			<div className="App">
				<div className="home">
					<div className="sidebar">
							<ul className="customBarlist">
								<li className="items" onClick={this.changeCustomBar.bind(this, "base")}>Bases</li>
								<li className="items" onClick={this.changeCustomBar.bind(this, "frosting")}>Frostings</li>
								<li className="items" onClick={this.changeCustomBar.bind(this, "topping")}>Toppings</li>
							</ul>
							{tab}
					</div>
					<div>
						<h1>Build Your Cupcake</h1>
						<Droppable types={['toppings']} onDrop={this.changeTopping.bind(this)}>
							{topping}
						</Droppable><br/>

						<Droppable types={['frosting']} onDrop={this.changeFrosting.bind(this)}>
							<img src={(this.state.frosting)} alt="frosting" width="150" height="125"/>
						</Droppable>

						<Droppable types={['base']} onDrop={this.changeBase.bind(this)}>
							<img src={(this.state.base)} alt="cupcake base" width="150" height="125"/>
						</Droppable>

						<div className="cupcakeButtonContainer" onClick={this.orderCupcake}>
							<Link to={{ pathname: '/order', state: { base: this.state.base, frosting: this.state.frosting, topping: this.state.topping}}}>
								<button className="cupcakeButton">
									Create Order
								</button>
							</Link>
						</div>
					</div>
				</div>
			</div>
		);
	}
}


export default Cupcakes;