
//Task 2 (16-06-2024)
use VIT;
db.createCollection("Employee");

//insert documents
db.Employee.insertMany([
    { name: "Alice", age: 30, salary: 25000 },
    { name: "Bob", age: 35, salary: 30000 },
    { name: "Charlie", age: 40, salary: 40000 },
    { name: "David", age: 32, salary: 20000 },
    { name: "Eve", age: 28, salary: 45000 }
]);

//Lowest salary among employees aged 30-40
db.Employee.find(
    { age: { $gte: 30, $lte: 40 } },
    { _id: 0, name: 1, salary: 1 }
).sort({ salary: 1 }).limit(1);

use Saturday;
db.createCollection("student");
// Insert documents
db.student.insertMany([
    { name: "Tom", mark: 85, age: 20 },
    { name: "Jerry", mark: 95, age: 22 },
    { name: "Spike", mark: 78, age: 23 },
    { name: "Tyke", mark: 92, age: 21 }
]);

//highest mark
db.student.find(
    {},
    { _id: 0, name: 1, mark: 1 }
).sort({ mark: -1 }).limit(1);

//TASK 2 (18-06-2024)
// Step 1: Create student collection and insert documents
use VIT2;
db.createCollection("student");
db.student.insertMany([
    { name: "John", age: 28, department: "Sales", salary: 30000 },
    { name: "Jane", age: 35, department: "HR", salary: 40000 },
    { name: "Alice", age: 30, department: "IT", salary: 50000 },
    { name: "Bob", age: 45, department: "Sales", salary: 35000 },
    { name: "Charlie", age: 25, department: "IT", salary: 45000 },
    { name: "David", age: 32, department: "HR", salary: 38000 },
    { name: "Eva", age: 40, department: "IT", salary: 55000 }
]);

// Question 1: Find employees who are exactly 30 years old.
db.student.find({ age: { $eq: 30 } });

// Question 2: Find employees who are not in the HR department.
db.student.find({ department: { $ne: "HR" } });

// Question 3: Find employees who are older than or equal to 35 years.
db.student.find({ age: { $gte: 35 } });

// Question 4: Find employees who are younger than 30 years.
db.student.find({ age: { $lt: 30 } });

// Question 5: Find employees who have a salary between 35000 and 50000 inclusive.
db.student.find({ salary: { $gte: 35000, $lte: 50000 } });

// Question 6: Find employees who work in either the IT or Sales department.
db.student.find({ department: { $in: ["IT", "Sales"] } });

// Question 7: Find employees whose name starts with the letter 'A'.
db.student.find({ name: { $regex: /^A/ } });

// Question 8: Find employees who are either younger than 30 or have a salary greater than 50000.
db.student.find({ $or: [{ age: { $lt: 30 } }, { salary: { $gt: 50000 } }] });

// Question 9: Find employees who are either younger than 30 or have a salary greater than 50000.
db.student.find({ $or: [{ age: { $lt: 30 } }, { salary: { $gt: 50000 } }] });

// Question 10: Find employees whose name contains the letter 'o'.
db.student.find({ name: { $regex: /o/ } });

// Question 11: Find employees who do not work in the Sales or IT departments.
db.student.find({ department: { $nin: ["Sales", "IT"] } });

// Question 12: Find employees who are older than 30 and have a salary less than 40000.
db.student.find({ $and: [{ age: { $gt: 30 } }, { salary: { $lt: 40000 } }] });
