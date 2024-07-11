#!/bin/bash

#The result of the arithmetic operation is stored here
result=0

RESULT="\e[1;32mResult: \e[0m"


#A function to validate if the input is a number
isNumber() {
        #A regex that checks for number
        regex="^-?[0-9]+([.][0-9]+)?$"

        # if the input entered is not a number it exit the program
        if ! [[ $1 =~ $regex ]]
        then
                echo -e "\e[1;31m$1 is not a number\e[0m"
                exit 1
        fi
}



#A function that performs addition of multiple numbers
add() {
        #Initialize the result to be zero
        result=0

        #Loop through the array
        for operand in "$@"
        do
                #Add each number in the array
                result=$(echo "$result + $operand" | bc)
        done
        echo -e "${RESULT}$result"
        echo
        echo
}


#A function that performs subtraction of multipe numbers
subtract() {
        #Initialize the result to be the first value in the array
        result=$1

        #Shift the array to the left to eliminate the first value in the array since the first value as been assigned to the result
        shift

        #Loop through the array
        for operand in "$@"
        do
                #Substract each number in the array
                result=$(echo "$result - $operand" | bc)
        done
        echo -e "${RESULT}$result"
        echo
        echo
}


# A function that performs division of multiple numbers
divide() {
        #Initialize the result to be the first value in the array
        result=$1

        #Shift the array to the left to eliminate the first value in the array since the first value as been assigned to the result
        shift

        #Loop through the array
        for operand in "$@"
        do
                #Check if the numbers in the array is zero
                if [ "$operand" -eq 0 ]
                then
                        #if it is zero return so the calculation is stopped
                        echo "\e[1;31mCannot divide by 0\e[0m"
                        echo
                        echo
                        return
                fi
                #Divide each number in the array
                result=$(echo "$result / $operand" | bc)
        done
        echo -e "${RESULT}$result"
        echo
        echo
}

#A function that shows the operations that are allowed and the instructions to follow
displayMenu() {
        echo -e  "\e[1;33mAvailable arithmetic operation: \e[0m"
        echo -e "\e[32mEnter 1 for Addition\e[0m"
        echo -e "\e[32mEnter 2 for Subtraction\e[0m"
        echo -e  "\e[32mEnter 3 for Multiplication\e[0m"
        echo -e "\e[32mEnter 4 for Division\e[0m"
        echo -e "\e[32mEnter 5 to Exit Program\e[0m"
}

while true
do
        #Show the menu for operation
        displayMenu

        #Enter the number for the arithemtic the user wants to perform
        read -p "Enter the number corresponding to the arithemtic operation you wish to perform: " operation


        #This statement ensures the user selects number from 1 to 5
        if ! [[ $operation =~ ^[1-5]$ ]]
        then
                echo -e "\e[1;31mInvalid operation entered, Select between 1 to 5 only.\e[0m"
                echo
                echo
                continue
        fi

        #This statement exit the loop if the input entered is 5
        if [ "$operation" -eq 5 ]
        then
                echo -e "\e[1;31mExit\e[0m"
                echo
                echo
                break
        fi


        #Allows the users to enter the number they want to perform operation on
        read -p "Enter the values seperated by space: " -a operands




        #Validates if the input entered is a number
        for operand in "${operands[@]}"
        do
                isNumber "$operand"
        done

        #Based on the operation number selected, it selects the operation to perform
        case $operation in
                1)
                        add "${operands[@]}"
                        ;;
                2)
                        subtract "${operands[@]}"
                        ;;
                3)
                        multiply "${operands[@]}"
                        ;;
                4)
                        divide "${operands[@]}"
                        ;;
                *)
                        echo -e "\e[1;31mInvalid operation.\e[0m"
                        echo
                        echo
                        ;;
        esac


done





