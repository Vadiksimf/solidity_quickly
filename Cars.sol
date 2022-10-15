pragma solidity >0.7.0;

contract Cars{

    struct Car {
        string model;
        uint price;
        string color;
        address owner;
    }

    mapping(uint => Car) public cars;

    address admin;

    uint recolor_price = 150 gwei;

    constructor() public {
        cars[111] = Car("audi", 150000, "black", msg.sender);
        cars[222] = Car("bmw", 200000, "white", 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);
        admin = msg.sender;
    }

    function reg_car(uint _id, string memory _model, uint _price, string memory _color, address _owner) public onlyAdmin {
        require(_id != 0);
        require(_price != 0);
        require(_owner != address(0));
        cars[_id] = Car(_model, _price, _color, _owner);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "You are not admin");
        _;
    }

    function present_car(uint _id, address _new_owner) public {
        require(_id != 0);
        require(_new_owner != address(0));
        require(cars[_id].owner == msg.sender, "Not your car");
        cars[_id].owner = _new_owner;
    }

    function buy_car(uint _id) public payable {
        require(_id != 0);
        require(cars[_id].owner != msg.sender, "It's your car");
        require(cars[_id].price == msg.value);
        address last_owner = cars[_id].owner;
        cars[_id].owner = msg.sender;
        payable(last_owner).transfer(cars[_id].price);
    }

    function get_car(uint _id) public view returns(string memory, uint, string memory, address) {
        return(cars[_id].model, cars[_id].price, cars[_id].color, cars[_id].owner);
    }

    function recolor(uint _id) 
}
