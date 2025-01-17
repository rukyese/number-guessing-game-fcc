# Number Guessing Game

This repository contains a Bash script and a PostgreSQL database for managing a number guessing game. The project includes a database to store user statistics, such as the number of games played and the best performance (fewest guesses to win). The Bash script allows users to play a guessing game where they try to guess a randomly generated number between 1 and 1000.

## Files

- number_guess.sql: SQL dump of the number_guess database schema and sample data.
- number_guess.sh: Shell script that interacts with the PostgreSQL database to retrieve and update user information, and facilitates the number guessing game.

## How to Use

### Clone the Repository

```bash
git clone https://github.com/your-github-username/number-guessing-game.git
cd number-guessing-game-fcc
```

### Rebuild the Database

You can rebuild the database by entering the following command in a terminal where the number_guess.sql file is located:

```bash
psql -U postgres < number_guess.sql
```

This will create the number_guess database and load the relevant data.

### Run the number_guess.sh script

The number_guess.sh script allows you to play the number guessing game and interact with the database. To use it:

1. First, ensure that the script has executable permissions:

```bash
chmod +x number_guess.sh
```

2. Run the script. It will ask for your username, then prompt you to guess a randomly generated number between 1 and 1000. For example:

```
Enter your username:
John
Welcome, John! It looks like this is your first time here.
Guess the secret number between 1 and 1000:
```

3. If the username is already in the database, the script will show your previous statistics:

```
Welcome back, John! You have played 5 games, and your best game took 7 guesses.
```

4. If you input anything other than an integer while guessing, the script will output:

```
That is not an integer, guess again:
```

5. Once you guess the secret number, the script will output:

```
You guessed it in 8 tries. The secret number was 456. Nice job!
```
