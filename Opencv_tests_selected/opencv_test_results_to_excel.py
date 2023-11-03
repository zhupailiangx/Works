import argparse
import pandas as pd

def main(args):
    #print(args.File_Name.split(','))
    path_list= args.input_path.split(',')
    #print(path_list[0])
    if len(path_list)==1:
        try:
            df = pd.read_html(path_list[0])
        except:
            print("Error 1: File not found or failed to read file")
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
        print(df)
        df.to_excel(args.output_path,index=False)

        print("Run successfully")

    else:
        try:
            df = pd.read_html(path_list[0])
        except:
            print("Error 2: File not found or failed to read file")

        df = pd.DataFrame(df[0])

        df['Skew'] = args.Skew
        df['File Name'] = args.File_Name.split(',')[0]

        df['Memory type'] = args.Memory_type
        df['OS'] = args.OS
        df['OpenCV version'] = args.OpenCV_version
        df['OpenCV install'] = args.OpenCV_install
        df['OpenCL'] = args.OpenCL
        df['Memory Speed'] = args.Memory_Speed
        df['WW'] = args.WW
        df['CPU_req'] = args.CPU_req

        try:
            df_2 = pd.read_html(path_list[1])
        except:
            print("Error 3: File not found or failed to read file")

        df_2 = pd.DataFrame(df_2[0])
        #print(df_2)
        df_2['Skew'] = args.Skew
        df_2['File Name'] = args.File_Name.split(',')[1]
        #print(args.File_Name)
        df_2['Memory type'] = args.Memory_type
        df_2['OS'] = args.OS
        df_2['OpenCV version'] = args.OpenCV_version
        df_2['OpenCV install'] = args.OpenCV_install
        df_2['OpenCL'] = args.OpenCL
        df_2['Memory Speed'] = args.Memory_Speed
        df_2['WW'] = args.WW
        df_2['CPU_req'] = args.CPU_req

        
        try:
            df_3 = pd.read_html(path_list[2])
        except:
            print("Error 4: File not found or failed to read file")

        df_3 = pd.DataFrame(df_3[0])
        #print(df_2)
        df_3['Skew'] = args.Skew
        df_3['File Name'] = args.File_Name.split(',')[2]
        #print(args.File_Name)
        df_3['Memory type'] = args.Memory_type
        df_3['OS'] = args.OS
        df_3['OpenCV version'] = args.OpenCV_version
        df_3['OpenCV install'] = args.OpenCV_install
        df_3['OpenCL'] = args.OpenCL
        df_3['Memory Speed'] = args.Memory_Speed
        df_3['WW'] = args.WW
        df_3['CPU_req'] = args.CPU_req
         
        df_sort = pd.read_excel(args.opencv_lists)
         
        df_final= pd.concat([df,df_2,df_3])
        df_final = pd.merge(df_sort,df_final,on="Name of Test",how='left')
        
        df_final.to_excel(args.output_path, index=False)

        print("Run successfully")



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='opencv_tests')
    parser.add_argument('--input_path',default=r"core_imgproc_selecte.ods", type=str,help ='input ods files')
    parser.add_argument('--output_path',default = "../../opencv result data.xlsx", type=str,help='result excel file')
    parser.add_argument('--opencv_lists',default = "../../../opencv_test_lists.xlsx", type=str,help='result excel file')
    parser.add_argument('--Skew', default="12700", type=str, help='Machine type')
    parser.add_argument('--File_Name',default="core",type=str, action='store',help='Moudle')
    parser.add_argument('--Memory_type', default="DDR4", type=str, help='Memory type')
    parser.add_argument('--OS', default="Ubuntu:22.04", type=str, help='OS version')
    parser.add_argument('--OpenCV_version', default="v4.8.0", type=str, help='OpenCV version')
    parser.add_argument('--OpenCV_install', default="Install", type=str, help='OpenCV install')
    parser.add_argument('--OpenCL', default="disabled", type=str, help='OpenCL')
    parser.add_argument('--Memory_Speed', default="3200MT/s", type=str, help='Memory Speed')
    parser.add_argument('--WW', default="WW40", type=str, help='Weeks')
    parser.add_argument('--CPU_req', default=" ", type=str, help='CPU base frequency')




    args = parser.parse_args()
    main(args)

