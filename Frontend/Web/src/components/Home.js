import React from 'react'

// The Home component loads a homepage
class Home extends React.Component {
	
	// Render and return the home message
	render() {
		return(
			<div className="App">
				<div className="home">
						<div className="app">
							<div className="introContainer">
								<div className="intro">
									CakeBytes is an online cupcake customization tool. Our goal is to make sure you get the cupcakes that you want.
									With an easy-to-use interactive cupcake creator, you can see your cupcakes before you order them. 
									<div className="signature">CakeBytes</div>
								</div>
							</div>
						</div>
					<br/>
				</div>
			</div>
		);
	}
}

export default Home