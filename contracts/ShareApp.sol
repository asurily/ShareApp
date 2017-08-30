pragma solidity ^0.4.0;

contract ShareApp{

	struct Renter{
		address addr;
		uint since;
	}

	struct Object{
		address creator; // +
		string name;
		uint priceDaily;
		uint deposit;
		Renter renter;
		bool rented;  //rented ?
		string detail;
	}

	struct NameKey{ // storage the name's keys
		uint[] keys;
	}

	//List of objects
	uint[] private ids;  //Use it to return the ids of Objects
	uint public numObjects;
	mapping(uint => Object) private objects;
	mapping(string => NameKey) private nameToKeys;
	// mapping(address => uint) public balances;

	address public owner;

	//Events
	event NewObject(uint objID, address creator);
	// event NewObject(uint indexed objID, address creator);

	modifier objectInRange(uint objID) {
        if (objID >= numObjects)
            throw;
        _;
    }

    modifier onlyOwner(){
    	if(msg.sender != owner){
    		throw;
    	}
    	_;
    }

	/*
	* Functions
	*/
	function ShareApp(){
		owner = msg.sender;
	}

	function objectIsRented(uint objID) objectInRange(objID) returns (bool){
		return objects[objID].rented;
	}

	function createObj(string name,uint priceDaily,uint deposit,string detail){
		// +
		//owner = msg.sender;
		// Object newObject = objects[numObjects];
		Object  newObject = objects[numObjects];
		nameToKeys[name].keys.push(numObjects); //add the key to the name's keys

		newObject.creator = msg.sender;
		newObject.name = name;
		newObject.priceDaily = priceDaily;
		newObject.deposit = deposit;
		newObject.rented = false;
		newObject.detail = detail;

		// objects[numObjects] = newObject;
		NewObject(numObjects,msg.sender);
		ids.push(numObjects);
		numObjects++;
	}

	// function getObj(uint objID) constant objectInRange(objID)
	// 	returns(
	// 		address creator,
	// 		string name,
	// 		uint priceDaily,
	// 		uint deposit,
	// 		address renterAddress,
	// 		uint renterSince,
	// 		bool rented,
	// 		string detail
	// 	)
	// {
	// 	creator = objects[objID].creator;
	// 	name = objects[objID].name;
	// 	priceDaily = objects[objID].priceDaily;
	// 	deposit = objects[objID].deposit;
	// 	renterAddress = objects[objID].renter.addr;
	// 	renterSince = objects[objID].renter.since;
	// 	rented = objects[objID].rented;
	// 	detail = objects[objID].detail;
	// }

	// function getObject(uint objID) constant objectInRange(objID)
	// 	returns(Object object)
	// {
	// 	object = objects[objID];
	// }

	function rentObj(uint objID) payable objectInRange(objID) returns(bool){
		if(objectIsRented(objID) || msg.value < objects[objID].deposit || msg.sender == objects[objID].creator){
			throw;
		}
		objects[objID].renter = Renter({addr:msg.sender, since:now});  //record the info of the renter
		uint rest = msg.value - objects[objID].deposit;
		if(!objects[objID].renter.addr.send(rest)){   // return the rest balance
			throw;
		}
		objects[objID].rented = true;
		return true;
	}

	function returnObj(uint objID) payable objectInRange(objID) returns (bool){
		if(!objects[objID].rented){
			throw;
		}
		if(objects[objID].renter.addr != msg.sender){
			throw;
		}
		uint duration = (now - objects[objID].renter.since) / (24*60*60*1.0);
		uint charge = duration * objects[objID].priceDaily;
		// uint days = (duration / (24*60*60*1.0));
		// uint charge = days * objects[objID].priceDaily;
		if(!objects[objID].creator.send(charge)){
			throw;
		}
		if(!objects[objID].renter.addr.send(objects[objID].deposit - charge)){
			throw;
		}
		delete objects[objID].renter;
		objects[objID].rented = false;
	}

	// function withdraw() {
	// 	var amount = balances[msg.sender];
	// 	balances[msg.sender] = 0;
	// 	msg.sender.transfer(amount);
	// }

	function findNames(string name) constant returns(uint[]){
		return nameToKeys[name].keys;
	}

	function getNumObjects() constant returns(uint){
		return numObjects;
	}

	function getObjectIds() constant returns(uint[]){
		return ids;
	}

	function getObjectName(uint objID) objectInRange(objID) returns(string objName){
		var obj = objects[objID];
		objName = obj.name;
	}

	function getObjectCreator(uint objID) constant objectInRange(objID) returns(address){
		return objects[objID].creator;
	}

	function getObjectPriceDaily(uint objID) constant objectInRange(objID) returns(uint){
		return objects[objID].priceDaily;
	}

	function getObjectDeposit(uint objID) constant objectInRange(objID) returns(uint){
		return objects[objID].deposit;
	}

	function getObjectRenterAddress(uint objID) constant objectInRange(objID) returns(address){
		return objects[objID].renter.addr;
	}

	function getObjectRenterSince(uint objID) constant objectInRange(objID) returns(uint){
		return objects[objID].renter.since;
	}

	function getObjectDetail(uint objID) constant objectInRange(objID) returns(string){
		return objects[objID].detail;
	}

	function remove() onlyOwner {
			selfdestruct(owner);
			// suicide(owner);
	}
}