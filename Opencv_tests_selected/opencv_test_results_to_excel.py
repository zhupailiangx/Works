import argparse
import pandas as pd

def main(args):
    df = pd.read_html(args.input_path)
    df = pd.DataFrame(df[0])
    df['Skew']=args.Skew
    df['File Name'] = args.File_Name
    df['Memory type'] = args.Memory_type
    df['OS'] = args.OS
    df['OpenCV version'] = args.OpenCV_version
    df['OpenCV install'] = args.OpenCV_install
    df['OpenCL'] = args.OpenCL
    df['Memory Speed'] = args.Memory_Speed
    df['WW'] = args.WW
    df['CPU_req'] = args.CPU_req
    #df = df.sort_values(by='Name of Test',ascending=True)
    df.to_excel(args.output_path,index=False)
    print(df)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='opencv_tests')
    parser.add_argument('--input_path',default=r"C:\Users\pailianx\Downloads\opencv-12700-10-07\imgproc_selected.ods", type=str,help ='input ods file')
    parser.add_argument('--output_path',default = r"C:\Users\pailianx\Downloads\opencv-12700-10-07\imgproc_selected2.xlsx", type=str,help='result excel file')
    parser.add_argument('--Skew', default="12700", type=str, help='Machine type')
    parser.add_argument('--File_Name',default="core" ,type=str, action='store',help='Moudle')
    parser.add_argument('--Memory_type', default="DDR4", type=str, help='Memory type')
    parser.add_argument('--OS', default="Ubuntu:22.04", type=str, help='OS version')
    parser.add_argument('--OpenCV_version', default="v4.8.0", type=str, help='OpenCV version')
    parser.add_argument('--OpenCV_install', default="Install", type=str, help='OpenCV install')
    parser.add_argument('--OpenCL', default="disabled", type=str, help='OpenCL')
    parser.add_argument('--Memory_Speed', default="3200MT/s", type=str, help='Memory Speed')
    parser.add_argument('--WW', default="WW40", type=str, help='Weeks')
    parser.add_argument('--CPU_req', default="2100MHz", type=str, help='CPU_req')




    args = parser.parse_args()
    main(args)
