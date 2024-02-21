// Problem !
// Write a functions, which will be reusable, you are able to use 2 params in it:
// 1. is SORTED array , in our case is All states of the USA (already prepared)
// 2. is target string, which is finding word, if state is  part of this array or not
// A.C. : DO NOT USE Linear Search


const states = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming"
];
/**
 * Performs a binary search on a sorted array of strings.
 * @param states - A sorted array of state names.
 * @param target - The state name to search for.
 * @returns The index of the target state in the array, or -1 if not found.
 */
const binarySearch = (states:string[], target:string):number => {
    let start = 0;
    let end = states.length - 1;

    while (start <= end) {
        let middle = Math.floor((start + end) / 2);

        if (states[middle] === target) {
            return middle; // Target found, return its index
        } else if (states[middle] < target) {
            start = middle + 1; // Target is in the right half
        } else {
            end = middle - 1; // Target is in the left half
        }
    }

    return -1; // Target not found
};

// Example usage:
const index = binarySearch(states, "Michigan");
if (index !== -1) {
    console.log(`State: ${states[index]} is in the array at position ${index}.`);
} else {
    console.log(`State is NOT in the array!`);
}
