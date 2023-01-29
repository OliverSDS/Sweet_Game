pragma solidity ^0.8.0;

contract SweetBonanza {
   uint256 jackpot;
   uint256 bet;
   uint256 randomNumber;
   uint256 winnings;
   uint256[6] candies;
   
   function placeBet(uint256 _bet) public payable {
      require(msg.value == _bet, "Invalid bet amount.");
      bet = _bet;
      randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)));
      winnings = calculateWinnings();
      jackpot += bet;
   }
   
   function calculateWinnings() private view returns (uint256) {
      uint256 winAmount = 0;
      for (uint256 i = 0; i < 6; i++) {
         if (candies[i] == randomNumber) {
            winAmount += bet * 10;
         }
      }
      return winAmount;
   }
   
   function withdraw() public {
      require(winnings > 0, "No winnings to withdraw.");
      msg.sender.transfer(winnings);
      winnings = 0;
   }
}