pragma solidity 0.5.11;

import './Resolver.sol';
import '@openzeppelin/contracts/cryptography/ECDSA.sol';

// solium-disable error-reason

contract SignatureResolver is Resolver {
    using ECDSA for bytes32;

    // Mapping from owner to a nonce
    mapping (address => uint256) internal _nonces;

    constructor(Registry registry) public Resolver(registry) {}

    /**
     * @dev Gets the nonce of the specified address.
     * @param addr address to query nonce for
     * @return nonce of the given address
     */
    function nonceOf(address addr) external view returns (uint256) {
        return _nonces[addr];
    }

    /**
     * @dev Function to set record on behalf of an address.
     * @param key The key set the value of.
     * @param value The value to set key to.
     * @param tokenId The token id to set.
     * @param signature The signature to verify the transaction with.
     */
    function setFor(bytes calldata key, bytes calldata value, uint256 tokenId, bytes calldata signature) external whenResolver(tokenId) {
        address owner = _registry.ownerOf(tokenId);
        _validate(keccak256(abi.encodeWithSelector(msg.sig, key, value, tokenId)), tokenId, signature);
         _registry.sync(tokenId, uint256(keccak256(key)));
        _set(owner, key, value, tokenId);
    }

    function _validate(bytes32 hash, uint256 tokenId, bytes memory signature) internal {
        address owner = _registry.ownerOf(tokenId);
        uint256 nonce = _nonces[owner];

        require(
            _registry.isApprovedOrOwner(
                keccak256(abi.encodePacked(hash, nonce)).toEthSignedMessageHash().recover(signature),
                tokenId
            )
        );

        _nonces[owner] += 1;
    }
}
