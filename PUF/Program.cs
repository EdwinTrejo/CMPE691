using System;
using System.IO;

namespace PUF
{
    public class Program : constants
    {
        static void Main(string[] args)
        {
            string file_text = File.ReadAllText("results.txt");
            string[] file_lines = file_text.Split('\n');

            table[] file_data = new table[8];

            for (int i = 0; i < 8; i++)
            {
                file_data[i] = new table();
            }

            foreach (string line in file_lines)
            {
                string clean_line = line.Replace('\r', ' ');
                clean_line = clean_line.Trim();
                var items = clean_line.Split("	");

                if (items.Length > 5 && !clean_line.Contains("PUF"))
                {
                    int.TryParse(items[0], out int _tbl);
                    _tbl--;
                    int.TryParse(items[1], out int _row);
                    _row--;

                    int.TryParse(items[2], out int _v1);
                    int.TryParse(items[3], out int _v2);
                    int.TryParse(items[4], out int _v3);
                    int.TryParse(items[5], out int _v4);
                    int.TryParse(items[6], out int _v5);
                    int.TryParse(items[7], out int _v6);
                    int.TryParse(items[8], out int _v7);
                    int.TryParse(items[9], out int _v8);

                    file_data[_tbl].rows[_row] = new row()
                    {
                        PUF = _tbl,
                        Challenge = _row,
                        V1 = _v1,
                        V2 = _v2,
                        V3 = _v3,
                        V4 = _v4,
                        V5 = _v5,
                        V6 = _v6,
                        V7 = _v7,
                        V8 = _v8
                    };
                }
            }

            ChipResults[] chipResults = new ChipResults[CHIP_COUNT];

            for (int _chip = 0; _chip < CHIP_COUNT; _chip++)
            {
                chipResults[_chip] = new ChipResults();
                for (int _monteround = 0; _monteround < MONTEROUND_COUNT; _monteround++)
                {
                    for (int _challenge = 0; _challenge < CHALLENGE_COUNT; _challenge++)
                    {
                        chipResults[_chip].results[_challenge, _monteround] = GetBitFromRow(file_data[_monteround].rows[_challenge], _chip);
                    }
                }
            }



            //find intrahamming distance
            //file_data has 8 Chips (table) and 16 Challenges (row)
            //inside chip differences
            Console.WriteLine("Intra Hamming Distance");
            Console.WriteLine("Chip/Round\t1\t2\t3\t4\t5\t6\t7\t8");
            for (int _chip = 0; _chip < CHIP_COUNT; _chip++)
            {
                Console.Write($"Chip{(_chip + 1).ToString()}\t");
                //chipResults
                for (int _round = 0; _round < MONTEROUND_COUNT; _round++)
                {
                    double IntraHD = (double)ChipResults.GetMonteOnes(chipResults[_chip], _round);
                    IntraHD = (double)IntraHD / (double)MONTEROUND_COUNT;
                    Console.Write($"{IntraHD.ToString("N4")}\t");

                }
                Console.WriteLine();
            }

            //find interhamming distance
            Console.WriteLine("\nInter Hamming Distance");
            Console.WriteLine("Chip/Challenge\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t11\t12\t13\t14\t15\t16");
            for (int _chip = 0; _chip < CHIP_COUNT; _chip++)
            {
                Console.Write($"Chip{(_chip + 1).ToString()}\t\t");
                //chipResults
                for (int _challenge = 0; _challenge < CHALLENGE_COUNT; _challenge++)
                {
                    double IntraHD = (double)ChipResults.GetChallengeOnes(chipResults[_chip], _challenge);
                    IntraHD = (double)IntraHD / (double)CHALLENGE_COUNT;
                    Console.Write($"{IntraHD.ToString("N4")}\t");

                }
                Console.WriteLine();
            }

            /*
                Console.WriteLine("\tChip1\tChip2\tChip3\tChip4\tChip5\tChip6\tChip7\tChip8");
                for (int i = 0; i < 8; i++)
                {
                    Console.Write($"Chip{(i + 1).ToString()}\t");
                    for (int j = 0; j < 8; j++)
                    {
                        int _n11 = table.table_ones(file_data[i]);
                        int _n12 = table.table_ones(file_data[j]);

                        int dist = _n11 + _n12;
                        if (dist > BITS_COUNT)
                        {
                            dist = dist % BITS_COUNT;
                        }

                        if (i - j == 0) dist = _n11 - _n12;

                        double dist_float = (double)dist / (double)BITS_COUNT;

                        Console.Write($"{dist_float.ToString("N4")}\t");
                    }
                    Console.WriteLine();
                }

                //find interhamming distance
                Console.WriteLine("\nInter Hamming Distance");
                Console.WriteLine("\tChip1\tChip2\tChip3\tChip4\tChip5\tChip6\tChip7\tChip8");
                for (int i = 0; i < 8; i++)
                {
                    Console.Write($"Chip{(i + 1).ToString()}\t");
                    for (int j = 0; j < 8; j++)
                    {
                        int _n11 = table.challenge_table_ones(file_data, i, j);
                        int _n12 = table.challenge_table_ones(file_data, i, i);
                        int dist = _n11 + _n12;
                        if (dist > BITS_COUNT)
                        {
                            dist = dist % BITS_COUNT;
                        }

                        if (i - j == 0) dist = _n11 - _n12;

                        double dist_float = (double)dist / (double)BITS_COUNT;

                        Console.Write($"{dist_float.ToString("N4")}\t");
                    }

                    Console.WriteLine();
                }

                //find interhamming distance
                Console.WriteLine("\nInter Hamming Distance");
                Console.WriteLine("\tChip1\tChip2\tChip3\tChip4\tChip5\tChip6\tChip7\tChip8");

                //const double chips = 8;
                const double mult_val = (2 / (CHIPS * (CHIPS - 1)));

                for (int i = 0; i < 8; i++)
                {
                    Console.Write($"Chip{(i + 1).ToString()}\t");
                    for (int j = 0; j < 8; j++)
                    {
                        int _n11 = table.challenge_table_ones(file_data, i, j);
                        int _n12 = table.challenge_table_ones(file_data, i, i);
                        int dist = _n11 + _n12;

                        double dist_float = ((double)dist / (double)BITS_COUNT) * mult_val;

                        Console.Write($"{dist_float.ToString("N4")}\t");
                    }

                    Console.WriteLine();
                }
            */

            //find uniformity
            Console.WriteLine("\nUniformity");
            Console.WriteLine("\tChip1\tChip2\tChip3\tChip4\tChip5\tChip6\tChip7\tChip8");
            for (int i = 0; i < 8; i++)
            {
                Console.Write($"Chip{(i + 1).ToString()}\t");
                for (int j = 0; j < 8; j++)
                {
                    int _n11 = table.challenge_table_ones(file_data, i, j);
                    int _n12 = table.challenge_table_ones(file_data, i, i);

                    double dist_float = (double)ByteHammingDistance(_n11, _n12);

                    Console.Write($"{dist_float.ToString("N4")}\t");
                }
                Console.WriteLine();
            }
        }

