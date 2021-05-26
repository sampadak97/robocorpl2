# robocorpl2
robocorp L2 submission <br>
This project serves following functionalities: <br>
  -> Open orders url by fetching from Vault <br>
  -> Downloads orders.csv <br>
  -> Place orders provided in orders.csv and stores receipts in pdf as well as snapshot of bots ONLY when orders are succesfully placed. <br>
  -> If any order gets error and cannot be placed, it gets retried again and again until placed.<br>
  -> After completing all orders, robocorp assistant prompts to user if they enjoyed the order experience.<br>
  -> Also, user can comment their feedback in the same prompt, this input will be stored in feedback.txt file.<br>
  -> Find all outputs in 'outputs' folder. <br>
To run the code: <br>
  -> Clone this repository in local. <br>
  -> Open VSCode (ensure that robocorp assistant and extensions are already installed) <br>
  -> Run the robot: ctrl + shift + p and run. <br>
