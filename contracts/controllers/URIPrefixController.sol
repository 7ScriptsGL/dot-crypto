pragma solidity 0.5.11;

import "@openzeppelin/contracts/access/roles/WhitelistedRole.sol";
import "./IURIPrefixController.sol";
import "../Registry.sol";

/**
 * @title URIPrefixController
 * @dev Defines the functions for distribution of Second Level Domains (SLD)s.
 */
contract URIPrefixController is IURIPrefixController, WhitelistedRole {

    Registry internal _registry;

    constructor (Registry registry) public {
        _registry = registry;
    }

    function setTokenURIPrefix(string calldata prefix) external onlyWhitelisted {
        _registry.controlledSetTokenURIPrefix(prefix);
    }

}
