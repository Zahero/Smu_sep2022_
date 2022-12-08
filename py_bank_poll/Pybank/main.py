#Readable
import csv

csvpath="Pybank/Resources/budget_data.csv"
#initialize rows
rows=0
total=0

last_profit=0
tot_changes=0
num_changes=0

max_change = -999999999
min_change = 999999999
min_month = ""
max_month = ""



with open(csvpath) as csvfile:

#delimiter and variable
    csvreader=csv.reader(csvfile,delimiter=',')

#skip header
    csv_header=next(csvreader)
    print(f"Header: {csv_header}")

    for row in csvreader:
        rows+=1
        total+= int(row[1])

        #calculate changes
        if rows==1:
            last_profit=int(row[1])
        else:
            change=int(row[1])-last_profit
            tot_changes+=change
            num_changes+=1

            #findmax/min
            if(change>max_change):
                max_change=change
                max_month=row[0]
            elif(change<min_change):
                min_change=change
                min_month=row[0]
            else:
                pass


            #reset
            last_profit=int(row[1])

# print(rows)
# print(f"${total}")
# print(num_changes)
# print(round(tot_changes/num_changes,2))
# print(f"Max Change: {max_month}: {max_change}")
# print(f"Min Change: {min_month}: {min_change}")


output=f"""Financial Analysis
----------------------------
Total Months: {rows}
Total: ${total}
Average Change: ${round(tot_changes/num_changes, 2)}
Greatest Increase in Profits: {max_month} (${max_change})
Greatest Decrease in Profits: Feb-14 (${min_change})"""

print(output)
with open('pybank_out.txt', 'w') as f:
    f.write(output)