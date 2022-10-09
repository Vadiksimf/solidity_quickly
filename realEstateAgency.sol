// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

/*
Requirements:

В системе должна храниться информация о различных объектах недвижимости, а именно:
- владелец (аккаунт в сети Ethereum)
- физический адрес
- площадь объекта
- наличие обременений

В системе должен присутствовать администратор, один из аккаунтов сети - автор смарт-контракта.
При старте системы в ней должен присутствовать объект недвижимости:
- Таганрог, ул. Чехова, дом 2, общей площадью 1000 кв.м, без обременений, владелец - произвольный из списка аккаунтов.

Функционал системы:
- добавление объекта недвижимости (только админом)
- изменение владельца (только админом)
- изменение площади (только админом)
- наложение обременений (только админом)
- создание сущности "подарка" - владелец создает с указанием кому подарить, при подтверждении получения сменяется собственник
- создание сущности "продажа" с заявленной стоимостью - владелец выставляет на продажу, покупатель откликается, 
- при успешном переводе средств сменяется собственник, объявление становится неактуальнымдарить и продавать собственность с обременением нельзя
*/

contract SoldRealEstate {
    uint256 id;
    address recepient;

    constructor (address _recepient, uint256 _id) {
        recepient = _recepient;
        id = _id;
    }
}

contract PresentRealEstate {
    uint256 id;
    address recepient;

    constructor (address _recepient, uint256 _id) {
        recepient = _recepient;
        id = _id;
    }
}

contract Agency {
    address admin;

    struct realEstateModel {
        address owner;
        string location;
        uint256 square;
        string encumbrance;
    }

    mapping(uint256 => realEstateModel) realEstate;
    uint256[] realEstateIds;

    PresentRealEstate public present;
    SoldRealEstate public sold;

    constructor() {
        admin = msg.sender;
        realEstateModel storage newNewRealEstate = realEstate[1];
        newNewRealEstate.owner = msg.sender;
        newNewRealEstate.location = "Taganrog city, Chehova street 2";
        newNewRealEstate.square = 1000;
        newNewRealEstate.encumbrance = "";
    }

    function registerRealEstate(address owner, string memory location, 
        uint256 square, string memory encumbrance, uint256 id) public {

        require(msg.sender != admin, "Denied! You are not an admin!");
        realEstateModel storage newNewRealEstate = realEstate[id];
        newNewRealEstate.owner = owner;
        newNewRealEstate.location = location;
        newNewRealEstate.square = square;
        newNewRealEstate.encumbrance = encumbrance;
    }
    
    function getRealEstate(uint256 id) 
        public view returns (address, string memory, 
        uint256, string memory) {
        require(bytes(realEstate[id].location).length != 0, "Real Estate doesn't exist");

        return (realEstate[id].owner, realEstate[id].location, 
        realEstate[id].square, realEstate[id].encumbrance);
    }

    function isAdmin() private returns (bool) {
        return msg.sender == admin;
    }

    function changeOwner (uint256 id, address owner) public {
        require(isAdmin(), "Denied! You are not an admin!");
        realEstateModel storage obj = realEstate[id];
        require(bytes(obj.location).length != 0, "Real Estate doesn't exist");
        if (owner != address(0)) obj.owner = owner;
    }

    function changeSquare (uint256 id, uint256 square) public {
        require(isAdmin(), "Denied! You are not an admin!");
        realEstateModel storage obj = realEstate[id];
        require(bytes(obj.location).length != 0, "Real Estate doesn't exist");
        if (square != 0) obj.square = square;
    }

    function changeEncumbrance (uint256 id, string memory encumbrance) public {
        require(isAdmin(), "Denied! You are not an admin!");
        realEstateModel storage obj = realEstate[id];
        require(bytes(obj.location).length != 0, "Real Estate doesn't exist");
        if (bytes(encumbrance).length != 0) obj.encumbrance = encumbrance;
    }

    function changeEntireRealEstateInstance(address owner, string memory location, 
        uint256 square, string memory encumbrance, uint256 id) public
        returns (address, string memory, uint256, string memory) {

        require(msg.sender != admin, "Denied! You are not an admin!");
        realEstateModel storage obj = realEstate[id];
        require(bytes(obj.location).length != 0, "Real Estate doesn't exist");

        if (owner != address(0)) obj.owner = owner;
        if (bytes(location).length != 0) obj.location = location;
        if (square != 0) obj.square = square;
        if (bytes(encumbrance).length != 0) obj.encumbrance = encumbrance;

        return (obj.owner, obj.location, obj.square, obj.encumbrance);
    }

    function soldRealEstate (uint256 id, address recepient) public {
        realEstateModel storage obj = realEstate[id];
        require(bytes(obj.location).length != 0, "Real Estate doesn't exist");
        require(msg.sender == obj.owner, "You are not allowed to perform this action!");
        require(bytes(obj.encumbrance).length != 0, "This property is restricted");
        
        sold = new SoldRealEstate(recepient, id);
    }

    function presentRealEstate (uint256 id) public {

    }
}
