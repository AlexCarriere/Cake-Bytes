import React from 'react';
import Adapter from 'enzyme-adapter-react-16';
import { shallow, configure } from 'enzyme';
import Translator from '../components/Translator';

import choc_base from '../assets/chocolate_base.png';
import van_base from '../assets/vanilla_base.png';
import red_base from '../assets/redvelvet_base.png';

import van_frosting from '../assets/vanilla_frosting.png';
import choc_frosting from '../assets/chocolate_frosting.png';
import mint_frosting from '../assets/mint_frosting.png';
import lime_frosting from '../assets/lime_frosting.png';

import cherry from '../assets/cherry.png';
import rain_sprinkle from '../assets/rainbow_sprinkle.png';
import orange from '../assets/orange.png';
import blackberry from '../assets/blackberry.png';
import eatMe from '../assets/eat_me_words.png';
import heart_sprinkle from '../assets/hearts_sprinkle.png';
import pocky from '../assets/pocky.png';
import strawberry from '../assets/strawberry.png';
import star_sprinkle from '../assets/stars_sprinkle.png';

describe('Testing Functions', () => {
	
	it('should translate topping pictures into strings', () => {
		expect("cherry").toBe(Translator.getToppingString(cherry));
		expect("orange").toBe(Translator.getToppingString(orange));
		expect("rainbow_sprinkle").toBe(Translator.getToppingString(rain_sprinkle));
		expect("blackberry").toBe(Translator.getToppingString(blackberry));
		expect("eatMe").toBe(Translator.getToppingString(eatMe));
		expect("heart_sprinkle").toBe(Translator.getToppingString(heart_sprinkle));
		expect("pocky").toBe(Translator.getToppingString(pocky));
		expect("strawberry").toBe(Translator.getToppingString(strawberry));
		expect("star_sprinkle").toBe(Translator.getToppingString(star_sprinkle));

		expect("none").toBe(Translator.getToppingString("none"));
		expect("none").toBe(Translator.getToppingString(""));
		expect("none").toBe(Translator.getToppingString("anything"));
	});

	it('should translate frosting images to strings', () => {
		expect("chocolate").toBe(Translator.getFrostingString(choc_frosting));
		expect("vanilla").toBe(Translator.getFrostingString(van_frosting));
		expect("lime").toBe(Translator.getFrostingString(lime_frosting));
		expect("mint").toBe(Translator.getFrostingString(mint_frosting));

		expect(undefined).toBe(Translator.getFrostingString("something"));
	});

	it('should translate base images to strings', () => {
		expect("chocolate").toBe(Translator.getBaseString(choc_base));
		expect("vanilla").toBe(Translator.getBaseString(van_base));
		expect("redvelvet").toBe(Translator.getBaseString(red_base));

		expect(undefined).toBe(Translator.getBaseString("something"));
	});

	it('should translate topping strings into pictures', () => {
		expect(cherry).toBe(Translator.getToppingImg("cherry"));
		expect(orange).toBe(Translator.getToppingImg("orange"));
		expect(rain_sprinkle).toBe(Translator.getToppingImg("rainbow_sprinkle"));
		expect(blackberry).toBe(Translator.getToppingImg("blackberry"));
		expect(eatMe).toBe(Translator.getToppingImg("eatMe"));
		expect(heart_sprinkle).toBe(Translator.getToppingImg("heart_sprinkle"));
		expect(pocky).toBe(Translator.getToppingImg("pocky"));
		expect(strawberry).toBe(Translator.getToppingImg("strawberry"));
		expect(star_sprinkle).toBe(Translator.getToppingImg("star_sprinkle"));

		expect("none").toBe(Translator.getToppingImg("none"));
		expect("none").toBe(Translator.getToppingImg(""));
		expect("none").toBe(Translator.getToppingImg("anything"));
	});

	it('should translate frosting strings to images', () => {
		expect(choc_frosting).toBe(Translator.getFrostingImg("chocolate"));
		expect(van_frosting).toBe(Translator.getFrostingImg("vanilla"));
		expect(lime_frosting).toBe(Translator.getFrostingImg("lime"));
		expect(mint_frosting).toBe(Translator.getFrostingImg("mint"));

		expect(undefined).toBe(Translator.getFrostingImg("something"));
	});

	it('should translate base strings to images', () => {
		expect(choc_base).toBe(Translator.getBaseImg("chocolate"));
		expect(van_base).toBe(Translator.getBaseImg("vanilla"));
		expect(red_base).toBe(Translator.getBaseImg("redvelvet"));

		expect(undefined).toBe(Translator.getBaseImg("something"));
	});

});