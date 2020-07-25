# DS_Homework1 Thought Process
- Number 1
    - Use Count and the Asterix wildcard to get the number of users.
- Number 2
    - A transfer is denoted by
        - Wave to wave (two way transaction) 
        - Wave to mobile (one way transaction)
        - Bill payment and other payments(kind)
    - General transfer 
        - We will use transfer_id, u_id and source_wallet_id
        - We have to compare the transfer_id with u_id to ensure they match and compare source_wallet_id with wallet_id to ensure they match and see if send_amount_currency is equal to CFA. 

- Number 3
    - This is used for find the number of users who made transfers without repetition. 

- Number 4 
    - Find the Total number of agent transaction  by comparing the agents in the agents table to the agents in the agent transaction in the year 2018 with an order of months. 

- Number 5
    - To find net depositors find agents who have amounts less than 0
    - To find net withdrawers find agents who have amounts greater than 0


- Number 6
    -  Find volume by finding the count of the transactions in a week then group it by a city. 


- Number 7 
    - Add countries to the results for the previous question. 

- Number 8 
    - Finding the volume of send_amount scalar and group it by country and transfer kind. 


- Number 9 
    - Since an agent transaction deals with withdraws, sending and receiving it is more qualified to be used as the transaction count. 
    - To ensure the unique users are correct also print the users’ names .


- Number 10
    - Find the source wallet ids that correspond to the wallets wallet_id and find scalar amount greater than 10 mil and in CFA for a week. 

