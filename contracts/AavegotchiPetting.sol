// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

import './mocks/Aavegotchi.sol';
import './mocks/GHSTStaking.sol';

contract AavegotchiPetting is Ownable {
    using SafeERC20 for IERC20;
    using EnumerableSet for EnumerableSet.AddressSet;

    uint256 MAX_INT = 2 ** 256 - 1;

    IERC20 public ghstToken = IERC20(0x385Eeac5cB85A38A9a07A70c73e0a3271CfB54A7);
    Aavegotchi public aavegotchi = Aavegotchi(0x86935F11C86623deC8a25696E1C19a8659CbF95d);
    GHSTStaking public ghstStaking = GHSTStaking(0xA02d547512Bb90002807499F05495Fe9C4C3943f);

    /**
     * @dev Fee taken from user to enable auto-petting
     */
    uint256 public fee;

    /**
     * @dev Operator which is used to execute interact function
     */
    address public operator;

    /**
     * @dev List of users
     */
    EnumerableSet.AddressSet internal users;

    /**
     * @dev Users deposits
     */
    mapping(address => uint256) public deposits;

    /**
     * @dev Throws if called by any account other than operator.
     */
    modifier onlyOperator() {
        require(operator == _msgSender(), "AavegotchiPetting: caller is not the operator");
        _;
    }

    event Subscribed(address indexed user, uint256 amount);
    event Unsubscribed(address indexed user, uint256 amount);

    event FeeChanged(uint256 fee);
    event OperatorChanged(address operator);
    event GhstTokenApproved(uint256 amount);

    event TicketsClaimed(uint256[] _ids, uint256[] _values);
    event TicketsWithdrawn(uint256[] _ids, uint256[] _values);

    constructor(uint256 _fee) {
        require(_fee > 0, "AavegotchiPetting: Fee should be larger than 0");
        fee = _fee;

        // Approve maximum GHST tokens for staking
        ghstToken.safeApprove(address(ghstStaking), MAX_INT);
    }

    /**
     * @dev Total GHST tokens stacked
     */
    function totalStaked() external view returns (uint256) {
        (uint256 staked,,) = ghstStaking.staked(address(this));
        return staked;
    }

    /**
     * @dev Total frens earned
     */
    function frens() external view returns (uint256) {
        return ghstStaking.frens(address(this));
    }

    /**
     * @dev Total number of users
     */
    function totalUsers() external view returns (uint256) {
        return users.length();
    }

    /**
     * @dev User address by index
     */
    function userAt(uint256 _index) external view returns (address) {
        return users.at(_index);
    }

    /**
     * @dev Get lists of all users
     */
    function allUsers() external view returns (address[] memory) {
        return users.values();
    }

    /**
     * @dev Subscribe to the auto-petting service
     * Requires approval of GHST token
     */
    function subscribe() external {
        address sender = _msgSender();
        uint256 amount = fee;

        ghstToken.safeTransferFrom(sender, address(this), amount);

        users.add(sender);
        deposits[sender] = amount;

        ghstStaking.stakeGhst(amount);

        emit Subscribed(sender, amount);
    }

    /**
     * @dev Unsubscribe from the auto-petting service
     * Tokens are returned back to the user
     */
    function unsubscribe() external {
        address sender = _msgSender();
        require(users.contains(sender), "AavegotchiPetting: User not found");

        uint256 amount = deposits[sender];

        users.remove(sender);
        deposits[sender] = 0;

        ghstStaking.withdrawGhstStake(amount);
        ghstToken.safeTransfer(sender, amount);

        emit Unsubscribed(sender, amount);
    }

    /* Operator functions */

    /**
     * @dev Pet list of aavegotchies
     * Available for operators only
     */
    function interact(uint256[] calldata _tokenIds) external onlyOperator {
        aavegotchi.interact(_tokenIds);
    }

    /* Admin functions */

    /**
     * @dev Set subscription fee
     */
    function setFee(uint256 _fee) external onlyOwner {
        require(_fee > 0, "AavegotchiPetting: Fee should be larger than 0");
        fee = _fee;

        emit FeeChanged(_fee);
    }

    /**
     * @dev Set operator
     */
    function setOperator(address _operator) external onlyOwner {
        operator = _operator;

        emit OperatorChanged(_operator);
    }

    /**
     * @dev Approve more GHST for stacking
     */
    function approveGhstStaking(uint256 _amount) external onlyOwner {
        ghstToken.safeApprove(address(ghstStaking), _amount);

        emit GhstTokenApproved(_amount);
    }

    /**
     * @dev Claim / buy tickets for frens
     */
    function claimTickets(uint256[] calldata _ids, uint256[] calldata _values) external onlyOwner {
        ghstStaking.claimTickets(_ids, _values);

        emit TicketsClaimed(_ids, _values);
    }

    /**
     * @dev Withdraw tickets to owner
     */
    function withdrawTickets(uint256[] calldata _ids, uint256[] calldata _values) external onlyOwner {
        ghstStaking.safeBatchTransferFrom(address(this), _msgSender(), _ids, _values, "");

        emit TicketsWithdrawn(_ids, _values);
    }
}