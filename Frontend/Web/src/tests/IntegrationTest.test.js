import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { shallow, configure } from 'enzyme';
import stubAPI from './stubAPI';
import api from '../data/API';

var order;
var token;
var orderID; 

//If the db is down comment this out
api.switchDB(stubAPI);

// To test the DB more clearly I would love a delete method for users and orders but did not have time to implement
describe('Testing functions', () => {
	it('register should be working correctly', () => {
		expect("").toBe(api.register({username: "test", password: "1234"}));
	});

	it('login should be working correctly', () => {
		token = api.login({username: "test", password: "1234"});
		expect("").not.toBe(token);
		expect("").toBe(api.login({username: "carriere", password: "1234"}));
		expect("").toBe(api.login({username: "carrie", password: "12345"}));
	});

	it('newOrder should be working correctly', () => {
		expect(true).toBe(api.newOrder("carrie", {first_name: "new", last_name: "user", amount: 4, detail: {deco: "cherry", icing: "vanilla"}, base:"chocolate"}, token));
		expect(false).toBe(api.newOrder("carrie", {first_name: "new", last_name: "user", amount: 4, detail: {deco: "cherry", icing: "vanilla"}, base:"chocolate"}, "notToken"));
		expect(false).toBe(api.newOrder("NotAUser", {first_name: "new", last_name: "user", amount: 4, detail: {deco: "cherry", icing: "vanilla"}, base:"chocolate"}, token));
	});

	it('getUsersOrders should be working correctly', () => {
		expect(2).toBe(api.getUsersOrders("test", token).length);
		expect(0).toBe(api.getUsersOrders("test", "notToken").length);
		expect(0).toBe(api.getUsersOrders("NotAUser", token).length);
	});

	// Because of current system design, we do not get back the orderID from the method, and without changing the system (what I would do If I had more time) I could
});