# robocorpl2
robocorp L2 submission <br>
This project serves following functionalities: <br>
  -> Open orders url by fetching from Vault <br>
  -> Downloads orders.csv <br>
  -> Place orders provided in orders.csv and stores receipts in pdf as well as snapshot of bots ONLY when orders are succesfully placed. <br>
  -> If some orders get error and cannot be placed, they get skipped and code still runs.<br>
  -> After orders are completed, bot checks order receipt numbers(which are the order numbers in file) and creates an excel sheet which stores all missed orders.<br>
  -> After completing this excel sheet of missed orders, robocorp assistant prompts to user if they want to reorder the missed once again?- there are 2 possible inputs: yes or no.<br>
  -> If user sends yes, the code runs only for those orders which were missed, if no is entered, browser closes and code exits. <br>
  -> The user prompt will loop if there are no records in missing order file, i.e. if that excel is empty. <br>
  -> Find all outputs in 'outputs' folder. <br>
To run the code: <br>
  -> Clone this repository in local. <br>
  -> Open VSCode (ensure that robocorp assistant and extensions are already installed) <br>
  -> Run the robot: ctrl + shift + p and run. <br>
