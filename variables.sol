pragma solidity ^0.5.13;

contract SolidityVariables {
    // Set uint256 value
    uint256 public myUint;

    function setUint(uint _myUint) public {
        myUint = _myUint;
    }

    // Set Boolean value
    bool public myBool;

    function setBool(bool _myBool) public {
        myBool = _myBool;
    }

    // Set uint8 value. !!! 0-- = 255
    uint8 public myUint8;

    function incrementUint () public {
        myUint8++;
    }

    function decrementUint () public {
        myUint8--;
    }

    // Set int8. !!! -128 - +127
    int8 public myInt8;

    function setInt(int8 _myInt8) public {
        myInt8 = _myInt8;
    }

    function incrementInt8() public {
        myInt8++;
    }

    function decrementInt8() public {
        myInt8--;
    }

    // An address of ETH account
    address public myAddress;
    
    function setAddress(address _myAddress) public {
        myAddress = _myAddress;
    }

    // Get balance in WEI
    function getBalanceOfAddress() public view returns(uint) {
        return myAddress.balance;
    }

    // Strings stores as a bytes array 
    string public myString;

    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}
