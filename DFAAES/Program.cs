using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.Json;

namespace DFAAES
{
    public class Program
    {
        public enum sections { FaultFreeCiphertext, FirstFaultyCiphertext, SecondFaultyCiphertext, ThirdFaultyCiphertext}

        public static string[] sections_strings = { "FaultFreeCiphertext", "FirstFaultyCiphertext", "SecondFaultyCiphertext", "ThirdFaultyCiphertext"};

        public static readonly int AMOUNT_OF_BLOCKS = 4;

        static void Main(string[] args)
        {
            string file_text = File.ReadAllText("input.txt");
            string[] file_lines = file_text.Split('\n');

            int FaultFreeCiphertextIndex = 0, FirstFaultyCiphertextIndex = 0, SecondFaultyCiphertextIndex = 0, ThirdFaultyCiphertextIndex = 0;
            int amount_of_lines = file_lines.Length;
            AESBlock[] input_blocks = new AESBlock[AMOUNT_OF_BLOCKS];
            DFAAESFunctions dFAAESFunctions = new DFAAESFunctions();

            for (int i = 0; i < amount_of_lines; i++)
            {
                if (file_lines[i].Contains(sections_strings[(int)sections.FaultFreeCiphertext]))
                {
                    FaultFreeCiphertextIndex = i;
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.FaultFreeCiphertext] = AESBlock.ReadBlock(next_lines);
#if DEBUG
                    Print(sections_strings[(int)sections.FaultFreeCiphertext]);
                    Print(i.ToString());
                    AESBlock.PrintBlock(input_blocks[(int)sections.FaultFreeCiphertext]);
#endif
                }
                else if (file_lines[i].Contains(sections_strings[(int)sections.FirstFaultyCiphertext]))
                {
                    FirstFaultyCiphertextIndex = i;
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.FirstFaultyCiphertext] = AESBlock.ReadBlock(next_lines);
#if DEBUG
                    Print(sections_strings[(int)sections.FirstFaultyCiphertext]);
                    Print(i.ToString());
                    AESBlock.PrintBlock(input_blocks[(int)sections.FirstFaultyCiphertext]);
#endif
                }
                else if (file_lines[i].Contains(sections_strings[(int)sections.SecondFaultyCiphertext]))
                {
                    SecondFaultyCiphertextIndex = i;
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.SecondFaultyCiphertext] = AESBlock.ReadBlock(next_lines);
#if DEBUG
                    Print(sections_strings[(int)sections.SecondFaultyCiphertext]);
                    Print(i.ToString());
                    AESBlock.PrintBlock(input_blocks[(int)sections.SecondFaultyCiphertext]);
#endif
                }
                else if (file_lines[i].Contains(sections_strings[(int)sections.ThirdFaultyCiphertext]))
                {
                    ThirdFaultyCiphertextIndex = i;
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.ThirdFaultyCiphertext] = AESBlock.ReadBlock(next_lines);
#if DEBUG
                    Print(sections_strings[(int)sections.ThirdFaultyCiphertext]);
                    Print(i.ToString());
                    AESBlock.PrintBlock(input_blocks[(int)sections.ThirdFaultyCiphertext]);
#endif
                }
            }

            //FIND FIRST FAULT KEY
            AESKeyBlock first_key = AESBlock.CalCulateKey(input_blocks[(int)sections.FaultFreeCiphertext], input_blocks[(int)sections.FirstFaultyCiphertext], dFAAESFunctions);
            AESKeyBlock.PrintAESKeyBlock(first_key);

            //FIND SECOND FAULT KEY
            AESKeyBlock second_key = AESBlock.CalCulateKey(input_blocks[(int)sections.FaultFreeCiphertext], input_blocks[(int)sections.SecondFaultyCiphertext], dFAAESFunctions);
            AESKeyBlock.PrintAESKeyBlock(second_key);

            //FIND SECOND FAULT KEY
            AESKeyBlock third_key = AESBlock.CalCulateKey(input_blocks[(int)sections.FaultFreeCiphertext], input_blocks[(int)sections.ThirdFaultyCiphertext], dFAAESFunctions);
            AESKeyBlock.PrintAESKeyBlock(third_key);

            string additional_notes = "Rows first then the item follows Column order\n";

            string pretty_full_report = additional_notes
                + "\nFirst Faulty Ciphertext\n"
                + PrettyJson(JsonConvert.SerializeObject(first_key))
                + "\nSecond Faulty Ciphertext\n"
                + PrettyJson(JsonConvert.SerializeObject(second_key))
                + "\nThird Faulty Ciphertext\n"
                + PrettyJson(JsonConvert.SerializeObject(third_key));

            string current_dir = Directory.GetCurrentDirectory();
            string full_output_filepath = $@"{current_dir}\full_program_output.json";
            File.WriteAllText(full_output_filepath, pretty_full_report);
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

        public static void Print(string print_str)
        {
            Console.WriteLine(print_str);
        }
    }

    public class DFAAESFunctions : Constants
    {
        // cast is not redundant
        [JsonIgnore]
        public readonly byte[] Faults = new byte[] { (byte)1, (byte)2, (byte)4, (byte)8, (byte)16, (byte)32, (byte)64, (byte)128 };

        [JsonIgnore]
        public const byte MIN_M = (byte)0;

        [JsonIgnore]
        public const byte MAX_M = (byte)255;

        [JsonIgnore]
        public static List<DFATable> DFAValues = new List<DFATable>();

        public DFAAESFunctions()
        {
            //generate DFA TABLES
            foreach (byte F in Faults)
            {
                for (byte M = MIN_M; M < MAX_M; M++)
                {
                    DFATable dFATable = new DFATable();
                    dFATable.F = F;
                    dFATable.M = M;
                    dFATable.Result = (byte)(GetSBoxValue(M) ^ GetSBoxValue((byte)(M ^ F)));
                    DFAValues.Add(dFATable);
                }
            }
        }

        public DFATable GetMValue(byte CXORD_val)
        {
            IEnumerable<DFATable> M_fits_the_xor = from table in DFAValues
                                                   where table.Result == CXORD_val
                                                   select table;
            return M_fits_the_xor.FirstOrDefault();
        }
    }

    public class DFATable
    {
        /// <summary>
        /// possible key value
        /// 0-255
        /// </summary>
        public byte M;

        /// <summary>
        /// Fault Value
        /// 1,2,4,8,16,32,64,128
        /// </summary>
        public byte F;

        /// <summary>
        /// subbyte(M) ^ subbyte(M ^ F)
        /// </summary>
        public byte Result;
    }

    public class AESBlock : Constants
    {
        [JsonProperty("key_round_number")]
        public int key_round_number;

        [JsonProperty("Rows")]
        public byte[,] block = new byte[ROW_SIZE, COL_SIZE];

        public static AESBlock ReadBlock(string[] lines)
        {
            AESBlock ret_block = new AESBlock();
            for (int row = 0; row < ROW_SIZE; row++)
            {
                string[] bytes = lines[row].Split(' ');
                for (int col = 0; col < COL_SIZE; col++)
                {
                    bytes[col] = bytes[col].Replace('\r', ' ').Trim();
                    ret_block.block[row, col] = StringToByte(bytes[col]);
                }
            }
            return ret_block;
        }

        public static void PrintBlock(AESBlock block)
        {
            for (int row = 0; row < ROW_SIZE; row++)
            {
                for (int col = 0; col < COL_SIZE; col++)
                {
                    byte[] new_arr = new byte[] { block.block[row, col] };
                    Console.Write($"{BitConverter.ToString(new_arr)} ");
                }
                Console.Write("\r\n");
            }
            Console.WriteLine();
        }

        public static AESKeyBlock CalCulateKey(AESBlock fault_free, AESBlock faulty, DFAAESFunctions dFAAESFunctions)
        {
            //xor CXORD
            AESBlock CXORD = fault_free ^ faulty;
            Console.WriteLine("CXORD");
            PrintBlock(CXORD);

            //get M value
            AESBlock M_values = new AESBlock();
            for (int row = 0; row < ROW_SIZE; row++)
            {
                for (int col = 0; col < COL_SIZE; col++)
                {
                    M_values.block[row, col] = dFAAESFunctions.GetMValue(CXORD.block[row, col]).M;
                }
            }
            Console.WriteLine("M_values");
            PrintBlock(M_values);

            //K  = C ^ ShiftRows(SubBytes(M))
            AESBlock K = fault_free ^ ShiftRows(SubBytes(M_values));
            Console.WriteLine("K");
            PrintBlock(K);

            //reverse key
            Console.WriteLine("Reverse Key");
            AESKeyBlock round_keys = new AESKeyBlock();
            round_keys = AESKeyBlock.InverseKeyExpansion(K);
            return round_keys;
        }

        private static AESBlock InverseSubBytes(AESBlock current_block)
        {
            AESBlock backwards_operation = new AESBlock();

            for (int row = 0; row < ROW_SIZE; row++)
            {
                for (int col = 0; col < COL_SIZE; col++)
                {
                    backwards_operation.block[row, col] = InverseGetSBoxValue(current_block.block[row, col]);
                }
            }

            return backwards_operation;
        }

        private static AESBlock SubBytes(AESBlock current_block)
        {
            AESBlock backwards_operation = new AESBlock();

            for (int row = 0; row < ROW_SIZE; row++)
            {
                for (int col = 0; col < COL_SIZE; col++)
                {
                    backwards_operation.block[row, col] = GetSBoxValue(current_block.block[row, col]);
                }
            }
            return backwards_operation;
        }

        private static AESBlock InverseShiftRows(AESBlock current_block)
        {
            AESBlock backwards_operation = new AESBlock();
            //[row, col]
            backwards_operation.block[0, 0] = current_block.block[0, 0];
            backwards_operation.block[0, 1] = current_block.block[0, 1];
            backwards_operation.block[0, 2] = current_block.block[0, 2];
            backwards_operation.block[0, 3] = current_block.block[0, 3];

            backwards_operation.block[1, 0] = current_block.block[1, 3];
            backwards_operation.block[1, 1] = current_block.block[1, 0];
            backwards_operation.block[1, 2] = current_block.block[1, 1];
            backwards_operation.block[1, 3] = current_block.block[1, 2];

            backwards_operation.block[2, 0] = current_block.block[2, 2];
            backwards_operation.block[2, 1] = current_block.block[2, 3];
            backwards_operation.block[2, 2] = current_block.block[2, 0];
            backwards_operation.block[2, 3] = current_block.block[2, 1];

            backwards_operation.block[3, 0] = current_block.block[3, 1];
            backwards_operation.block[3, 1] = current_block.block[3, 2];
            backwards_operation.block[3, 2] = current_block.block[3, 3];
            backwards_operation.block[3, 3] = current_block.block[3, 0];

            return backwards_operation;
        }

        private static AESBlock ShiftRows(AESBlock current_block)
        {
            AESBlock backwards_operation = new AESBlock();
            //[row, col]
            backwards_operation.block[0, 0] = current_block.block[0, 0];
            backwards_operation.block[0, 1] = current_block.block[0, 1];
            backwards_operation.block[0, 2] = current_block.block[0, 2];
            backwards_operation.block[0, 3] = current_block.block[0, 3];

            backwards_operation.block[1, 0] = current_block.block[1, 1];
            backwards_operation.block[1, 1] = current_block.block[1, 2];
            backwards_operation.block[1, 2] = current_block.block[1, 3];
            backwards_operation.block[1, 3] = current_block.block[1, 0];

            backwards_operation.block[2, 0] = current_block.block[2, 2];
            backwards_operation.block[2, 1] = current_block.block[2, 3];
            backwards_operation.block[2, 2] = current_block.block[2, 0];
            backwards_operation.block[2, 3] = current_block.block[2, 1];

            backwards_operation.block[3, 0] = current_block.block[3, 3];
            backwards_operation.block[3, 1] = current_block.block[3, 0];
            backwards_operation.block[3, 2] = current_block.block[3, 1];
            backwards_operation.block[3, 3] = current_block.block[3, 2];

            return backwards_operation;
        }

        public static AESBlock operator ^(AESBlock block_A, AESBlock block_B)
        {
            AESBlock backwards_operation = new AESBlock();
            for (int row = 0; row < ROW_SIZE; row++)
            {
                for (int col = 0; col < COL_SIZE; col++)
                {
                    byte A = block_A.block[row, col];
                    byte B = block_B.block[row, col];
                    byte C = (byte)(A ^ B);
                    backwards_operation.block[row, col] = C;
                }
            }
            return backwards_operation;
        }

        public static byte StringToByte(string str_byte)
        {
            byte ret_byte = Convert.ToByte(str_byte, 16);
            return ret_byte;
        }
    }

    public class AESKeyBlock : Constants
    {
        /*
         * My C key expansion code
         //unsigned long w[44] = { 0 };
	unsigned long temp = 0;
	byte i = 0;

	for (i = 0; i < 4; i++)
	{
		temp = key[4 * i];
		temp = temp << 8;
		temp += key[4 * i + 1];
		temp = temp << 8;
		temp += key[4 * i + 2];
		temp = temp << 8;
		temp += key[4 * i + 3];
		w[i] = temp;
	}

	//the rest of the blocks
	for (i = 4; i < 44; i++)
	{
		temp = w[i - 1];
		if ((i % 4) == 0)
		{
			temp = RotWord(temp);
			temp = SubWord(temp);
			temp = temp ^ Rcon[i / 4];
		}
		//unsigned long val = w[i - 4];
		w[i] = w[i - 4] ^ temp;
	}
	//return w;
         */

        public AESBlock[] blocks = new AESBlock[KEY_BLOCKS];

        public static void PrintAESKeyBlock(AESKeyBlock blocks)
        {
            foreach(var block in blocks.blocks)
            {
                Console.WriteLine(block.key_round_number.ToString());
                AESBlock.PrintBlock(block);
            }
        }

        public static AESKeyBlock InverseKeyExpansion(AESBlock last_round_key)
        {
            AESKeyBlock ret_block = new AESKeyBlock();
            //Word order MSB at 0 LSB at 3 in single uint32
            //W0 is 3,0 2,0 1,0 0,0
            //W1 is 3,1 2,1 1,1 0,1
            //W2 is 3,2 2,2 1,2 0,2
            //W3 is 3,3 2,3 1,3 0,3

            //0 is round 10
            //9 is round 0
            ret_block.blocks[0] = last_round_key;
            ret_block.blocks[0].key_round_number = 10;
            
            //0 - 8 or 9
            for (byte i = 0; i < KEY_BLOCKS - 1; i++)
            {
                //previous round
                byte[] PW0 = GetColumn(ret_block.blocks[i], 0);
                byte[] PW1 = GetColumn(ret_block.blocks[i], 1);
                byte[] PW2 = GetColumn(ret_block.blocks[i], 2);
                byte[] PW3 = GetColumn(ret_block.blocks[i], 3);

                //undo Rcon
                byte[] W0 = InverseRcon(PW0, i);
                byte[] W1 = InverseRcon(PW1, i);
                byte[] W2 = InverseRcon(PW2, i);
                byte[] W3 = InverseRcon(PW3, i);

                //undo subword and rotword for msb W3
                byte[] NW3 = InverseSubWord(W0);
                NW3 = InverseRotWord(NW3);

                AESBlock new_block = new AESBlock();
                new_block = InsertColumn(NW3, 3, new_block);
                new_block = InsertColumn(W2, 2, new_block);
                new_block = InsertColumn(W1, 1, new_block);
                new_block = InsertColumn(W0, 0, new_block);
                new_block.key_round_number = 10 - i - 1;

                ret_block.blocks[i + 1] = new_block;
            }

            return ret_block;
        }

        public static byte[] InverseSubWord(byte[] word)
        {
            byte[] ret_word = new byte[COL_SIZE];
            for (int col = 0; col < COL_SIZE; col++)
            {
                ret_word[col] = InverseGetSBoxValue(word[col]);
            }
            return ret_word;
        }

        public static byte[] InverseRotWord(byte[] word)
        {
            byte[] ret_word = new byte[COL_SIZE];
            //MSB 0 LSB 3
            //0 1 //1 2 //2 3 //3 0 
            ret_word[3] = word[0];
            ret_word[2] = word[3];
            ret_word[1] = word[2];
            ret_word[0] = word[1];
            return ret_word;
        }

        /// <summary>
        /// Rounds 0 will use key 10
        /// </summary>
        /// <param name="round"></param>
        /// <param name="round_number"></param>
        /// <returns></returns>
        public static byte[] InverseRcon(byte[] curr_col, byte round_number)
        {
            UInt32 rcon_val = GetRcon(round_number);
            UInt32 col_word = BytesToWord(curr_col);
            UInt32 xor_val = rcon_val ^ col_word;
            return WordToBytes(xor_val);
        }

        private static byte[] GetColumn(AESBlock block, byte col)
        {
            //0 x
            //1 x
            //2 x
            //3 x
            return new byte[] { block.block[3, col], block.block[2, col], block.block[1, col], block.block[0, col] };
        }

        private static byte[] GetRow(AESBlock block, byte row)
        {
            return new byte[] { block.block[row, 3], block.block[row, 2], block.block[row, 1], block.block[row, 0] };
        }

        private static AESBlock InsertColumn(byte[] cols, byte col, AESBlock prev_block)
        {
            //0 -> 3 lsb
            //3 -> 1 msb
            AESBlock modify_block = prev_block;
            modify_block.block[0, col] = cols[3];
            modify_block.block[1, col] = cols[2];
            modify_block.block[2, col] = cols[1];
            modify_block.block[3, col] = cols[0];
            return modify_block;
        }

        private static AESBlock InsertRow(byte[] rows, byte row, AESBlock prev_block)
        {
            AESBlock modify_block = prev_block;
            modify_block.block[row, 0] = rows[0];
            modify_block.block[row, 1] = rows[1];
            modify_block.block[row, 2] = rows[2];
            modify_block.block[row, 3] = rows[3];
            return modify_block;
        }
    }

    public abstract class Constants
    {
        [JsonIgnore]
        public const int KEY_BLOCKS = 10;

        [JsonIgnore]
        public const int ROW_SIZE = 4;

        [JsonIgnore]
        public const int COL_SIZE = 4;

        [JsonIgnore]
        public static byte[] sbox = new byte[]
        {
		    //0     1    2      3     4    5     6     7      8    9     A      B    C     D     E     F
		    0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
            0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
            0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
            0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
            0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
            0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
            0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
            0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
            0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
            0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
            0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
            0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
            0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
            0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
            0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
            0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
        };

        [JsonIgnore]
        public static byte[] rsbox = new byte[]
        {
            0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38, 0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb,
            0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87, 0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb,
            0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d, 0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e,
            0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2, 0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25,
            0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92,
            0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda, 0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84,
            0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a, 0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06,
            0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02, 0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b,
            0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea, 0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73,
            0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85, 0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e,
            0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89, 0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b,
            0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20, 0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4,
            0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31, 0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f,
            0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d, 0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef,
            0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0, 0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61,
            0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26, 0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
        };

        [JsonIgnore]
        public static UInt32[] Rcon = new UInt32[]
        {
            0x8d000000,
            0x01000000,
            0x02000000,
            0x04000000,
            0x08000000,
            0x10000000,
            0x20000000,
            0x40000000,
            0x80000000,
            0x1b000000,
            0x36000000
        };

        public static byte GetSBoxValue(byte number)
        {
            return sbox[number];
        }

        public static byte InverseGetSBoxValue(byte number)
        {
            return rsbox[number];
        }

        public static UInt32 BytesToWord(byte[] bytes)
        {
            UInt32 ret_word = 0;
            ret_word = (UInt32)((bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | (bytes[3] << 0));
            return ret_word;
        }

        public static UInt32 GetRcon(byte round)
        {
            //10-0=10  //round 10
            //10-9=1   //round 1
            //Rconn 0 is just a placeholder
            return Rcon[(10 - round)];
        }

        public static byte[] WordToBytes(UInt32 word)
        {
            byte[] return_bytes = new byte[ROW_SIZE];
            return_bytes[0] = (byte)(word >> 24);
            word = word << 8;
            return_bytes[1] = (byte)(word >> 24);
            word = word << 8;
            return_bytes[2] = (byte)(word >> 24);
            word = word << 8;
            return_bytes[3] = (byte)(word >> 24);
            return return_bytes;
        }
    }
}
