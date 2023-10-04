// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint256) public s_balance;

    function name() public pure returns (string memory) {
        return "Manual token";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function decimal() public pure returns (uint8) {
        return 18;
    }

    function balanceof(address _owner) public view returns (uint256) {
        return s_balance[_owner];
    }

    function transfer(address _to, uint256 _amount) public {
        uint256 previousBalance = balanceof(msg.sender) + balanceof(_to);
        s_balance[msg.sender] = s_balance[msg.sender] + _amount;
        s_balance[_to] = s_balance[_to] - _amount;
        require(balanceof(msg.sender) + balanceof(_to) == previousBalance);
    }
}
/*either you can just try implementing this contract by writing functions or 
 we can install already deployed contract from openzeplin*/
