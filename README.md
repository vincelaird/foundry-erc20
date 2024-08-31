# OurToken - ERC20 Token Project

OurToken is a simple ERC20 token implementation built using Solidity and OpenZeppelin contracts. This project demonstrates the basic functionality of an ERC20 token, including minting, transferring, and managing allowances.

## Features

- ERC20 compliant token
- Initial supply minted to the deployer
- Standard transfer and approval functions
- Comprehensive test suite

## Project Structure

- `src/OurToken.sol`: Main token contract
- `script/DeployOurToken.s.sol`: Deployment script
- `test/OurTokenTest.t.sol`: Test suite for the token contract

## Token Details

- Name: OurToken
- Symbol: OT
- Decimals: 18
- Initial Supply: 1000 tokens

## Testing

The project includes a comprehensive test suite covering various aspects of the token functionality, including:

- Initial supply and balance checks
- Transfer functionality
- Allowance and transferFrom operations
- Failure cases for insufficient balance and allowance

## Deployment

The deployment script (`DeployOurToken.s.sol`) allows for easy deployment of the token contract with the specified initial supply.

## Technologies Used

- Solidity
- Foundry (for testing and deployment)
- OpenZeppelin Contracts

## License

This project is licensed under the MIT License.
