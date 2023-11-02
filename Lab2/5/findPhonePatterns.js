function findPhonePatterns(phoneDocuments) {
    const phoneNumbers = phoneDocuments.map((doc) => doc._id.toString());
    const palindromes = [];
    const sequences = [];
    const uniqueDigitNumbers = [];

    phoneNumbers.forEach((phoneNumber) => {
        phoneNumber = phoneNumber.substring(3);
        if (phoneNumber === phoneNumber.split("").reverse().join("")) {
            palindromes.push(phoneNumber);
        }

        let isSequence, isDecreasingSequence = true;
        numberLength = 9;
        for (let i = 4; i < numberLength; i++) {
            if (parseInt(phoneNumber[i]) !== parseInt(phoneNumber[i - 1]) + 1) {
                isSequence = false;
            }
            if (parseInt(phoneNumber[i]) !== parseInt(phoneNumber[i - 1]) - 1) {
                isDecreasingSequence = false;
            }
        }
         
        if (isSequence || isDecreasingSequence)
            isSequence = true;
        
        
        else if (/(\d{2})\1{2}/.test(phoneNumber.substring(3))) {
            isSequence = true;
        }
         
        else if (/(\d{3})\1+/.test(phoneNumber.substring(3))) {
            isSequence = true;
        }
         
        if (isSequence) {
            sequences.push(phoneNumber);
        }

        const digitSet = new Set(phoneNumber);
        if (digitSet.size === numberLength) {
            uniqueDigitNumbers.push(phoneNumber);
        }
    });

    return {
        palindromes,
        sequences,
        uniqueDigitNumbers,
    };
}