        public static int GetBitFromRow(row _row, int _chip)
        {
            switch (_chip)
            {
                case 0:
                    {
                        if (_row.V1 == 1) return 1;
                        break;
                    }
                case 1:
                    {
                        if (_row.V2 == 1) return 1;
                        break;
                    }
                case 2:
                    {
                        if (_row.V3 == 1) return 1;
                        break;
                    }
                case 3:
                    {
                        if (_row.V4 == 1) return 1;
                        break;
                    }
                case 4:
                    {
                        if (_row.V5 == 1) return 1;
                        break;
                    }
                case 5:
                    {
                        if (_row.V6 == 1) return 1;
                        break;
                    }
                case 6:
                    {
                        if (_row.V7 == 1) return 1;
                        break;
                    }
                case 7:
                    {
                        if (_row.V8 == 1) return 1;
                        break;
                    }
            }
            return 0;
        }

        public static int ByteHammingDistance(row _row1, row _row2)
        {
            byte _n1 = GetBytes(RowToString(_row1));
            byte _n2 = GetBytes(RowToString(_row2));
            int x = _n1 ^ _n2;
            int setBits = 0;
            while (x > 0)
            {
                setBits += x & 1;
                x >>= 1;
            }
            return setBits;
        }

        public static int ByteHammingDistance(int _n1, int _n2)
        {
            int x = _n1 ^ _n2;
            int setBits = 0;
            while (x > 0)
            {
                setBits += x & 1;
                x >>= 1;
            }
            return setBits;
        }

