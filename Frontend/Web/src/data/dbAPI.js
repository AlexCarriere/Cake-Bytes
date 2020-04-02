const DBAPI = {
	login: function(user){
		var body = {"username": user.username, "password": user.password}

		return (async () => {
      const rawResponse = await fetch('http://54.201.255.168:8080/login', {
    		method: 'POST',
    		headers: {
      		'Accept': 'application/json',
      		'Content-Type': 'application/json'
   			},
   	 		body: JSON.stringify(body)
  		});
  			
      const content = await rawResponse;
  		var token = "";

      var loginSuccess = content.status == 200 ? true : false;
        
      if(loginSuccess){
        token = await rawResponse.text();
      }

  		return token;
		})();
	},

	register: function(user){
		var body = {"username": user.username, "password": user.password}

		return (async () => {
 	    const rawResponse = await fetch('http://54.201.255.168:8080/register', {
    		method: 'POST',
    		headers: {
      		'Accept': 'application/json',
      		'Content-Type': 'application/json'
   			},
   	 		body: JSON.stringify(body)
  		});

  		const content = await rawResponse;
  		var token = "";

      var registerSuccess = content.status == 200 ? true : false;

      if(registerSuccess){
        token = await rawResponse.text();
      }

  		return token;
		})();
	},

  newOrder: function(username, order, token){
    var body = {
      "first_name": order.first_name,
      "last_name": order.last_name,
      "detail": {
        "base": order.cupcake.base,
        "icing": order.cupcake.frosting,
        "deco": order.cupcake.topping,
        "other_request": ""
      },
      "amount": order.amount
    }

    var url = 'http://54.201.255.168:8080/order/' + username + '/';

    return (async () => {
      const rawResponse = await fetch(url, {
        method: 'POST',
        headers: {
          'Access-Control-Allow-Credentials' : true,
          'Access-Control-Allow-Origin':'*',
          'Access-Control-Allow-Methods':'POST',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'token': token 
        },
        body: JSON.stringify(body)
      });
        
      const content = await rawResponse;
      if(requestSuccess){
        orders = rawResponse.json();
      }

      return requestSuccess;
    })();
  },

  getUsersOrders: function(username, token){
      var url = 'http://54.201.255.168:8080/order/' + username + '/';

      return (async () => {
        const rawResponse = await fetch(url, {
        method: 'GET',
        headers: {
          'Access-Control-Allow-Credentials' : true,
          'Access-Control-Allow-Origin':'*',
          'Access-Control-Allow-Methods':'GET',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'token': token 
        },
      });
      
      const content = await rawResponse;
      var orders;
        
      var requestSuccess = content.status == 200 ? true : false;
      if(requestSuccess){
        orders = rawResponse.json();
      }

      return orders;
    })();
  },

  getOrderByID: function(username, orderID, token){
    var url = 'http://54.201.255.168:8080/order/' + username + '/' + orderID + '/';

    return (async () => {
      const rawResponse = await fetch(url, {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'token': token 
        },
      });
        
      const content = await rawResponse;
      var order;

      var requestSuccess = content.status == 200 ? true : false;

      if(requestSuccess){
        order = await rawResponse.json();
      }
        
      return order;
    })();
  },

  deleteOrder: function(username, orderID, token){
    var url = 'http://54.201.255.168:8080/order/' + username + "/" + orderID + '/';

    return (async () => {
      const rawResponse = await fetch(url, {
        method: 'DELETE',
        headers: {
          'Access-Control-Allow-Credentials' : true,
          'Access-Control-Allow-Origin':'*',
          'Access-Control-Allow-Methods':'DELETE',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'token': token 
        },
      });
        
      const content = await rawResponse;
      var deleteSuccess = content.status == 200 ? true : false;

      return deleteSuccess;
    })();
  },

  updateOrder: function(username, order, token){
    var url = 'http://54.201.255.168:8080/order/' + username + '/' + order.order_id + '/';

    var body = {
      "order_id": order.order_id,
      "first_name": order.first_name,
      "last_name": order.last_name,
      "detail": order.detail,
      "amount": order.amount,
      "timestamp": order.timestamp,
      "status": order.status,
    }

    return (async () => {
      const rawResponse = await fetch(url, {
        method: 'POST',
        headers: {
          'Access-Control-Allow-Credentials' : true,
          'Access-Control-Allow-Origin':'*',
          'Access-Control-Allow-Methods':'POST',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'token': token 
        },
        body: JSON.stringify(body),
      });
        
      const content = await rawResponse;
      var order;
      var requestSuccess = content.status == 200 ? true : false;

      if(requestSuccess){
        order = await rawResponse.json();
      }
        
      return order;
    })();
  }
  
}	

export default DBAPI;