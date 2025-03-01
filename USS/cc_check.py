#Import the Z Open Automation Utilities libraries we need
from zoautil_py import MVSCmd, Datasets
from zoautil_py.types import DDStatement
# Import datetime, needed so we can format the report
from datetime import datetime
# Import os, needed to get the environment variables
import os

# luhn algo
def luhn(card_number: str):
    def digits_of(n):
        return [int(d) for d in str(n)]
    digits = digits_of(card_number)
    odd_digits = digits[-1::-2]
    even_digits = digits[-2::-2]
    checksum = 0
    checksum += sum(odd_digits)
    for d in even_digits:
        checksum += sum(digits_of(d*2))
    return (checksum % 10)

#Take the contents of this data set and read it into cc_contents
cc_contents = Datasets.read("MTM2020.PUBLIC.CUST16")

USERID = os.getenv('USER')
output_dataset=USERID+".OUTPUT.CCINVALD"
#Delete the output dataset if it already exists
if Datasets.exists(output_dataset):
    Datasets.delete(output_dataset)
# Use this line to create a new SEQUENTIAL DATA SET with the name of output_dataset
# (hint: https://www.ibm.com/support/knowledgecenter/SSKFYE_1.0.1/python_doc_zoautil/api/datasets.html?view=embed)
Datasets.create(output_dataset, type="SEQ")


cc_list = cc_contents.splitlines()      # take that giant string and turn it into a List
invalid_cc_list_string = ""
for cc_line in cc_list:                 # do everything here for every item in that List
    # %B0001515291333879154
    #      ^              ^
    cc_digits = cc_line[5:21]     # Just grabbing some digits. Not a full CC number (HINT!)
    if luhn(cc_digits):            # If the card number is invalid
        invalid_cc_list_string += cc_line
        invalid_cc_list_string += "\n"
        


#The Report-Writing Part
    #
    # NOTE: DON'T USE APPEND FOR MULTIPLE LINES. 
    #       IT WILL BE SLOW
    #       INSTEAD, THROW EVERYTHING INTO A VARIABLE
    #       AND WRITE THAT OUT ONCE, LIKE THIS.
    #       
    #       TRUST US ON THIS.
    #
    #       YOU SHOULD BE ABLE TO USE THE CODE BELOW, ONLY HAVING TO ADD
    #       A LINE TO WRITE OUT THE FINAL report_output TO YOUR output_dataset
    #       REMEMBER, THE REPORT NEEDS TO HAVE THE DATETIME STRING IN IT ABOVE THE DATA
    #
now = datetime.now()
dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
report_output = invalid_cc_list_string
report_output = "INVALID CREDIT CARD REPORT FOR " + dt_string + '\n\n' + report_output
print(report_output)  # Print it out to the screen. 
# When you're ready to write your report out to file, uncomment that last line
Datasets.write(output_dataset,report_output)