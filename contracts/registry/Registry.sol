pragma solidity 0.5.11;

import "./IRegistry.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Metadata.sol";
import "./Resolution.sol";
import "./Metadata.sol";
import "./Children.sol";

// solium-disable no-empty-blocks

contract Registry is IRegistry, Resolution, Children {}