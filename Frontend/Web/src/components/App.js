import React from 'react';
import '../styles/App.css';
import Header from './Header'
import Main from './Main'
import banner from '../assets/banner.png';

// The Aoo component is the outer layer than runs everything, 
class App extends React.Component {

	
	render() {

		// return the  
		return(
		  	<div className="window">
			    <Header/>
			    <div>
			    	<img className="banner" src={banner}/>
			    </div>
			    <Main/>
		  	</div>
		)
	}

}

export default App;