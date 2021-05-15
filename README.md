# robocorpl2
robocorp L2 submission
This project serves following functionalities:
  -> Open orders url by fetching from Vault
  -> Downloads orders.csv 
  -> Place orders provided in orders.csv and stores receipts in pdf as well as snapshot of bots ONLY when orders are succesfully placed.
  -> If some orders get error and cannot be placed, they get skipped and code still runs.
  -> After orders are completed, bot checks order receipt numbers(which are the order numbers in file) and creates an excel sheet which stores all missed orders.
  -> After completing this excel sheet of missed orders, robocorp assistant prompts to user if they want to reorder the missed once again?- there are 2 possible inputs: yes or no.
  -> If user sends yes, the code runs only for those orders which were missed, if no is entered, browser closes and code exits.
To run the code:
  -> Clone this repository in local.
  -> Open VSCode (ensure that robocorp assistant and extensions are already installed)
  -> Run the robot: ctrl + shift + p and run.
