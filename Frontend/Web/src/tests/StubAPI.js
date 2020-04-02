const stubAPI = {
	users: [
		{username: "carrie", password: "1234"},
		{username: "admin", password: "admin"},
		{username: "test", password: "1234"}
	],
	orders: [
		{order_id: 7534, first_name: "Alex", last_name: "Carriere", amount: 2, user: "carrie", detail: {deco: "cherry", icing: "vanilla", base:"chocolate"}},
		{order_id: 8453, first_name: "Faye", last_name: "Lim", amount: 3, user: "carrie", detail: {deco: "orange", icing: "chocolate", base:"chocolate"}},
		{order_id: 8623, first_name: "KJ", last_name: "Choi", amount: 1, user: "carrie", detail: {deco: "rainbow_sprinkles", icing: "vanilla", base:"chocolate"}},
		{order_id: 7562, first_name: "Jagan", last_name: "Brar", amount: 4, user: "admin", detail: {deco: "cherry", icing: "vanilla", base:"vanilla"}}, 
		{order_id: 4532, first_name: "Francis", last_name: "Okoro", amount: 2, user: "admin", detail: {deco: "orange", icing: "vanilla", base:"chocolate"}},
		{order_id: 8875, first_name: "Sophie", last_name: "Yang", amount: 3, user: "admin", detail: {deco: "rainbow_sprinkles", icing: "chocolate", base:"vanilla"}},
		{order_id: 1, first_name: "test", last_name: "test", amount: 1, user: "test", detail: {deco: "rainbow_sprinkles", icing: "chocolate", base:"vanilla"}},
		{order_id: 2, first_name: "test", last_name: "test", amount: 1, user: "test", detail: {deco: "rainbow_sprinkles", icing: "chocolate", base:"vanilla"}}
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

		if(token === "token"){
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
			
				this.orders.push(newOrder);
				success = true;
			}
		}

		return success;
	},

	getUsersOrders: function(username, token){
		var userOrders = [];

		if(token === "token"){
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

		return updated;
	}
}

export default stubAPI;