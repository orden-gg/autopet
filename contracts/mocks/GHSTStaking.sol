// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

interface GHSTStaking {
    function frens(address _account) external view returns (uint256);

    function staked(address _account) external view returns (uint256, uint256, uint256);
    function stakeGhst(uint256 _ghstValue) external;
    function withdrawGhstStake(uint256 _ghstValue) external;

    function claimTickets(uint256[] calldata _ids, uint256[] calldata _values) external;

    function safeBatchTransferFrom(
        address _from,
        address _to,
        uint256[] calldata _ids,
        uint256[] calldata _values,
        bytes calldata _data
    ) external;
}