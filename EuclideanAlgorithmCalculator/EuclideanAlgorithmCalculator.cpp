#include <iostream>
#include <cstdlib>
#include <vector>
#include <cstdio>

using namespace std;

int checkInputInt(int& getNum);
int findGcd(int& bigNum, int& smallNum);
unsigned int smallNumberVectorSize, bigNumberVectorSize;
int bigNumber, smallNumber, nextSmall, modGet, gcd;
vector<int> smallNumberVector;
vector<int> bigNumberVector;

//TODO thought process, create a loop that will go until nextSmall is zero 0.
//to fill up the vectors and then sequentially display the variables inside the vectors.
//check for correct input and correct big number small number input.
//check for 0 input to avoid runtime errors.

int main() {
    cout << "This is a program that tries to calculate the Greatest Common Divisor\n";
    cout << "(GCD) for two numbers. It uses the Eucledian Algorithm.\n";

    //ask for input
    cout << "Big Number: \n";
    cin >> bigNumber;
    bigNumber = checkInputInt(bigNumber);
    cout << "Small Number: \n";
    cin >> smallNumber;
    smallNumber = checkInputInt(smallNumber);

    //add to vector
    smallNumberVector.push_back(smallNumber);
    bigNumberVector.push_back(bigNumber);

    //execution
    gcd = findGcd(bigNumber, smallNumber);

    //result
    cout << "GCD: " << gcd << endl;

    getchar();
    return 0;
}

int checkInputInt(int& getNum) {
    int holdNum = getNum;
    if (holdNum < 0)
        holdNum = holdNum * -1;
    return holdNum;
}

int findGcd(int& bigNum, int& smallNum) {
    //calculate test
    bigNumber = bigNum;
    smallNum = smallNumber;
    do {
        if (smallNumber == 0)
            break;

        modGet = bigNumber / smallNumber;
        nextSmall = bigNumber - (smallNumber * modGet);

        bigNumber = smallNumber;
        smallNumber = nextSmall;

        smallNumberVector.push_back(smallNumber);
        bigNumberVector.push_back(bigNumber);
    } while (smallNumber >= 0);

    //a loop to display the output of the vectors
    for (bigNumberVectorSize = 0; bigNumberVectorSize < bigNumberVector.size(); bigNumberVectorSize++) {
        cout << "Big Number: " << bigNumberVector[bigNumberVectorSize] << endl;
    }

    for (smallNumberVectorSize = 0; smallNumberVectorSize < smallNumberVector.size(); smallNumberVectorSize++) {
        cout << "Small Number: " << smallNumberVector[smallNumberVectorSize] << endl;
    }

    bigNumberVectorSize = bigNumberVector.size() - 1;
    return bigNumberVector[bigNumberVectorSize];
}
