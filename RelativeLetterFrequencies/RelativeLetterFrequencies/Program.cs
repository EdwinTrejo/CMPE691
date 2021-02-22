using System;
using System.Collections.Generic;
//using uint8_t = System.Uint8_t;
using uint8_t = System.Byte;

namespace RelativeLetterFrequencies
{
    class Program
    {
        const double A_freq = 0.0817;
        const double B_freq = 0.0150;
        const double C_freq = 0.0278;
        const double D_freq = 0.0425;
        const double E_freq = 0.1270;
        const double F_freq = 0.0223;
        const double G_freq = 0.0202;
        const double H_freq = 0.0609;
        const double I_freq = 0.0697;
        const double J_freq = 0.0015;
        const double K_freq = 0.0077;
        const double L_freq = 0.0403;
        const double M_freq = 0.0241;
        const double N_freq = 0.0675;
        const double O_freq = 0.0751;
        const double P_freq = 0.0193;
        const double Q_freq = 0.0010;
        const double R_freq = 0.0599;
        const double S_freq = 0.0633;
        const double T_freq = 0.0906;
        const double U_freq = 0.0276;
        const double V_freq = 0.0098;
        const double W_freq = 0.0236;
        const double X_freq = 0.0015;
        const double Y_freq = 0.0197;
        const double Z_freq = 0.0007;

        static double[] letter_frequencies = new double[26]
        {
            A_freq,
            B_freq,
            C_freq,
            D_freq,
            E_freq,
            F_freq,
            G_freq,
            H_freq,
            I_freq,
            J_freq,
            K_freq,
            L_freq,
            M_freq,
            N_freq,
            O_freq,
            P_freq,
            Q_freq,
            R_freq,
            S_freq,
            T_freq,
            U_freq,
            V_freq,
            W_freq,
            X_freq,
            Y_freq,
            Z_freq
        };

        const uint8_t MIN_CHARS = 0;
        const uint8_t MAX_CHARS = 25;
        const uint8_t MAX_STRINGS = 6;

        const string decrypt_string = "iq iuxx yqqf uz ftq yuppxq ar ftq xundmdk mf zaaz mxx mddmzsqyqzfe mdq ympq";

        static void Main(string[] args)
        {
            int countable_numbers = 0;
            uint8_t[] decrypt_string_frequencies = new uint8_t[26];
            uint8_t[] copy_string = new uint8_t[decrypt_string.Length];

            Console.WriteLine("Program Start");

            for (int i = 0; i < decrypt_string.Length; i++)
            {
                uint8_t current_char = Convert(decrypt_string[i]);
                uint8_t biga = Convert('A');
                uint8_t smalla = Convert('a');

                if (current_char >= 65 && current_char <= 90)
                {
                    copy_string[i] = Convert(current_char - biga);
                    int number = current_char - 65;
                    decrypt_string_frequencies[number]++;
                    countable_numbers++;
                }
                else if (current_char >= 97 && current_char <= 122)
                {
                    copy_string[i] = Convert(current_char - smalla);
                    int number = current_char - 97;
                    decrypt_string_frequencies[number]++;
                    countable_numbers++;
                }
                else
                {
                    copy_string[i] = current_char;
                }
            }

            //step1
            Console.WriteLine("Step 1:");
            //find 4 largest (i) values
            //find largest single ram, big ram, or tri gram
            //we only have single ram or english letter frequency
            double[] frequency_analysis = new double[26];
            for (uint8_t i = MIN_CHARS; i <= MAX_CHARS; i++)
            {
                //letter_frequencies
                //decrypt_string_frequencies
                frequency_analysis[i] = decrypt_string_frequencies[i] * letter_frequencies[i];
                Console.WriteLine($"\t{System.Convert.ToChar(i + 65)} Frequency: {decrypt_string_frequencies[i]}\t{frequency_analysis[i]}");
            }

            //step 2 compare normal frequencies
            Console.WriteLine("Step 2:");
            double[] frequency_analysis2 = new double[26];
            for (uint8_t i = MIN_CHARS; i <= MAX_CHARS; i++) frequency_analysis2[i] = 0;

            for (uint8_t i = MIN_CHARS; i <= MAX_CHARS; i++)
            {
                for (uint8_t j = MIN_CHARS; j <= MAX_CHARS; j++)
                {
                    //i is the current character
                    //j is the probability item
                    uint8_t current_probability = 0;
                    if ((j - i) >= 0)
                    {
                        current_probability = Convert(j - i);
                    }
                    else
                    {
                        current_probability = Convert(MAX_CHARS + j - i);
                    }

                    frequency_analysis2[i] += frequency_analysis[i] * letter_frequencies[current_probability];
                }
                Console.WriteLine($"\t{System.Convert.ToChar(i + 65)} Frequency diff: {frequency_analysis2[i]}");
            }

            //step 2a find 5 largest keys
            Console.WriteLine("Step 2a:");
            uint8_t[] best_keys = new uint8_t[MAX_STRINGS];
            double current_compare = double.MinValue;
            double last_compare = double.MaxValue;
            for (uint8_t i = 0; i < MAX_STRINGS; i++)
            {
                current_compare = double.MinValue;
                for (uint8_t j = MIN_CHARS; j <= MAX_CHARS; j++)
                {
                    if (i == 0 && frequency_analysis2[j] > current_compare)
                    {
                        current_compare = frequency_analysis2[j];
                        best_keys[i] = j;
                    }
                    else if (last_compare > frequency_analysis2[j] && frequency_analysis2[j] > current_compare)
                    {
                        current_compare = frequency_analysis2[j];
                        best_keys[i] = j;
                    }
                }
                last_compare = current_compare;
                Console.WriteLine($"\t{System.Convert.ToChar(Convert(best_keys[i] + 65))} with freq rating {current_compare}");
            }

            //step3
            //use the best 5 keys to find text
            List<List<char>> found_strings = new List<List<char>>();
            Console.WriteLine("Step 3:");
            for (uint8_t i = 0; i < MAX_STRINGS; i++)
            {
                List<char> new_string = new List<char>();
                for (uint8_t j = 0; j < Convert(copy_string.Length); j++)
                {
                    uint8_t current_string_char = copy_string[j];
                    if (current_string_char >= MIN_CHARS && current_string_char <= MAX_CHARS)
                    {
                        uint8_t number0 = Convert((current_string_char - best_keys[i] + 26) % 26);
                        number0 += 97;
                        new_string.Add(Convert(number0));
                    }
                    else
                    {
                        new_string.Add(Convert(current_string_char));
                    }
                }
                found_strings.Add(new_string);
            }

            int counter = 0;
            foreach (var string_val in found_strings)
            {
                Console.Write($"\t{System.Convert.ToChar(best_keys[counter] + 65)}:\t");
                foreach (var char_val in string_val)
                {
                    Console.Write(char_val);
                }
                Console.WriteLine();
                counter++;
            }
        }

        public static uint8_t Convert(int num)
        {
            return System.Convert.ToByte(num);
        }

        public static uint8_t Convert(char num)
        {
            return System.Convert.ToByte(num);
        }

        public static char Convert(uint8_t num)
        {
            return System.Convert.ToChar(num);
        }
    }
}