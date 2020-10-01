names =  input("Enter a list of names").title().split(",")
assignments =  input("Enter a list of number of assignments").split(",")
grades =  input("Enter a list of grades").split(",")

# message string to be used for each student
# HINT: use .format() with this string in your for loop
message = "Hi {},\n\nThis is a reminder that you have {} assignments left to \
submit before you can graduate. You're current grade is {} and can increase \
to {} if you submit all assignments before the due date.\n\n"

# write a for loop that iterates through each set of names, assignments, and grades to print each student's message
for name,assignment,grade in zip(names,assignments,grades):
    msg = message.format(name,assignment,grade,int(grade)+int(assignment)*2)
    print(msg)
