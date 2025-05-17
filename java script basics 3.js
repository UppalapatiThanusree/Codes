const student = {
  name: "Thanusree",
  age: 21,
  branch: "CSE"
};

for (let key in student) {
  console.log(key + ": " + student[key]);
}
