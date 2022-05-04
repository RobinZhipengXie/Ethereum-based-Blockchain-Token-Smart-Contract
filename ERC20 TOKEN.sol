// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ERC20 {
    mapping (address => uint256) public _balances;
    mapping (address => mapping (address => uint256)) public _allowed;

    string public _name = "Robin_Coin";
    string public _symbol= "RBC";
    uint8 public _decimals = 0;
    uint256 private _totalSupply = 100000000;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor () public payable {
        mint(msg.sender, 10000000); 
    }

    function name() public view returns (string memory) {
        return _name; 
    }
    function setName(string memory newName) public {
        _name = newName;
    }
    function symbol() public view returns (string memory) {
        return _symbol; 
    }
    function setSymbol(string memory newSymbol) public {
        _symbol = newSymbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    function mint(address account, uint256 _value) internal {
        require(account != address(0));
        _totalSupply += _value;
        _balances[account] += _value;
        emit Transfer(address(0), account, _value);
    }
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_balances[msg.sender] >= _value, "Insufficent Token"); 
        require(_to != msg.sender, "You cannot send money to yourself"); 
        _balances[msg.sender] -= _value; 
        _balances[_to] += _value; 
        emit Transfer(msg.sender, _to, _value); 
        return true; 
    } 
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balances[_owner];
    }
    function approve(address _spender, uint256 _value) public returns (bool success) {
        _allowed[msg.sender][_spender] = _value; 
        emit Approval(msg.sender, _spender, _value);
        return true; 
    }
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return _allowed[_owner][_spender]; 
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 _allowance = _allowed[_from][msg.sender]; 
        require(_balances[_from] >= _value && _allowance >= _value); 
        _balances[_from] -= _value; 
        _balances[_to] += _value;
        _allowed[_from][msg.sender] -= _value; 
        emit Transfer(_from, _to, _value); 
        return true; 
    }
}

