import DBAPI from '../tests/StubAPI';

const API = {
	api: DBAPI,
	
	switchDB: function(newAPI){
		this.api = newAPI;
	},

	login: function(user){
		return this.api.login(user);
	}, 

	register: function(user){
		return this.api.register(user);
	},

	newOrder: function(username, order, token){
		return this.api.newOrder(username, order, token);
	},

	getUsersOrders: function(username, token){
		return this.api.getUsersOrders(username, token);
	},

	getOrderByID: function(username, orderID, token){
		return this.api.getOrderByID(username, orderID, token);
	},

	deleteOrder: function(username, orderID, token){
		return this.api.deleteOrder(username, orderID, token);
	},

	updateOrder: function(username, order, token){
		return this.api.updateOrder(username, order, token);
	}

}

export default API;