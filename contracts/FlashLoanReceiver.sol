// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Token.sol";
import "./FlashLoan.sol";

contract FlashLoanReceiver {
    FlashLoan private pool;
    address private owner;

    event LoanReceived(address token, uint256 amount);

    constructor(address poolAddress) {
        pool = FlashLoan(poolAddress);
        owner = msg.sender;
    }

    /* 4. Function called using fallback function */
    function receiveTokens(address tokenAddress, uint256 amount) external {
        require(msg.sender == address(pool), "Sender must be pool");

        emit LoanReceived(tokenAddress, amount);

        /* Write a code to use your funcds */

        /* 5. send the funds back */
        require(
            Token(tokenAddress).transfer(msg.sender, amount),
            "Transfer of tokens failed"
        );
    }

    /* 1. Initiating Flash Loan */
    function executeFlashLoan(uint256 amount) external {
        require(msg.sender == owner, "Only owner can execute flash loan");
        pool.flashLoan(amount);
    }
}
