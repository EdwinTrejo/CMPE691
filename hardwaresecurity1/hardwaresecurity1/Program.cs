using System;

namespace hardwaresecurity1
{
    class Program
    {
        static void Main(string[] args)
        {
            //for (int i = 0; i < 80; i++)
            //{
            //    Console.WriteLine($"`define pos_{i + 1} {((i + 1) * 8) - 1}:{(i) * 8}");
            //}

            //for (int i = 0; i < 80; i++)
            //{
            //    Console.WriteLine($"`define poshigh_{i + 1} {((i + 1) * 8) - 1}");
            //    Console.WriteLine($"`define poslow_{i + 1} {(i) * 8}");
            //}

            for (int i = 0; i < 80; i++)
            {
                //    //Console.WriteLine($"blockram_key[{i}] = resized_key[`pos_{i + 1}];");
                //    //Console.WriteLine($"blockram_message[{i}] = message_in[`pos_{i + 1}];");
                //Console.WriteLine($"plaintext_block[{i}] = plaintext[`pos_{i + 1}];");
                //Console.WriteLine($"blockram_message[{79 - i}] = message_in[`pos_{i + 1}];");
                //Console.WriteLine($"reverse_message_out[`poshigh_{80 - i}:`poslow_{80 - i}] = message_out[`poslow_{i + 1}:`poshigh_{i + 1}];");
                Console.WriteLine($"key[`pos_{80 - i}] = reverse_return_key[{i}];");
                //Console.WriteLine($"reverse_message_out[{i}] = message_out[`poslow_{i + 1}:`poshigh_{i + 1}];");
                ////Console.WriteLine($"message_out[`pos_{i + 1}] = blockram_message_out[{i}];");
            }


            //for (int j = 0; j < 4; j++)
            //{
            //    //Console.Write($"assign line{j + 1}_words = ");
            //    //Console.Write("{");

            //    for (int i = 0; i < 5*8; i++)
            //    {
            //        int high = ((i + 1) * 8) - 1;
            //        int low = i * 8;
            //        Console.Write($"line{j + 1}_block[{i}] = line{j + 1}[{high}:{low}]; ");
            //    }
            //    Console.WriteLine("");
            //}

            //for (int i = 65; i < 91; i++)
            //{
            //    //32
            //    Console.WriteLine($"8'd{i}: begin");
            //    Console.WriteLine($"    blockram_message_out[i] = {Convert.ToChar(i + 32)}_replace[blockram_key[i] - number0];");
            //    Console.WriteLine($"end");
            //    Console.WriteLine($"8'd{i + 32}: begin");
            //    Console.WriteLine($"    blockram_message_out[i] = {Convert.ToChar(i + 32)}_replace[blockram_key[i] - number0];");
            //    Console.WriteLine($"end");
            //}


            ///decryption
            //int countdown = 26;
            //for (int i = 65; i < 91; i++)
            //{
            //    //32
            //    Console.WriteLine($"8'd{i}, 8'd{i + 32} : begin");
            //    //Console.WriteLine($"    blockram_message_out[i] = {Convert.ToChar(i + 32)}_replace[number1:number2];");
            //    Console.WriteLine("    case (number0)");
            //    countdown = 26;

            //    for (int j = 65; j < 91; j++)
            //    {
            //        Console.WriteLine($"        {j - 65}: begin");
            //        Console.WriteLine($"            blockram_message_out[i] = {j/* + 32*/};");
            //        Console.WriteLine($"        end");
            //    }
            //    Console.WriteLine("    endcase");
            //    Console.WriteLine($"end");
            //}

            ///encryption

            //int countdown = 26;
            //for (int i = 65; i < 91; i++)
            //{
            //    //32
            //    //Console.WriteLine($"8'd{i}: begin");
            //    //Console.WriteLine($"    blockram_message_out[i] = {Convert.ToChar(i + 32)}_replace[blockram_key[i] - number0];");
            //    //Console.WriteLine($"end");
            //    //Console.WriteLine($"8'd{i + 32}: begin");
            //    //Console.WriteLine($"    blockram_message_out[i] = {Convert.ToChar(i + 32)}_replace[blockram_key[i] - number0];");
            //    //Console.WriteLine($"end");

            //    Console.WriteLine($"8'd{i}, 8'd{i + 32} : begin");
            //    //Console.WriteLine($"    blockram_message_out[i] = {Convert.ToChar(i + 32)}_replace[number1:number2];");
            //    Console.WriteLine("    case (number0)");
            //    countdown = 26;

            //    for (int j = 65; j < 91; j++)
            //    {
            //        Console.WriteLine($"        {j - 65}: begin");
            //        Console.WriteLine($"            blockram_message_out[i] = {Convert.ToChar(i + 32)}_replace[`poshigh_{countdown}:`poslow_{countdown--}];");
            //        Console.WriteLine($"        end");
            //    }
            //    Console.WriteLine("    endcase");
            //    Console.WriteLine($"end");

            //    //Console.WriteLine($"{i - 65}: begin");
            //    //Console.WriteLine($"    number1 = `poshigh_{countdown};");
            //    //Console.WriteLine($"    number2 = `poslow_{countdown--};");
            //    //Console.WriteLine($"end");
            //}

            //int count = 1;
            //for (int i = 65 + 32; i < 91 + 32; i++)
            //{
            //    //32
            //    Console.WriteLine($"{Convert.ToChar(i)}\t{Convert.ToChar(i+1)}");
            //}
        }
    }
}