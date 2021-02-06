# !/usr/bin/python3

"""
Usage:
    python3 runsample.py [optional] --f file_name [optional] --add InputFileName
    python3 runsample.py [optional] --f file_name
    python3 runsample.py [optional] --add InputFileName

Option:
    -h, --help, --f, --add

"""

import subprocess
import sys
import http.server
import json
import os
import argparse
import pathlib
import termcolor


def GetSample():
    json_data = None

    print("Listening on port 10043\n")

    class CompetitiveCompanionHandler(http.server.BaseHTTPRequestHandler):
        def do_POST(self):
            nonlocal json_data
            json_data = json.load(self.rfile)

    with http.server.HTTPServer(('127.0.0.1', 10043), CompetitiveCompanionHandler) as server:
        server.timeout = None
        server.handle_request()

    if json_data is not None:
        print(json.dumps(json_data))
        f = open('DATA_JSON.json', 'a')
        f.write(json.dumps(json_data, indent=4))
        f.close()
    else:
        # print("Got no data")
        os.system("notify-send \"Got no data \"")
        sys.exit("Got no Data")


def Runfor(Output, ExpOutput, isDouble, DoubleTolerance):

    # print ("Input:\n" + Input)
    # print (Output)
    # print ("expeoutput:\n" + ExpOutput)

    Output = Output.split()
    # print ("output:\n" + str(Output))
    ExpOutput = ExpOutput.split()
    # print ("expeoutput:\n" + str(ExpOutput))
    equal = True
    length = len(Output)

    if len(ExpOutput) != length:
        equal = False
    else:
        for i in range(length):
            if isDouble == True:
                equal &= (
                    abs(float(Output[i]) - float(ExpOutput[i])) <= DoubleTolerance)
            else:
                equal &= (Output[i] == ExpOutput[i])

    if equal == True:
        print(termcolor.colored("\tTest Passed!", 'green'))
    else:
        print("Expected Output:\n" + str(ExpOutput))
        print(termcolor.colored("\tTest Failed!", 'red'))

    return equal


def RunSample(command):
    print("command for executing the program: " + command)

    Data = json.load(open('DATA_JSON.json', 'r'))

    totalTests = len(Data['tests'])
    print("total no of tests: " + str(totalTests))

    isDouble = False
    DoubleTolerance = 1e-9
    if isDouble:
        print("Running with Double Tolerance: " + str(DoubleTolerance))

    # firstInput = str(Data['tests'][0]['input'])
    # output = subprocess.run((command), stdout=subprocess.PIPE, input=firstInput, encoding='ascii')
    # print (output)

    print("Running Samples:- ")
    print(termcolor.colored("-----------", 'white', attrs=['bold']))

    totalCorrect = 0

    for I in range(totalTests):
        Input = str(Data['tests'][I]['input'])
        print("Output No: " + str(I + 1))
        os.system("echo \'%s\'" % Input + " | %s" % command)
        totalCorrect += Runfor(str(subprocess.run((command), stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                                  input=Input, encoding='ascii').stdout), str(Data['tests'][I]['output']), isDouble, DoubleTolerance)

    print()
    print(termcolor.colored("%s / %s Test Passed!" % (totalCorrect, totalTests),
                            'green' if totalCorrect == totalTests else 'red', attrs=['bold']))
    print(termcolor.colored("-----------", 'white', attrs=['bold']))


def AddSampleTestToJson(InputFileName):
    print("input file name to be added to DATA_JSON: " + InputFileName)

    TestData = subprocess.run(("cat %s" % InputFileName), shell=True,
                              stdout=subprocess.PIPE).stdout.decode('utf-8').split("Output:\n")

    Data = json.load(open('DATA_JSON.json', 'r'))
    Data['tests'].append({
        "input": TestData[0],
        "output": TestData[1]
    })
    # print (json.dumps(Data, indent=4))
    try:
        with open('DATA_JSON.json', 'w') as f:
            f.write(json.dumps(Data, indent=4))
    except:
        sys.exit("error occured while adding test cases in json file")


def main():
    # check for sample input file
    if pathlib.Path('./DATA_JSON.json').exists() == False:
        GetSample()

    parser = argparse.ArgumentParser()
    parser.add_argument("--f", help="file to run through samples")
    parser.add_argument('--add', help="Add sample test to json")
    args = parser.parse_args()
    print(args)

    if args.add != None:
        AddSampleTestToJson(args.add)

    if args.f == None:
        if args.add == None:
            sys.exit(
                "Check Usage!!\nNeed arguments ['-h', '--help', '--f', '--add']")
        else:
            return

    fileinfo = args.f

    print("fileinfo: " + termcolor.colored("%s" %
                                           fileinfo, 'white', 'on_magenta'))

    fileExtension = pathlib.Path(fileinfo).suffix

    Commandforexecution = ""

    if fileExtension == ".cpp":
        executableName = pathlib.Path(fileinfo).stem

        if pathlib.Path('./%s' % executableName).exists() == False:
            # ask to compile the file
            print("No executable found for ", termcolor.colored(
                "%s.cpp" % executableName, 'red', attrs=['bold']))
            exit(0)
        else:
            print("Found Executable")
            Commandforexecution = "./%s" % executableName
    else:
        print("Cannot run sample through " + termcolor.colored("%s" %
                                                               fileinfo, 'red', attrs=['bold']))
        return

    RunSample(Commandforexecution)
    return


if __name__ == "__main__":
    main()
