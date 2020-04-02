import React from 'react';
import API from '../data/API';

// The reigster component loads a register page for users
class Register extends React.Component {
	
	// define the state for the component;
	constructor(props){
		super(props);
		this.state = {
			registered: false,
			error: 0,
			username: "",
			password: "",
			rPassword: ""
		}
		this.addUser = this.addUser.bind(this);
	}		

	// event handler for the sign up button that sends the username and password to the db
	async addUser(){
		const newUserName = this.state.username;	
		const newPass = this.state.password;
		const repeatPass = this.state.rPassword;

		if(newPass != repeatPass || newPass.length == 0){
				this.setState({error: 1});
		}
		else {
			const newUser = {
				username: newUserName, password: newPass
			}
			var login = await API.register(newUser);

			if(login){
				localStorage.setItem('login', newUserName);
				localStorage.setItem('token', login);
				this.setState({registered: true, error: 0});
			} 
			else {
				this.setState({error: 2});
			}
		}
	}	

	// event handler for the username box that sets the state to whatever is typed
	handleUsernameChange(e){
		this.setState({username: e.target.value});
	}


	// event handler for the password box that sets the state to whatever is typed
	handlePasswordChange(e){
		this.setState({password: e.target.value});
	}

	// event handler for the repeat password box that sets the state to whatever is typed
	handleRPasswordChange(e){
		this.setState({rPassword: e.target.value});
	}

	// renders the registration page and then returns it to the parent
	render() {
		var message;
		var error;

		// If the user has not registered yet, load the registration page
		if(!this.state.registered){
			message = (
				<div>
					<h2>Please Enter Your Your Information to Create a New Account</h2>
					<form>
						<div className="inputboxes">
						<b>Username:  </b>
							<input 
				        	id = "userName"
				        	size="10"
				        	type="text"
				        	value={this.state.username}
				        	onChange = {(e) => {this.handleUsernameChange(e)}}
				        	/>
			        	</div>
			        	
			        	<div className="inputboxes">
				        	<b>Password:  </b>
							<input 
				        	id = "pass"
				        	size="10"
				        	type="password"
				        	value={this.state.password}
				        	onChange = {(e) => {this.handlePasswordChange(e)}}
				        	/>
			        	</div>

			        	<div className="inputboxes">
				        	<b>Repeat Password:  </b>
							<input 
				        	id = "repeatPass"
				        	size="10"
				        	type="password"
				        	value={this.state.rPassword}
				        	onChange = {(e) => {this.handleRPasswordChange(e)}}
				        	/>
			        	</div>

			        	<button type="button" className="orderButton" onClick={this.addUser}>
				   			Sign Up
				   		</button>
					</form>
				</div>
			);
		}
		else {
			// If the user has registered set message to a success message
			message = (
				<div>
					<h2> Account Successfully Created </h2>
				</div>
			);
		}

		// If there is an error, set error to display the message 
		if(this.state.error === 1){
			error = (
				<div className="errorBox">
					<h3>Passwords do not match</h3>
				</div>
			);
		}
		else if(this.state.error === 2){
			error = (
				<div className="errorBox">
					<h3>Username already exists</h3>
				</div>
			);
		}

		// return the error if there is one, and the message
		return (
			<div className="App">
				<div className="home" id="registerPage">
					{error}
					{message}
				</div>
			</div>
		);
	}
	
}


export default Register;