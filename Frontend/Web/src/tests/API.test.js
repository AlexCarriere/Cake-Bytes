import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { shallow, configure } from 'enzyme';
import stubAPI from './stubAPI';
import api from '../data/API';

var order;

api.switchDB(stubAPI);

describe('Testing functions', () => {
	it('login should be working correctly', () => {
		expect("token").toBe(api.login({username: "carrie", password: "1234"}));
		expect("").toBe(api.login({username: "carriere", password: "1234"}));
		expect("").toBe(api.login({username: "carrie", password: "12345"}));
	});

	it('register should be working correctly', () => {
		expect("token").toBe(api.register({username: "newUser", password: "1234"}));
		expect("").toBe(api.register({username: "newUser", password: "1234"}));
	});

	it('newOrder should be working correctly', () => {
		expect(true).toBe(api.newOrder("carrie", {first_name: "new", last_name: "user", amount: 4, cupcake: {topping: "cherry", frosting: "vanilla"}, base:"chocolate"}, "token"));
		expect(false).toBe(api.newOrder("carrie", {first_name: "new", last_name: "user", amount: 4, cupcake: {topping: "cherry", frosting: "vanilla"}, base:"chocolate"}, "notToken"));
		expect(false).toBe(api.newOrder("NotAUser", {first_name: "new", last_name: "user", amount: 4, cupcake: {topping: "cherry", frosting: "vanilla"}, base:"chocolate"}, "token"));
	});

	it('getUsersOrders should be working correctly', () => {
		expect(2).toBe(api.getUsersOrders("test", "token").length);
		expect(0).toBe(api.getUsersOrders("test", "notToken").length);
		expect(0).toBe(api.getUsersOrders("NotAUser", "token").length);
	});

	it('getOrderByID should be working correctly', () => {
		order = api.getOrderByID("test", 1, "token");

		expect("test").toBe(order.first_name);
		expect("test").toBe(order.last_name);
		expect(1).toBe(order.amount);
		expect("rainbow_sprinkles").toBe(order.detail.deco);
		expect("chocolate").toBe(order.detail.icing);
		expect("vanilla").toBe(order.detail.base);

		order = api.getOrderByID("NotAUser", 1, "token");

		expect(undefined).toBe(order);


		order = api.getOrderByID("test", 1, "notToken");

		expect(undefined).toBe(order);
	});

	it('deleteOrder should be working correctly', () => {
		expect(false).toBe(stubAPI.deleteOrder("user", 1, "notToken"));
		expect(false).toBe(stubAPI.deleteOrder("NotAUser", 1, "token"));
		expect(false).toBe(stubAPI.deleteOrder("NotAUser", -2, "token"));

		expect(true).toBe(stubAPI.deleteOrder("test", 1, "token"));

		expect(1).toBe(stubAPI.getUsersOrders("test", "token").length);
	});

	it('updateOrder should be working correctly', () => {
		order = {
	        "order_id": 2,
	        "first_name": "newTest",
	        "last_name": "newTest",
	        "detail": {deco: "cherry", icing: "vanilla", base:"chocolate"},
	        "amount": 2,
	        "timestamp": "now",
	        "status": "processing",
		}

		api.updateOrder("test", order, "token");

		order = api.getOrderByID("test", 2, "token");

		expect("newTest").toBe(order.first_name);
		expect("newTest").toBe(order.last_name);
		expect(2).toBe(order.amount);
		expect("cherry").toBe(order.detail.deco);
		expect("vanilla").toBe(order.detail.icing);
		expect("chocolate").toBe(order.detail.base);
	});
});