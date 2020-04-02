import React from 'react';
import API from '../data/API';
import { Link } from 'react-router-dom';

// The login component returns a login form or a welcome message for a logged in user
class Login extends React.Component {
	
	// defines the state for the component which is the username, password, error, and loggedin
	constructor(props){
		super(props);
		var logIn = false;
		if(localStorage.getItem('login')){
			logIn = true;
		}
		this.state = {
			loggedIn : logIn,
			error: false,
			username: "",
			password: ""
		}
		this.validiate = this.validiate.bind(this);
		this.logout = this.logout.bind(this);
	}

	// validate sends the username and password to the backedn to see if the user exists and returns a message
	async validiate(){
		const user = this.state.username;
		const pass = this.state.password;
		const checkUser = {username: user, password: pass} 
		const success = await API.login(checkUser);

		if(success){
			localStorage.setItem('login', user);
			localStorage.setItem('token', success);
			this.setState({loggedIn: true, error: false});
		}
		else{
			this.setState({error: true});
		}
	}

	// logs the current user out
	logout(){
		localStorage.removeItem('login');
		localStorage.removeItem('token');
	}

	// event handler to the username when something is typed
	handleUsernameChange(e){
		this.setState({username: e.target.value});
	}

	// event handler to the password when something is 
	handlePasswordChange(e){
		this.setState({password: e.target.value});
	}

	// render returns the login form or a welcome message
	render() {
		var message = null;
		var error;
		
		// if a user is not logged in, set the message to be a login 
		if(!this.state.loggedIn){
			message = (
				<div>
					<h2> Please enter your username and password</h2>
					<form>
						<div className="inputboxes">
							<b>Username: </b>
							<input 
						       	id = "username"
						       	size="10"
						       	type="text"
						       	value={this.state.username}
					        	onChange = {(e) => {this.handleUsernameChange(e)}}
						       />
					    </div>

					    <div className="inputboxes">
						    <b>Password: </b>
						    <input 
						  		id = "pass"
					        	size="10"
					        	type="password"
					        	value={this.state.password}
				        		onChange = {(e) => {this.handlePasswordChange(e)}}
					        />
				        </div>
						
						<div className="inputboxes">	
							<button type="button" className="orderButton" onClick={this.validiate}>
						        Log in
							</button>
						</div>

						<Link to="/Register">
							<button type="button" className="orderButton">
								Register
							</button>
						</Link>
					</form>
				</div>
			)
		}
		else{
			// if the user is logged in,  set meesage to a welcome message
			const username = localStorage.getItem('login');
			message = (
				<div>
					<h2> Welcome {username}</h2><br/>
     
					<Link to="/">
						<button type="button" className="orderButton" onClick={this.logout}>
							Log out
						</button>
					</Link>
				</div>
			)
		}

		// If an error occurs load an error box and display the message
		if(this.state.error){
			error = (
				<div>
					<div className="errorBox">
						<h3>The username or password you gave doesn't match our records.</h3>
					</div>
				</div>
			)
		}
		
  // return the error if there is one, and the message
		return( 
			<div className="App">
				<div className="home">
					{error}
					{message}
				</div>
			</div>
		);
	}
  
}

export default Login;