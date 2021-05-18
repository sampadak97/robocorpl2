*** Settings ***
Documentation
...   Orders robots from RobotSpareBin Industries Inc.
...   Saves the order HTML receipt as a PDF file.
...   Saves the screenshot of the ordered robot.
...   Embeds the screenshot of the robot to the PDF receipt.
...   Creates ZIP archive of the receipts and the images.
Library           RPA.Browser.Selenium
Library           RPA.HTTP
Library           RPA.Excel.Files
Library           RPA.Excel.Application
Library           RPA.PDF
Library           RPA.Tables
Library           OperatingSystem
Library           Collections 
Library           RPA.Archive
Library           RPA.Robocloud.Secrets
Library           RPA.RobotLogListener
Library           RPA.FileSystem
Library           RPA.Dialogs
Suite Teardown    Close All Browsers
Library            RPA.Tasks
Library            RPA.Word.Application

*** Keywords ***
Open The Intranet Website
    ${secret}=    Get Secret    credentials
    Open Available Browser     ${secret}[url]   
    Set Window Size    1000    1000
    Delete All Cookies

Click popup
    Click Button    xpath://*[@id="root"]/div/div[2]/div/div/div/div/div/button[2]
Download The CSV file
    Download    https://robotsparebinindustries.com/orders.csv    overwrite=True
*** Keywords ***
Files to Table
    ${table}=    Read Table From Csv    orders.csv
    FOR    ${row}    IN    @{table}
        Fill Orders and preview    ${row}
    END
Fill Orders and preview
    [Arguments]    ${row}
    Wait Until Element Is Visible    id:head
    Select From List By Index     id:head   ${row}[Head]
    Wait Until Element Is Visible    name:body
    Click Element    xpath://*[@id="id-body-${row}[Body]"]
    Input Text When Element Is Visible    xpath:/html/body/div/div/div[1]/div/div[1]/form/div[3]/input     ${row}[Legs]  
    Input Text When Element Is Visible    xpath://*[@id="address"]    ${row}[Address]
    Click Button    xpath://*[@id="preview"]
    Wait Until Element Is Visible    xpath://*[@id="order"]
    Click Button    xpath://*[@id="order"]
    ${res}=    Is Element Visible    xpath://*[@id="order-completion"]    
    IF    ${res} == True
        Save html to pdf    ${row}
    END
    
Save html to pdf
    [Arguments]    ${row}
    ${order_receipt_html}=    Get Element Attribute    xpath://*[@id="order-completion"]   outerHTML
    Html To Pdf    ${order_receipt_html}    ${CURDIR}${/}output${/}receipts&images${/}order_receipt${row}[Order number].pdf
    Wait Until Element Is Visible    css:#robot-preview
    Sleep    500ms
    Screenshot    css:#robot-preview  ${CURDIR}${/}output${/}receipts&images${/}order_preview${row}[Order number].png
    Merge png in pdf    ${row}
Merge png in pdf
    [Arguments]    ${row}
    Add Watermark Image To PDF
    ...             image_path=${CURDIR}${/}output${/}receipts&images${/}order_preview${row}[Order number].png
    ...             source_path=${CURDIR}${/}output${/}receipts&images${/}order_receipt${row}[Order number].pdf
    ...             output_path=${CURDIR}${/}output${/}receipts&images${/}order_receipt${row}[Order number].pdf
    Go back to order
Log Out And Close The Browser
    Close Browser
Go back to order
    Sleep    500ms
    Click Button When Visible    id:order-another
    Sleep    500ms
    Click popup
Creating a ZIP archive
   Archive Folder With Zip  ${CURDIR}${/}output${/}receipts&images  ${CURDIR}${/}output${/}receipts&images.zip    recursive=True
Check missing orders
    ${table}=    Read Table From Csv    orders.csv
    RPA.FileSystem.Remove File    ${CURDIR}${/}output${/}missing_orders.xlsx
    Create Workbook    ${CURDIR}${/}output${/}missing_orders.xlsx    
    Set Worksheet Value    1    1    Order number
    Set Worksheet Value    1    2    Head
    Set Worksheet Value    1    3    Body
    Set Worksheet Value    1    4    Legs
    Set Worksheet Value    1    5    Address
    FOR    ${row}    IN    @{table}
        ${find_missing_order}=    Does File Exist    ${CURDIR}${/}output${/}receipts&images${/}order_receipt${row}[Order number].pdf
        IF    ${find_missing_order} == False
            Append Rows To Worksheet    ${row}
        END
        Save Workbook  
    END
    
Handle missing orders
    Create Form    OOPS!Some orders didn't get placed, check them out in "missing_orders.xlsx".
    Add Text Input    Did you enjoyed this automation?(yes/no), please provide feedback for our services.    answer
    ${check}=    Set Variable    yes
    &{response}=    Request Response
    Create File    ${CURDIR}${/}output${/}feedback.txt    content=${response["answer"]}
    
      
    

*** Tasks ***
Log into website and order robot
    Open The Intranet Website
    Click popup
    Download The CSV file
    Files to Table
    Creating a ZIP archive
    Close Browser
    Check missing orders
    Handle missing orders
    
    
   
    

