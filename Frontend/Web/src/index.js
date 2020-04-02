import React from 'react';
import ReactDOM from 'react-dom';
import './styles/index.css';
import App from './components/App';
import * as serviceWorker from './components/serviceWorker';
import { BrowserRouter } from 'react-router-dom';


ReactDOM.render((
	<BrowserRouter className="window">
		<div className="backdrop">
		<App />
		</div>
	</BrowserRouter>
	), document.getElementById('root'));

serviceWorker.unregister();
