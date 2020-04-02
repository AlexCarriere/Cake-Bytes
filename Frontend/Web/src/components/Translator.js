import React from 'react';

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


const Translator = {
	
	// getXXXString methods take the image of an item and return the string value that can be sent to the db.
	getToppingString: function(topping){
		var topString;

		if(topping.search("cherry") != -1) {
			topString = "cherry";
		}
		else if(topping.search("orange") != -1){
			topString = "orange";
		}
		else if(topping.search("rainbow_sprinkle") != -1){
			topString = "rainbow_sprinkle";
		}
		else if(topping.search("blackberry") != -1){
			topString = "blackberry";
		}
		else if(topping.search("eatMe") != -1){
			topString = "eatMe";
		}
		else if(topping.search("hearts_sprinkle") != -1){
			topString = "heart_sprinkle";
		}
		else if(topping.search("eat_me_words") != -1){
			topString = "eatMe";
		}
		else if(topping.search("pocky") != -1){
			topString = "pocky";
		}
		else if(topping.search("strawberry") != -1){
			topString = "strawberry";
		}
		else if(topping.search("stars_sprinkle") != -1){
			topString = "star_sprinkle";
		}
		else{
			topString = "none";
		}

		return topString;
	},
	getFrostingString: function(frosting) {
		var frostString;

		if(frosting.search("chocolate") != -1){
			frostString = "chocolate";
		}
		else if(frosting.search("vanilla") != -1){
			frostString = "vanilla";
		}
		else if(frosting.search("mint") != -1){
			frostString = "mint";
		}
		else if(frosting.search("lime") != -1){
			frostString = "lime";
		}
	
		return frostString;
	},
	getBaseString: function(base) {
		var baseString;

		if(base.search("chocolate") != -1){
			baseString = "chocolate";
		}
		else if(base.search("vanilla") != -1){
			baseString = "vanilla";
		}
		else if(base.search("redvelvet") != -1){
			baseString = "redvelvet";
		}

		return baseString;
	},
	// getXXXImg methods take the db strings provided and return the caller the image object. 
	getToppingImg: function(topping){
		var topImg;

		if(topping.search("cherry") != -1){
			topImg = cherry;
		}
		else if(topping.search("orange") != -1){
			topImg = orange;
		}
		else if(topping.search("rainbow_sprinkle") != -1){
			topImg = rain_sprinkle;
		}
		else if(topping.search("blackberry") != -1){
			topImg = blackberry;
		}
		else if(topping.search("eatMe") != -1){
			topImg = eatMe;
		}
		else if(topping.search("heart_sprinkle") != -1){
			topImg = heart_sprinkle;
		}
		else if(topping.search("pocky") != -1){
			topImg = pocky;
		}
		else if(topping.search("strawberry") != -1){
			topImg = strawberry;
		}
		else if(topping.search("star_sprinkle") != -1){
			topImg = star_sprinkle;
		}
		else{
			topImg = "none";
		}
		
		return topImg;
	},
	getFrostingImg: function(frosting){
		var frostImg;

		if(frosting.search("chocolate") != -1){
			frostImg = choc_frosting;
		}
		else if(frosting.search("vanilla") != -1){
			frostImg = van_frosting;
		}
		else if(frosting.search("mint") != -1){
			frostImg = mint_frosting;
		}
		else if(frosting.search("lime") != -1){
			frostImg = lime_frosting;
		}
	
		return frostImg;
	},
	getBaseImg: function(base){
		var baseImg;

		if(base.search("chocolate") != -1){
			baseImg =  choc_base;
		}
		else if(base.search("vanilla") != -1){
			baseImg = van_base;
		}
		else if(base.search("redvelvet") != -1){
			baseImg = red_base;
		}

		return baseImg;
	}

}

export default Translator;