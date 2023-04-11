import xlsxwriter
import numpy as np

filename = "New Text Document (6).txt"

workbook = xlsxwriter.Workbook(filename + ".xlsx")
worksheet = workbook.add_worksheet()

f = open(filename , "r")

data = []

for index,line in enumerate(f):
  if index >= 6:
    split = line.split(" ")
    data.append(split)

row = 0

data = np.array(data)
data = data.T

for col, d in enumerate(data):
    worksheet.write_column(row, col, d)

workbook.close()