        public static string RowToString(row _row)
        {
            string _str = $"{_row.V8.ToString()}{_row.V7.ToString()}{_row.V6.ToString()}{_row.V5.ToString()}{_row.V4.ToString()}{_row.V3.ToString()}{_row.V2.ToString()}{_row.V1.ToString()}";
            return _str;
        }

        public static byte GetBytes(string bitString)
        {
            byte[] output = new byte[bitString.Length / 8];

            for (int i = 0; i < output.Length; i++)
            {
                for (int b = 0; b <= 7; b++)
                {
                    output[i] |= (byte)((bitString[i * 8 + b] == '1' ? 1 : 0) << (7 - b));
                }
            }
            return output[0];
        }
    }

    public class ChipResults : constants
    {
        public int[,] results = new int[CHALLENGE_COUNT, MONTEROUND_COUNT];

        public static int GetChallengeOnes(ChipResults _res, int _challenge)
        {
            int _ret = 0;
            for (int _monteround = 0; _monteround < MONTEROUND_COUNT; _monteround++)
            {
                _ret = _ret + _res.results[_challenge, _monteround];
            }
            return _ret;
        }

        public static int GetMonteOnes(ChipResults _res, int _monteround)
        {
            int _ret = 0;
            for (int _challenge = 0; _challenge < CHALLENGE_COUNT; _challenge++)
            {
                _ret = _ret + _res.results[_challenge, _monteround];
            }
            return _ret;
        }
    }

    public class table : constants
    {
        public row[] rows = new row[CHALLENGE_COUNT];

        public table()
        {
            for (int i = 0; i < CHALLENGE_COUNT; i++)
            {
                rows[i] = new row();
            }
        }

        public static int table_ones(table _tbl)
        {
            row[] _rows = _tbl.rows;
            int _ones = 0;
            for (int i = 0; i < CHALLENGE_COUNT; i++)
            {
                _ones = _ones + row.ones_count(_rows[i]);
            }
            return _ones;
        }

        public static int challenge_table_ones(table[] _tbls, int chip, int PUFtest)
        {
            int _ones = 0;
            table _tbl = _tbls[PUFtest];

            foreach (row _row in _tbl.rows)
            {
                switch (chip)
                {
                    case 0:
                        {
                            if (_row.V1 == 1) _ones++;
                            break;
                        }
                    case 1:
                        {
                            if (_row.V2 == 1) _ones++;
                            break;
                        }
                    case 2:
                        {
                            if (_row.V3 == 1) _ones++;
                            break;
                        }
                    case 3:
                        {
                            if (_row.V4 == 1) _ones++;
                            break;
                        }
                    case 4:
                        {
                            if (_row.V5 == 1) _ones++;
                            break;
                        }
                    case 5:
                        {
                            if (_row.V6 == 1) _ones++;
                            break;
                        }
                    case 6:
                        {
                            if (_row.V7 == 1) _ones++;
                            break;
                        }
                    case 7:
                        {
                            if (_row.V8 == 1) _ones++;
                            break;
                        }
                }
            }
            return _ones;
        }
    }

    public class row : constants
    {
        public int PUF { get; set; }
        public int Challenge { get; set; }
        public int V1 { get; set; }
        public int V2 { get; set; }
        public int V3 { get; set; }
        public int V4 { get; set; }
        public int V5 { get; set; }
        public int V6 { get; set; }
        public int V7 { get; set; }
        public int V8 { get; set; }

        public static int ones_count(row _row)
        {
            int count = 0;
            if (_row.V1 == 1) count++;
            if (_row.V2 == 1) count++;
            if (_row.V3 == 1) count++;
            if (_row.V4 == 1) count++;
            if (_row.V5 == 1) count++;
            if (_row.V6 == 1) count++;
            if (_row.V7 == 1) count++;
            if (_row.V8 == 1) count++;
            return count;
        }

    }

    public class constants
    {
        public const double CHIPS = 8;
        public const int CHIP_COUNT = 8;
        public const int CHALLENGE_COUNT = 16;
        public const int MONTEROUND_COUNT = 8;
        public const int BITS_COUNT = CHALLENGE_COUNT * CHIP_COUNT;
    }

}
