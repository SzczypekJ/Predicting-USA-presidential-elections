import pandas as pd
import matplotlib.pyplot as plt

# Load the uploaded Excel file
file_path = 'C:/Users/szczy/Downloads/template.xlsx'
data = pd.read_excel(file_path)

# Plotting Gun ownership % over the years for all states
plt.figure(figsize=(15, 10))

for state in data['State'].unique():
    state_data = data[data['State'] == state]
    plt.plot(state_data['Year'], state_data['Gun ownership %'], marker='o', label=state)

plt.title('Gun Ownership % Over the Years for All States')
plt.xlabel('Year')
plt.ylabel('Gun Ownership %')
plt.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
plt.grid(True)
plt.show()
