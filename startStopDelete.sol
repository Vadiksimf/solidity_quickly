pragma solidity ^0.5.13;

contract StartStopUpdateContract {
    address owner;

    bool paused = false;

    constructor() public {
        owner = msg.sender;
    }

    function sendMoney() public payable {

    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner!");
        paused = _paused;
    }

    // Use conditons
    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "You are not the owner!");
        require(!paused, "Contract is paused");
        _to.transfer(address(this).balance);
    }

    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner!");
        selfdestruct(_to);
    }
}
