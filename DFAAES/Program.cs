using System;
using System.Collections.Generic;
using System.IO;

namespace DFAAES
{
    public class Program
    {
        public enum sections { FaultFreeCiphertext, FirstFaultyCiphertext, SecondFaultyCiphertext, ThirdFaultyCiphertext, InputPlaintext }

        public static string[] sections_strings = { "FaultFreeCiphertext", "FirstFaultyCiphertext", "SecondFaultyCiphertext", "ThirdFaultyCiphertext", "Inputplaintext" };

        public static readonly int AMOUNT_OF_BLOCKS = 5;

        static void Main(string[] args)
        {
            string file_text = File.ReadAllText("input.txt");
            string[] file_lines = file_text.Split('\n');

            int FaultFreeCiphertextIndex = 0, FirstFaultyCiphertextIndex = 0, SecondFaultyCiphertextIndex = 0, ThirdFaultyCiphertextIndex = 0, InputPlaintextIndex = 0;
            int amount_of_lines = file_lines.Length;
            AESBlock[] input_blocks = new AESBlock[AMOUNT_OF_BLOCKS];

            for (int i = 0; i < amount_of_lines; i++)
            {
                if (file_lines[i].Contains(sections_strings[(int)sections.FaultFreeCiphertext]))
                {
                    FaultFreeCiphertextIndex = i;
                    Print(sections_strings[(int)sections.FaultFreeCiphertext]);
                    Print(i.ToString());
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.FaultFreeCiphertext] = AESBlock.ReadBlock(next_lines);
                    AESBlock.PrintBlock(input_blocks[(int)sections.FaultFreeCiphertext]);
                }
                else if (file_lines[i].Contains(sections_strings[(int)sections.FirstFaultyCiphertext]))
                {
                    FirstFaultyCiphertextIndex = i;
                    Print(sections_strings[(int)sections.FirstFaultyCiphertext]);
                    Print(i.ToString());
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.FirstFaultyCiphertext] = AESBlock.ReadBlock(next_lines);
                    AESBlock.PrintBlock(input_blocks[(int)sections.FirstFaultyCiphertext]);
                }
                else if (file_lines[i].Contains(sections_strings[(int)sections.SecondFaultyCiphertext]))
                {
                    SecondFaultyCiphertextIndex = i;
                    Print(sections_strings[(int)sections.SecondFaultyCiphertext]);
                    Print(i.ToString());
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.SecondFaultyCiphertext] = AESBlock.ReadBlock(next_lines);
                    AESBlock.PrintBlock(input_blocks[(int)sections.SecondFaultyCiphertext]);
                }
                else if (file_lines[i].Contains(sections_strings[(int)sections.ThirdFaultyCiphertext]))
                {
                    ThirdFaultyCiphertextIndex = i;
                    Print(sections_strings[(int)sections.ThirdFaultyCiphertext]);
                    Print(i.ToString());
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.ThirdFaultyCiphertext] = AESBlock.ReadBlock(next_lines);
                    AESBlock.PrintBlock(input_blocks[(int)sections.ThirdFaultyCiphertext]);
                }
                else if (file_lines[i].Contains(sections_strings[(int)sections.InputPlaintext]))
                {
                    InputPlaintextIndex = i;
                    Print(sections_strings[(int)sections.InputPlaintext]);
                    Print(i.ToString());
                    string[] next_lines = new string[AESBlock.ROW_SIZE] { file_lines[i + 1], file_lines[i + 2], file_lines[i + 3], file_lines[i + 4] };
                    input_blocks[(int)sections.InputPlaintext] = AESBlock.ReadBlock(next_lines);
                    AESBlock.PrintBlock(input_blocks[(int)sections.InputPlaintext]);
                }
            }
        }

        public static void Print(string print_str)
        {
            Console.WriteLine(print_str);
        }
    }

    public class AESBlock
    {
        public const int ROW_SIZE = 4;
        public const int COL_SIZE = 4;
        public byte[,] AESBlockArray = new byte[ROW_SIZE, COL_SIZE];

        public static AESBlock ReadBlock(string[] lines)
        {
            AESBlock ret_block = new AESBlock();
            for (int i = 0; i < ROW_SIZE; i++)
            {
                string[] bytes = lines[i].Split(' ');
                for (int j = 0; j < COL_SIZE; j++)
                {
                    bytes[j] = bytes[j].Replace('\r', ' ').Trim();
                    ret_block.AESBlockArray[i, j] = StringToByte(bytes[j]);
                }
            }
            return ret_block;
        }

        public static void PrintBlock(AESBlock block)
        {
            Console.WriteLine("Printing Block");
            for (int i = 0; i < ROW_SIZE; i++)
            {
                for (int j = 0; j < COL_SIZE; j++)
                {
                    Console.Write($"{block.AESBlockArray[i, j]} ");
                }
                Console.Write("\r\n");
            }
        }

        public static byte StringToByte(string str_byte)
        {
            byte ret_byte = Convert.ToByte(str_byte, 16);
            return ret_byte;
        }
    }
}
