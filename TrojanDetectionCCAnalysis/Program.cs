using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrojanDetectionCCAnalysis
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Console.Write("Enter result file filepath\n:  ");
            //string filepath = Console.ReadLine();
            string filepath = @"G:\My Drive\CMPE 691\hw4\HW4\out.txt";

            if (!File.Exists(filepath))
            {
                throw new FileNotFoundException(filepath);
            }

            // G:\My Drive\CMPE 691\hw4\HW4\out.txt
            string whole_file_text = File.ReadAllText(filepath);

            List<SingleReportItem> moduleReports = new List<SingleReportItem>();
            List<string> file_lines = whole_file_text.Split('\n').ToList();
            bool inside_module = false;

            SingleModuleReport new_report = new SingleModuleReport();

            foreach (string line in file_lines)
            {
                List<string> line_parts = line.Split(' ').ToList();
                line_parts = line_parts.Where(s => !string.IsNullOrWhiteSpace(s.Trim())).Distinct().ToList();

                int string_items = line_parts.Count;
                
                if (string_items > 3 && (
                        !(line_parts[0].Trim().Equals("PI") & line_parts[1].Trim().Equals("usage:")) &&
                        !(line_parts[0].Trim().Equals("set")) &&
                        !(line_parts[0].Trim().Equals("clr"))
                        )
                    )
                {


                    //check if is a new module
                    if (inside_module & string_items == 4)
                    {
                        inside_module = false;
                    }

                    if (!inside_module & string_items == 4)
                    {
                        new_report = new SingleModuleReport();
                        new_report.module_name = line_parts[0].Trim();
                        new_report.module_number = line_parts[1].Trim();
                        new_report.description = line_parts[2].Trim();
                        new_report.gate_primitive = line_parts[3].Trim();
                        inside_module = true;
                    }
                    else if (inside_module = true & string_items == 5 & !line_parts[1].Equals("---"))
                    {
                        SingleReport newSingleReport = new SingleReport();
                        line_parts[2] = line_parts[2].Remove(0, 1).Trim();
                        line_parts[3] = line_parts[3].Remove(line_parts[3].Length - 1, 1).Trim();

                        List<string> control_nums = line_parts[2].Split('-').ToList();

                        int CC0 = 0, CC1 = 0, C0 = 0;

                        if (control_nums[0].Equals("*")) CC0 = 255;
                        else int.TryParse(control_nums[0], out CC0);

                        if (control_nums[1].Equals("*")) CC1 = 255;
                        else int.TryParse(control_nums[1], out CC1);

                        if (control_nums[2].Equals("*")) C0 = 255;
                        else int.TryParse(control_nums[2], out C0);

                        newSingleReport.pin_name = line_parts[0].Trim();
                        newSingleReport.pin_type = line_parts[1].Trim();
                        
                        Controllability control = new Controllability(CC0, CC1, C0);
                        control.CCS = Math.Sqrt(Math.Pow(CC0, 2) + Math.Pow(CC1, 2));

                        newSingleReport.controllability = control;

                        newSingleReport.sequential_stability_parameters = line_parts[3].Trim();
                        newSingleReport.connected_net = line_parts[4].Trim();

                        moduleReports.Add(new SingleReportItem() { moduleReport = new_report, singleReport = newSingleReport });
                    }
                }
            }


            int itemsfound = moduleReports.Count;

            int number_of_items_wanted = 30;

            if (itemsfound < number_of_items_wanted)
                number_of_items_wanted = itemsfound;

            SingleReportItem[] top_module_reports = new SingleReportItem[number_of_items_wanted];
            double last_round_big = double.MaxValue;
            double round_big = 0;
            //2 loops
            //outer one just puts into array
            for (int i = 0; i < number_of_items_wanted; i++)
            {
                if (i > 0) last_round_big = top_module_reports[i - 1].singleReport.controllability.CCS;
                round_big = 0;
                SingleReportItem current_big_report = new SingleReportItem();

                foreach (SingleReportItem report in moduleReports)
                {
                    bool skip = false;
                    for (int j = 0; j < i; j++)
                    {
                        if (top_module_reports[j] == report)
                        {
                            skip = true;
                        }
                    }
                    if (!skip)
                    {
                        double current_CCS = report.singleReport.controllability.CCS;
                        if ((current_CCS < last_round_big) & (current_CCS > round_big))
                        {
                            round_big = current_CCS;
                            current_big_report = report;
                        }
                    }
                }
                top_module_reports[i] = current_big_report;
            }

            string output_filename = "top_likely_trojans";
        }
    }

    public class SingleReportItem
    {
        public SingleModuleReport moduleReport;
        public SingleReport singleReport;
    }

    public class SingleModuleReport
    {
        public string module_name;
        public string module_number;
        public string description;
        public string gate_primitive;
        //public List<SingleReport> single_reports = new List<SingleReport>();
    }

    public class SingleReport
    {
        public string pin_name;
        public string pin_type;
        public Controllability controllability;
        public string sequential_stability_parameters;
        public string connected_net;
    }

    public class Controllability
    {
        public int CC0;
        public int CC1;
        public int C0;
        public double CCS;

        public Controllability(int CC0, int CC1, int C0)
        {
            this.CC0 = CC0;
            this.CC1 = CC1;
            this.C0 = C0;
        }
    }
}
