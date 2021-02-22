using System;
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

        const uint8_t MIN_CHARS = 0;
        const uint8_t MAX_CHARS = 25;

        const string decrypt_string = "iq iuxx yqqf uz ftq yuppxq ar ftq xundmdk mf zaaz mxx mddmzsqyqzfe mdq ympq";

        static void Main(string[] args)
        {
            uint8_t[] decrypt_string_frequencies =  new uint8_t[26];
            uint8_t[] copy_string = new uint8_t[decrypt_string.Length];

            Console.WriteLine("Hello World!");
        }
    }
}
