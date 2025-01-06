import random

num_people = int(input("Enter the number of friends joining (including you):\n"))

if num_people <= 0:
    print("No one is joining for the party")
else:
    print("Enter the name of every friend (including you), each on a new line:")
    friends_dict = {}
    for _ in range(num_people):
        name = input("> ")
        friends_dict[name] = 0

    bill_value = float(input("\nEnter the total bill value:\n> "))
    split_value = round(bill_value / num_people, 2)

    for friend in friends_dict:
        friends_dict[friend] = split_value

    use_feature = input('\nDo you want to use the "Who is lucky?" feature? Write Yes/No:\n> ')

    if use_feature == "Yes":
        lucky_one = random.choice(list(friends_dict.keys()))
        print(f"\n{lucky_one} is the lucky one!\n")

        # Recalculate the split for the remaining friends
        new_split_value = round(bill_value / (num_people - 1), 2)

        for friend in friends_dict:
            if friend == lucky_one:
                friends_dict[friend] = 0
            else:
                friends_dict[friend] = new_split_value
        print(friends_dict)
    else:
        print("\nNo one is going to be lucky\n")
        print(friends_dict)

