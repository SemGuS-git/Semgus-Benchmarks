from io import StringIO
import json

data = [ ]
with open("dnf-data.json") as f:
    problems = json.load(f)

    for problem in problems:
        varsN = problem['numVars']
        size = 0 
        
        clauses = problem['formula']
        expectedOutput = ""
        for clause in clauses:
            expectedOutput += "("
            for var in clause:
                size += 1
                if int(var) > 0:
                    expectedOutput += "v" + str(var)
                else:
                    expectedOutput += "~v" + str(abs(var)) 
                expectedOutput += " ^ "
            expectedOutput = expectedOutput[:-3] + ") v " 
        expectedOutput = expectedOutput[:-3]
        print(expectedOutput)

        expOutput = problem['expectedOutput']
        #if expectedOutput != expOutput:
            #print("expected:", expOutput)
            #print("got:", expectedOutput)
            #break

        posEx = [ ]
        negEx = [ ]
        for i in range(2**varsN):
            bitString = ('{0:0' + str(varsN) + 'b}').format(i)
            posList = [i+1 for i in range(len(bitString)) if bitString[i] == "1"]
            negList = [i+1 for i in range(len(bitString)) if bitString[i] == "0"]

            formulaVal = True
            for clause in clauses:
                clauseVal = False
                for var in clause:
                    if (int(var) > 0 and abs(var) in posList) or (int(var) < 0 and abs(var) in negList):
                        clauseVal = True
                        break
                if clauseVal == False:
                    formulaVal = False
                    negEx.append(bitString) 
                    break
            if formulaVal == True:
                posEx.append(bitString)

        name = "dnf_" + str(varsN) + "_" + str(size)
        typeName = "dnf"

        dictt = {"name": name, "size": varsN, "type": typeName, "posEx": posEx, "negEx": negEx, "expectedOutput": expectedOutput}
        data.append(dictt)

with open("dnf-boolean-problems.json", "w") as outfile:
    outfile.write(json.dumps(data))
