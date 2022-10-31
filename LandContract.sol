// @title A contract for defining a LandContract
// @author Jerry Zhang

pragma solidity >=0.5.0 <0.6.0;

import "./Ownable.sol";

contract LandContract {
    // @dev creates a land object
    struct Land {
        address ownerAddress;
        string location;
        uint cost;
        uint landID;
    }

    event Register(address _owner, unit _landID);

    event Transfer(address indexed _from, address indexed _to, uint _landID);

    mapping (address => Land[]) public _ownedLands;

    function registerLand(string _location, uint _cost) public isOwner {
        totalLandsCounter++;
        Land memory myLand = Land(ownerAddress: msg.sender, location: _location, cost: _cost, landID: totalLandsCounter);
        _ownedLands[msg.sender].push(myLand);
        emit Register(msg.sender, totalLandsCounter);
    }

    function transferLand(address _landBuyer, uint _landID) public returns (bool) {
        for(uint i=0; i < _ownedLands[msg.sender].length; i++){
            if (_ownedLands[msg.sender][i].landID == _landID){
                 Land memory myLand = Land(ownerAddress:_landBuyer, location: _ownedLands[msg.sender][i].location, cost: _ownedLands[msg.sender][i].cost, landID: _landID);
                _ownedLands[_landBuyer].push(myLand);  
                delete _ownedLands[msg.sender][i];
                emit Transfer(msg.sender, _landBuyer, _landID);
                return true;
            }
        }
        return false;
    }

    function getLand(address _landHolder, uint _index) public view returns (string, uint, address, uint) {
        return (_ownedLands[_landHolder][_index].location, 
                _ownedLands[_landHolder][_index].cost,
                _ownedLands[_landHolder][_index].ownerAddress,
                _ownedLands[_landHolder][_index].landID);
    }

    function getNoOfLands(address _landHolder) public view returns(uint) {
        return _ownedLands[_landHolder].length;
    }
}

// @notice explains to a user what the contract / function does
// @dev more details for developpers
// @param and @return are for describing what each parameter and return value of a function are for.