const stubAPI = {
	users: [
		{username: "carrie", password: "1234"},
		{username: "admin", password: "admin"},
		{username: "test", password: "1234"}
	],
	orders: [
		{order_id: 7534, first_name: "Alex", last_name: "Carriere", amount: 2, user: "carrie", detail: {topping: "cherry", frosting: "vanilla", base:"chocolate"}},
		{order_id: 8453, first_name: "Faye", last_name: "Lim", amount: 3, user: "carrie", detail: {topping: "orange", frosting: "chocolate", base:"chocolate"}},
		{order_id: 8623, first_name: "KJ", last_name: "Choi", amount: 1, user: "carrie", detail: {topping: "rainbow_sprinkles", frosting: "vanilla", base:"chocolate"}},
		{order_id: 7562, first_name: "Jagan", last_name: "Brar", amount: 4, user: "admin", detail: {topping: "cherry", frosting: "vanilla", base:"vanilla"}}, 
		{order_id: 4532, first_name: "Francis", last_name: "Okoro", amount: 2, user: "admin", detail: {topping: "orange", frosting: "vanilla", base:"chocolate"}},
		{order_id: 8875, first_name: "Sophie", last_name: "Yang", amount: 3, user: "admin", detail: {topping: "rainbow_sprinkles", frosting: "chocolate", base:"vanilla"}},
		{order_id: 1, first_name: "test", last_name: "test", amount: 1, user: "test", detail: {topping: "rainbow_sprinkles", frosting: "chocolate", base:"vanilla"}},
		{order_id: 2, first_name: "test", last_name: "test", amount: 1, user: "test", detail: {topping: "rainbow_sprinkles", frosting: "chocolate", base:"vanilla"}}
	],

	login: function(user){
		var success = "";
		var user;

		for(var i = 0; i < this.users.length; i ++){
			var currUser = this.users[i];
			
			if(currUser.username == user.username){
				if(currUser.password == user.password){
					success = "token";
				}
			}
		}

		return success;
	},

	register: function(user){
		var success = "";
		var found;
		
		for(var i = 0; i < this.users.length; i ++){
			var currUser = this.users[i];

			if(currUser.username == user.username){
				found = true;
			}
		}

		if(!found){
			this.users.push(user);
			success = "token";
		}

		return success;
	},

	newOrder: function(username, order, token){
		var success = false;
		var userFound = false;

		if(token == "token"){
			for(var i = 0; i < this.users.length; i ++){
				var currUser = this.users[i];
				
				if(currUser.username == username){
					userFound = true;
				}
			}


			if(userFound){
				var orderNum = Math.floor(Math.random() * (+100000 - +0));

				var newOrder = {
					order_id: orderNum,
					first_name: order.first_name,
					last_name: order.last_name,
					amount: order.amount,
					user: username,
					detail: order.cupcake
				}
			
				console.log(order.cupcake)
				this.orders.push(newOrder);
				success = true;
			}
		}

		console.log(success);
		return success;
	},

	getUsersOrders: function(username, token){
		var userOrders = [];

		if(token == "token"){
			for(var i = 0; i < this.orders.length; i ++){
				var currOrder = this.orders[i];
				
				if(currOrder.user == username){
					userOrders.push(currOrder);
				}
			}
		}

		return userOrders;
	},

	getOrderByID: function(username, orderID, token){
		var orderFound = false;
		var order = undefined;
		var userFound = false;

		if(token == "token"){
			for(var i = 0; i < this.users.length; i ++){
				var currUser = this.users[i];
				
				if(currUser.username == username){
					userFound = true;
				}
			}

			if(userFound){
				for(var i = 0; i < this.orders.length; i ++){
					var currOrder = this.orders[i];
					if(currOrder.order_id == orderID){
						order = this.orders[i];
					}
				}
			}
		}

		return order;
	},

	deleteOrder: function(username, orderID, token){
		var deleted = false;
		var userFound = false;
		var pos = -1;

		if(token == "token"){
			for(var i = 0; i < this.users.length; i ++){
				var currUser = this.users[i];
				
				if(currUser.username == username){
					userFound = true;
				}
			}

			if(userFound){
				for(var i = 0; i < this.orders.length; i ++){
					var currOrder = this.orders[i];
					if(currOrder.order_id == orderID){
						pos = i;
					}
				}
			}
		
			if(pos != -1){
				if(this.orders.length > 1){
					this.orders.splice(pos, 1);
				}
				else{
					this.orders.empty();
				}
				deleted = true;
			}
		}

		return deleted;
	},

	updateOrder: function(username, order, token){
		var updated = false;
		var userFound = false;
		var pos = -1;

		var newOrder = {
	        "order_id": order.order_id,
	        "first_name": order.first_name,
	        "last_name": order.last_name,
	        "user": username,
	        "detail": order.detail,
	        "amount": order.amount,
	        "timestamp": order.timestamp,
	        "status": order.status,
    	}

		if(token == "token"){
			for(var i = 0; i < this.users.length; i ++){
				var currUser = this.users[i];
				
				if(currUser.username == username){
					userFound = true;
				}
			}

			if(userFound){
				for(var i = 0; i < this.orders.length; i ++){
					var currOrder = this.orders[i];
					if(currOrder.order_id == order.order_id){
						this.orders[i] = newOrder;
						updated = true;
					}
				}
			}
		}

		console.log(this.orders)
		return updated;
	}
}

export default stubAPI;