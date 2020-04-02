import React from 'react';
import { Link } from 'react-router-dom';
import icon from '../assets/favicon.ico';

// Header component loads the top nav bar
class Header extends React.Component {
	
	render() {
		return (
			<header>
				<nav>
					<ul className="toolbarlist">
						<li className="items"><Link to='/' className="whiteLinks">HOME</Link></li>
						<li className="items"><Link to='/cupcakes' className="whiteLinks">CUPCAKE MAKER</Link></li>
						<li className="items"><Link to='/orderhistory' className="whiteLinks">HISTORY</Link></li>
						<li className="items"><Link to='/login' className="whiteLinks">ACCOUNT</Link></li>
					</ul>
				</nav>	
			</header>
		);
	}
}

export default Header