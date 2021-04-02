using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace TrojanDetectionCCAnalysis
{
    public class Program
    {
        public static void Main(string[] args)
        {
            Console.WriteLine(@"ex. G:\My Drive\CMPE 491\HW4\out.txt");
            Console.Write("Enter result file filepath\n:  ");
            string filepath = Console.ReadLine();
            //G:\My Drive\CMPE 691\hw4\HW4\out.txt

            if (!File.Exists(filepath))
            {
                throw new FileNotFoundException(filepath);
            }

            // G:\My Drive\CMPE 691\hw4\HW4\out.txt
            string whole_file_text = File.ReadAllText(filepath);

            List<SingleModuleReport> moduleReports = new List<SingleModuleReport>();
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
                        moduleReports.Add(new_report);
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

                        new_report.single_reports.Add(newSingleReport);
                    }
                }
            }

            List<SingleReportItem> compare_results = new List<SingleReportItem>();
            foreach(SingleModuleReport moduleReport in moduleReports)
            {
                double sum_up_CCS = 0;
                int sum_CC0 = 0;
                int sum_CC1 = 0;

                foreach (SingleReport singleReport in moduleReport.single_reports)
                {
                    sum_up_CCS += singleReport.controllability.CCS;
                    sum_CC0 += singleReport.controllability.CC0;
                    sum_CC1 += singleReport.controllability.CC1;
                }

                double recalculated_sum_CCS = Math.Sqrt(Math.Pow(sum_CC0, 2) + Math.Pow(sum_CC1, 2));

                compare_results.Add(new SingleReportItem(moduleReport, recalculated_sum_CCS) { CCS_sum_add = sum_up_CCS});
            }


            int itemsfound = compare_results.Count;

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
                if (i > 0) last_round_big = top_module_reports[i - 1].CCS_sum;
                round_big = 0;
                top_module_reports[i] = new SingleReportItem();

                foreach (SingleReportItem report in compare_results)
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
                        double current_CCS = report.CCS_sum;
                        if ((current_CCS < last_round_big) & (current_CCS > round_big))
                        {
                            round_big = current_CCS;
                            top_module_reports[i].moduleReport = report.moduleReport;
                            top_module_reports[i].CCS_sum = current_CCS;
                        }
                    }
                }
            }

            string current_dir = Directory.GetCurrentDirectory();
            string output_filepath = $@"{current_dir}\top_likely_trojans.json";
            string full_output_filepath = $@"{current_dir}\full_program_output.json";

            var create_file = File.Create(output_filepath);
            create_file.Close();

            var create_file2 = File.Create(full_output_filepath);
            create_file2.Close();

            string pretty_full_report = PrettyJson(JsonConvert.SerializeObject(moduleReports));
            string pretty_top_report = PrettyJson(JsonConvert.SerializeObject(top_module_reports));

            File.WriteAllText(full_output_filepath, pretty_full_report);
            File.WriteAllText(output_filepath, pretty_top_report);
        }

        public static string PrettyJson(string unPrettyJson)
        {
            var options = new JsonSerializerOptions()
            {
                WriteIndented = true
            };

            var jsonElement = System.Text.Json.JsonSerializer.Deserialize<JsonElement>(unPrettyJson);

            return System.Text.Json.JsonSerializer.Serialize(jsonElement, options);
        }
    }

    public class SingleReportItem
    {
        [JsonProperty("module_info")]
        public SingleModuleReport moduleReport;
        
        [JsonProperty("ccs_sum_value")]
        public double CCS_sum;        

        [JsonIgnore]
        public double CCS_sum_add;

        public SingleReportItem()
        {
            this.moduleReport = new SingleModuleReport();
            this.CCS_sum = 0;
        }

        public SingleReportItem(SingleModuleReport moduleReport, double CCS_sum)
        {
            this.moduleReport = moduleReport;
            this.CCS_sum = CCS_sum;
        }
    }

    public class SingleModuleReport
    {
        public string module_name;
        public string module_number;
        public string description;
        public string gate_primitive;

        [JsonProperty("signal_level_report")]
        public List<SingleReport> single_reports = new List<SingleReport>();
    }

    public class SingleReport
    {
        public string pin_name;
        public string pin_type;
        public string connected_net;
        public Controllability controllability;

        [JsonIgnore]
        public string sequential_stability_parameters;
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
