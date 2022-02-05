// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

contract moneyTransactions {

    uint public balanceReceived;  // sending value

    function receiveMoney() public payable {
        balanceReceived += msg.value;
    }

    function getBalance() public view returns(uint) {
        // This the instance of the smart contract
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable to = payable(msg.sender);
        to.transfer(this.getBalance());
    }

    function withdrawMoneyTo(address payable _to) public {
        _to.transfer(this.getBalance());
    }
}
