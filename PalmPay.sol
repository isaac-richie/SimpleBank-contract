//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract PalmPay {
   mapping(address => uint256) public balances;//balances of customers
   address payable owner;

   constructor () public {
       owner == payable(msg.sender);
   }

   modifier onlyOwner() {
       require(owner == msg.sender, "only owner can call this function");
       _;
   }

   function depositFunds() public payable {
       require(msg.value > 0, "alaye put better money");//run better funds
       balances[msg.sender] += msg.value;
   }

   function withdrawFunds(uint256 amount) public {
       require(msg.sender == owner, "no be you get money... close your eyes");
       require(amount <= balances[msg.sender], "insufficient funds");
       require(amount > 0, "alaye you broke");
       payable(msg.sender).transfer(amount);//transfering the funds to the owner
       balances[msg.sender] -= amount;//withdrawing the owners funds from the mapping
   }

   function transferFunds(address payable reciever, uint256 amount) public {
       require(msg.sender == owner, "no be you get money... close your eyes");
       require(amount <= balances[msg.sender], "insufficent funds");
       require(amount > 0, "no funds to transfer");
       balances[msg.sender] -= amount;
       balances[reciever] += amount;
   }
   

   function getBalance(address payable user) public view returns(uint256){
       return balances[user];
   }

   function givePermission(address payable user) public {
       require(msg.sender == owner, "you no be owner");
       owner = user;//permission has been give to another user to spend the funds on behalf of owner... this is a cas of giving out a loan
   }

   function revokePermission(address payable user) public {
       require(msg.sender == owner, "you are not owner, owner can revoke access");
       require(user != owner, "cannot revoke permission for the current owner");
       owner == payable(msg.sender);
   }

   function destroy() public {
       require(msg.sender == owner, "owner owner can destroy contract");
       selfdestruct(owner);
   }

   function withdrawfundsAsOnwer() public  onlyOwner {
       uint256 contractBalance = address(this).balance;
       require( contractBalance > 0, "insufficient funds");
       payable(owner).transfer(contractBalance);
   }

   function getBalance() public view returns(uint256) {
       return address(this).balance;
   }
   
}