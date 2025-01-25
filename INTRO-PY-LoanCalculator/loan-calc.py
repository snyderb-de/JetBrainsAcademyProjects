import argparse
import math

def calculate_diff_payments(principal, periods, interest_rate):
    total_payment = 0
    for month in range(1, periods + 1):
        diff_payment = math.ceil(
            principal / periods + interest_rate * (principal - (principal * (month - 1)) / periods)
        )
        total_payment += diff_payment
        print(f"Month {month}: payment is {diff_payment}")
    overpayment = total_payment - principal
    print(f"\nOverpayment = {overpayment}")

def calculate_annuity_payment(principal, periods, interest_rate):
    annuity_payment = math.ceil(
        principal * interest_rate / (1 - math.pow(1 + interest_rate, -periods))
    )
    overpayment = annuity_payment * periods - principal
    print(f"Your annuity payment = {annuity_payment}!")
    print(f"Overpayment = {overpayment}")

def calculate_principal(payment, periods, interest_rate):
    principal = math.floor(
        payment / (interest_rate / (1 - math.pow(1 + interest_rate, -periods)))
    )
    overpayment = payment * periods - principal
    print(f"Your loan principal = {principal}!")
    print(f"Overpayment = {overpayment}")

def calculate_periods(principal, payment, interest_rate):
    periods = math.ceil(
        math.log(payment / (payment - interest_rate * principal), 1 + interest_rate)
    )
    years = periods // 12
    months = periods % 12
    if years > 0 and months > 0:
        print(f"It will take {years} years and {months} months to repay this loan!")
    elif years > 0:
        print(f"It will take {years} years to repay this loan!")
    else:
        print(f"It will take {months} months to repay this loan!")
    overpayment = payment * periods - principal
    print(f"Overpayment = {overpayment}")

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Loan Calculator")
    parser.add_argument("--type", help="Type of payment: 'annuity' or 'diff'")
    parser.add_argument("--principal", type=float, help="The loan principal amount")
    parser.add_argument("--payment", type=float, help="The monthly payment amount (annuity)")
    parser.add_argument("--periods", type=int, help="The number of months needed to repay the loan")
    parser.add_argument("--interest", type=float, help="The annual interest rate without the percent sign (e.g., 10 for 10%)")

    # Parse arguments
    args = parser.parse_args()

    # Custom validation
    if args.type not in ["annuity", "diff"]:
        print("Incorrect parameters")
        return
    if args.interest is None:
        print("Incorrect parameters")
        return
    if args.type == "diff" and args.payment:
        print("Incorrect parameters")
        return
    if args.principal and args.principal < 0 or args.payment and args.payment < 0 or args.periods and args.periods < 0 or args.interest and args.interest < 0:
        print("Incorrect parameters")
        return
    if len([arg for arg in [args.principal, args.payment, args.periods, args.interest] if arg is not None]) < 3:
        print("Incorrect parameters")
        return

    # Calculate monthly interest rate
    interest_rate = args.interest / 100 / 12

    # Differentiated payments
    if args.type == "diff":
        if args.principal and args.periods:
            calculate_diff_payments(args.principal, args.periods, interest_rate)
        else:
            print("Incorrect parameters")

    # Annuity payments
    elif args.type == "annuity":
        if args.principal and args.periods and args.interest and args.payment is None:
            calculate_annuity_payment(args.principal, args.periods, interest_rate)
        elif args.payment and args.periods and args.interest and args.principal is None:
            calculate_principal(args.payment, args.periods, interest_rate)
        elif args.principal and args.payment and args.interest and args.periods is None:
            calculate_periods(args.principal, args.payment, interest_rate)
        else:
            print("Incorrect parameters")

if __name__ == "__main__":
    main()
